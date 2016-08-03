defmodule Chromecast do
    require Logger
    use GenServer
    use Protobuf, from: Path.expand("../proto/cast_channel.proto", __DIR__)

    defmodule State do
        defstruct media_session: nil,
            session: nil,
            destination_id: nil,
            ssl: nil
    end

    @namespace %{
        :con => "urn:x-cast:com.google.cast.tp.connection",
        :receiver => "urn:x-cast:com.google.cast.receiver",
        :cast => "urn:x-cast:com.google.cast.media",
        :heartbeat =>  "urn:x-cast:com.google.cast.tp.heartbeat",
        :message => "urn:x-cast:com.google.cast.player.message",
        :media => "urn:x-cast:com.google.cast.media",
        :youtube => "urn:x-cast:com.google.youtube.mdx",
    }

    def start_link do
        GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    end

    def create_message(namespace, payload, destination \\ "receiver-0") when payload |> is_map do
        Chromecast.CastMessage.new(
            protocol_version: :CASTV2_1_0,
            source_id: "sender-0",
            destination_id: destination,
            payload_type: :STRING,
            namespace: @namespace[namespace],
            payload_utf8: Poison.encode!(payload)
        )
    end

    def play do
        GenServer.call(__MODULE__, :play)
    end

    def connect_channel do
        GenServer.call(__MODULE__, :connect_channel)
    end

    def encode(msg) do
        m = Chromecast.CastMessage.encode(msg)
        << byte_size(m)::big-unsigned-integer-size(32) >> <> m
    end

    def decode(msg) do
        << length::big-unsigned-integer-size(32), rest::binary >> = msg
        Chromecast.CastMessage.decode(rest)
    end

    def send(msg) do
        GenServer.call(__MODULE__, {:send, msg})
    end

    def init(:ok) do
        {:ok, ssl} = :ssl.connect({192,168,1,138}, 8009, [:binary, {:reuseaddr, true}], :infinity)
        Process.send_after(self, :connect, 100)
        {:ok, %State{:ssl => ssl}}
    end

    def handle_info(:connect, state) do
        con = create_message(:con, %{:type => "CONNECT", :origin => %{}})
        :ssl.send(state.ssl, encode(con))
        status = create_message(:receiver, %{:type => "GET_STATUS", :requestId => 0})
        :ssl.send(state.ssl, encode(status))
        {:noreply, state}
    end

    def handle_call(:connect_channel, _from, state) do
        con = create_message(:con, %{:type => "CONNECT", :origin => %{}}, state.destination_id)
        :ssl.send(state.ssl, encode(con))
        {:reply, :ok, state}
    end

    def handle_info({:ssl, {sslsocket, new_ssl, _}, data}, state) do
        msg = decode(data)
        payload = Poison.Parser.parse!(msg.payload_utf8) |> IO.inspect
        new_state =
            case payload do
                %{ "type" => "PING" } ->
                    msg = create_message(:heartbeat, %{"type" => "PONG"}) |> encode
                    case :ssl.send(state.ssl, msg) do
                        :ok -> nil
                        {:error, reason} -> Logger.info "Error: #{inspect reason}"
                    end
                    state
                %{ "type" => "RECEIVER_STATUS" } ->
                    case payload["status"]["applications"] do
                        nil -> state
                        other ->
                            app = Enum.at(other, 0)
                            %State{state | :destination_id => app["transportId"], :session => app["sessionId"]}
                    end
                %{ "type" => "MEDIA_STATUS" } -> state
                _ -> state
            end
        IO.inspect new_state
        {:noreply, new_state}
    end

    def handle_info({:ssl_closed, _}, {:sslsocket, _, state}) do
        Logger.info("SSL Connection Closed. Re-opening...")
        {:ok, ssl} = :ssl.connect({192,168,1,138}, 8009, [:binary, {:reuseaddr, true}], :infinity)
        Logger.info("Opened")
        {:noreply, %State{state | :ssl => ssl}}
    end
end
