# Chromecast

A library for controlling and monitoring a [Chromecast](https://www.google.com/intl/en_us/chromecast/).
It currently only supports pause/play/volume, but also keeps track of the state of the device, such as media type, playback position, background images, etc. There is no support for queuing or playing new media files.

## Installation

    1. git clone https://github.com/NationalAssociationOfRealtors/chromecast.git
    2. mix do deps.get, deps.compile
    3. iex -S mix

## Usage

    iex(4)> {:ok, device} = Chromecast.start_link {192,168,1,138}
    {:ok, #PID<0.225.0>}

##### Idle Screen with background images

    iex(7)> Chromecast.state(device)
    %Chromecast.State{destination_id: "web-5", ip: {192, 168, 1, 138},
     media_session: nil,
     media_status: %{"appDeviceId" => "BBC9E06BCA89EA246A21D650BE44BA52",
       "backendData" => "[\"https://lh3.googleusercontent.com/mij2Eglc324jD_kxhu43aSnX8w9Xfr7XQdEwLpWpiVoFWZSh8Ljj=s1920-w1920-h1080-p-k-no-nd-mv\",\"Justin Brown\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/101005060236931055507/albums/5720519753508285169/6122212643311873906\",null,null,\"Photo by Justin Brown\",null,[[\"New York City, NY\",\"https://www.google.com/search?q=New+York+City%2C+New+York\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipPSuE14ATWH-FwoO3DGJyiyewcTORhjDEuFTF__\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],1293145096798261,[9700053]]",
       "numLinkedUsers" => 0, "requestId" => "0",
       "topicHistory" => ["[\"https://lh3.googleusercontent.com/proxy/GUfWvBxLY7h8Li2oVoqt5QMs8h6heAX-TTnlKUKND1JCbg2MKPD9yi1QzUXhp3oEWbpfkRp8MWRepmgYBMOm5vNn4O2F1XCCoWG37QCbweiYEJ8mTj_aknB0306wcWfqcSuo7gc6ZOdO2mOod9lnaX453YPntwNsNws4Ux_g=s1920-w1920-h1080-n-k-no-nd-mv\",null,null,null,120,11,null,null,null,\"https://500px.com/photo/105754217/gravity-chamber-by-alex-noriega?utm_source=google&utm_medium=chromecast&utm_campaign=september_launch\",null,null,\"Photo by Alex Noriega\",null,[],null,0,\"FEATURED_500PX_TITLE\",\"0312daec19f4b4cb0ccf374d83a605e3\",null,null,0,null,null,null,47,[[47,\"FEATURED_500PX_TITLE\",\"500px\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],-7860625334833097,[9700053]]",
        "[\"https://lh3.googleusercontent.com/NcFlzZdTZazuc1FH1vuyExOFYMdz6rKtMrtdtghDJ_ScngVdnmWmgwxffJbyWRWfq-tvVFT5zZvtHWpeXvw=s1920-w1920-h1080-p-k-no-nd-mv\",\"Robin Griggs Wood\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/103698889037599783920/albums/5893830837236231873/6286435320971968402\",null,null,\"Photo by Robin Griggs Wood\",null,[[\"Palace of Fine Arts, San Francisco, California\",\"https://www.google.com/search?q=Palace+of+Fine+Arts%2C+San+Francisco\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipMKwdLuP0T3JWxRBCBiDGJxXNmSxTOIaAHM7Gxe\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],5097477668030082,[9700053]]",
        "[\"https://lh5.googleusercontent.com/proxy/vkAEc_MrmRauQq8jR40hx_yh-ExzYSupzCaA3uKbLv6MKhRFd4tit_f1CTneIYHT7vYkgbPANzXQ0vuYzXm1WLpUyTFHv0Vcj13gH9Ibr_z9AJR0SrTQ2hmfXz7isqP_EhXtk9-ldjRQOhhc5n1waAu8IXtiid5Pt5ZYbNE2oooJysxGh8-2vprNq3yArVBNC-DWdvzEjaJoR_wfkdSGWG2houxsQzAG6ZgInJDJ1cz0U1_a8tdTStJ56CoTMAs=s1920-w1920-h1080-p-k-no-nd-mv\",null,null,null,120,11,null,null,null,\"http://www.gettyimages.com/detail/photo/suspension-bridge-royalty-free-image/107709060?esource=chromecast\",null,null,\"Photo by Daniel Muller\",null,[],null,0,\"FEATURED_GETTYIMAGES_TITLE\",\"89ae3a3b697da2318e0a9fbd8951b7d5\",null,null,0,null,null,null,48,[[48,\"FEATURED_GETTYIMAGES_TITLE\",\"Getty Images\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],3037105898765724,[9700053]]",
        "[\"https://lh3.googleusercontent.com/SxgLlfCrzM66njIgpKlq2nkRrCdq2_sONwQDxl0AAImggIso_VkVzg=s1920-w1920-h1080-p-k-no-nd-mv\",\"Saurabh Paranjape\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/105737724482908033948/albums/6213733340481709841/6213733341343554690\",null,null,\"Photo by Saurabh Paranjape\",null,[[\"Westminster Bridge, London, England\",\"https://www.google.com/search?q=Westminster+Bridge\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipN2LkA4gtWKmP4xk7RWQFR9IKB9EnW2m4s3qVsp\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],-6380615397988733,[9700053]]",
        "[\"https://lh3.googleusercontent.com/mij2Eglc324jD_kxhu43aSnX8w9Xfr7XQdEwLpWpiVoFWZSh8Ljj=s1920-w1920-h1080-p-k-no-nd-mv\",\"Justin Brown\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/101005060236931055507/albums/5720519753508285169/6122212643311873906\",null,null,\"Photo by Justin Brown\",null,[[\"New York City, NY\",\"https://www.google.com/search?q=New+York+City%2C+New+York\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipPSuE14ATWH-FwoO3DGJyiyewcTORhjDEuFTF__\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],1293145096798261,[9700053]]"]},
     receiver_status: %{"requestId" => 1,
       "status" => %{"applications" => [%{"appId" => "E8C28D3C",
            "displayName" => "Backdrop", "isIdleScreen" => true,
            "namespaces" => [%{"name" => "urn:x-cast:com.google.cast.sse"},
             %{"name" => "urn:x-cast:com.google.cast.inject"}],
            "sessionId" => "C6591D59-64B2-4357-98DE-A982A75FAA6F",
            "statusText" => "", "transportId" => "web-5"}],
         "volume" => %{"controlType" => "attenuation", "level" => 1.0,
           "muted" => false, "stepInterval" => 0.05000000074505806}},
       "type" => "RECEIVER_STATUS"}, request_id: 4,
     session: "C6591D59-64B2-4357-98DE-A982A75FAA6F",
     ssl: {:sslsocket, {:gen_tcp, #Port<0.7995>, :tls_connection, :undefined},
      #PID<0.226.0>}}

##### Youtube Video playing

      iex(126)> Chromecast.state(device)
    %Chromecast.State{destination_id: "web-13", ip: {192, 168, 1, 138},
     media_session: 1936679159,
     media_status: %{"appDeviceId" => "BBC9E06BCA89EA246A21D650BE44BA52",
       "backendData" => "[\"https://lh4.googleusercontent.com/proxy/c5GLPnubdevNNbhBlOekeEAA64Us7uNSMJkhgjWZlCQIo1eqqwXve4RZlIcBQwahoEI32MXkXXOhZmFWayEpF-UJafokwVKemB2EWX42dJDUi6xCLmPYLRDEmZ5YPCDefGJikV2XgR8e9pE5b4XS215Bygf6t-oNSTK-Ae_uKtKq3gOMvFt7PmmFPj9uvqjCu9N1ehUQ6CXiH7Ke7z6nqpO5dW6kfDVvdAV1oEtl6bD572C1QHWaD5d9HKnRzx-l0j4CryxMq0xIODl2ziPasNGGe4zHCYpGXIzq7qrF=s1920-w1920-h1080-fcrop64=1,0000170affffef93-k-no-nd-mv\",null,null,null,120,11,null,null,null,\"http://www.gettyimages.com/detail/photo/grand-prismatic-spring-yellowstone-national-high-res-stock-photography/462556881?esource=chromecast\",null,null,\"Photo by Peter Adams\",null,[],null,0,\"FEATURED_GETTYIMAGES_TITLE\",\"363fad4f1769ed622205dc4e1b75281a\",null,null,0,null,null,null,48,[[48,\"FEATURED_GETTYIMAGES_TITLE\",\"Getty Images\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],4718130360558134,[9700053]]",
       "currentTime" => 0.453, "customData" => %{"playerState" => 1},
       "media" => %{"contentId" => "RuWRnIAwPIU",
         "contentType" => "x-youtube/video",
         "customData" => %{"currentIndex" => 2,
           "listId" => "RQAGdO5p9nVvzfKwZGP9XUYZDXbqcljCV01fxpzRs0Qpu0d_ZPowkJ508lgJyOldy_hFam51_fF_NieXwcngOoZlXYeR89R8CXAMGvyLvP82nkOuUUAVbL1hQ"},
         "duration" => 157.314693877551,
         "metadata" => %{"images" => [%{"url" => "https://i.ytimg.com/vi/RuWRnIAwPIU/hqdefault.jpg"}],
           "metadataType" => 0,
           "title" => "Metropolis 80 Freeskate Vs Barcelona - Powerslide"},
         "streamType" => "BUFFERED"}, "mediaSessionId" => 1936679159,
       "numLinkedUsers" => 0, "playbackRate" => 1, "playerState" => "PLAYING",
       "requestId" => "0", "supportedMediaCommands" => 3,
       "topicHistory" => ["[\"https://lh5.googleusercontent.com/proxy/vkAEc_MrmRauQq8jR40hx_yh-ExzYSupzCaA3uKbLv6MKhRFd4tit_f1CTneIYHT7vYkgbPANzXQ0vuYzXm1WLpUyTFHv0Vcj13gH9Ibr_z9AJR0SrTQ2hmfXz7isqP_EhXtk9-ldjRQOhhc5n1waAu8IXtiid5Pt5ZYbNE2oooJysxGh8-2vprNq3yArVBNC-DWdvzEjaJoR_wfkdSGWG2houxsQzAG6ZgInJDJ1cz0U1_a8tdTStJ56CoTMAs=s1920-w1920-h1080-p-k-no-nd-mv\",null,null,null,120,11,null,null,null,\"http://www.gettyimages.com/detail/photo/suspension-bridge-royalty-free-image/107709060?esource=chromecast\",null,null,\"Photo by Daniel Muller\",null,[],null,0,\"FEATURED_GETTYIMAGES_TITLE\",\"89ae3a3b697da2318e0a9fbd8951b7d5\",null,null,0,null,null,null,48,[[48,\"FEATURED_GETTYIMAGES_TITLE\",\"Getty Images\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],3037105898765724,[9700053]]",
        "[\"https://lh3.googleusercontent.com/SxgLlfCrzM66njIgpKlq2nkRrCdq2_sONwQDxl0AAImggIso_VkVzg=s1920-w1920-h1080-p-k-no-nd-mv\",\"Saurabh Paranjape\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/105737724482908033948/albums/6213733340481709841/6213733341343554690\",null,null,\"Photo by Saurabh Paranjape\",null,[[\"Westminster Bridge, London, England\",\"https://www.google.com/search?q=Westminster+Bridge\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipN2LkA4gtWKmP4xk7RWQFR9IKB9EnW2m4s3qVsp\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],-6380615397988733,[9700053]]",
        "[\"https://lh3.googleusercontent.com/mij2Eglc324jD_kxhu43aSnX8w9Xfr7XQdEwLpWpiVoFWZSh8Ljj=s1920-w1920-h1080-p-k-no-nd-mv\",\"Justin Brown\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/101005060236931055507/albums/5720519753508285169/6122212643311873906\",null,null,\"Photo by Justin Brown\",null,[[\"New York City, NY\",\"https://www.google.com/search?q=New+York+City%2C+New+York\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipPSuE14ATWH-FwoO3DGJyiyewcTORhjDEuFTF__\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],1293145096798261,[9700053]]",
        "[\"https://lh3.googleusercontent.com/LEwrbgnOQd-jBz6s5FuTqtKlUaa_UExFsBLBlzOi0rtsopryVScqkQ=s1920-w1920-h1080-p-k-no-nd-mv\",\"Aaron Choi\",null,null,120,7,null,null,null,\"https://plus.google.com/photos/111628818598106803270/albums/6117592132440816289/6140512115181587250\",null,null,\"Photo by Aaron Choi\",null,[[\"Manarola, Cinque Terre, Italy\",\"https://www.google.com/search?q=Manarola+in+Cinque+Terre%2C+Italy\"]],null,0,\"FEATURED_GPLUS_TITLE\",\"AF1QipNQEjzYMlvgXzfQkE6l9Yrsip6SGFnuQim2xlcY\",null,null,0,null,null,null,46,[[46,\"FEATURED_GPLUS_TITLE\",\"Google+\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],7159867778728899,[9700053]]",
        "[\"https://lh4.googleusercontent.com/proxy/c5GLPnubdevNNbhBlOekeEAA64Us7uNSMJkhgjWZlCQIo1eqqwXve4RZlIcBQwahoEI32MXkXXOhZmFWayEpF-UJafokwVKemB2EWX42dJDUi6xCLmPYLRDEmZ5YPCDefGJikV2XgR8e9pE5b4XS215Bygf6t-oNSTK-Ae_uKtKq3gOMvFt7PmmFPj9uvqjCu9N1ehUQ6CXiH7Ke7z6nqpO5dW6kfDVvdAV1oEtl6bD572C1QHWaD5d9HKnRzx-l0j4CryxMq0xIODl2ziPasNGGe4zHCYpGXIzq7qrF=s1920-w1920-h1080-fcrop64=1,0000170affffef93-k-no-nd-mv\",null,null,null,120,11,null,null,null,\"http://www.gettyimages.com/detail/photo/grand-prismatic-spring-yellowstone-national-high-res-stock-photography/462556881?esource=chromecast\",null,null,\"Photo by Peter Adams\",null,[],null,0,\"FEATURED_GETTYIMAGES_TITLE\",\"363fad4f1769ed622205dc4e1b75281a\",null,null,0,null,null,null,48,[[48,\"FEATURED_GETTYIMAGES_TITLE\",\"Getty Images\"],[3,\"PHOTO_COMMUNITIES_TITLE\",\"Featured photos\"]],4718130360558134,[9700053]]"],
       "volume" => %{"level" => 1, "muted" => false}},
     receiver_status: %{"requestId" => 12,
       "status" => %{"applications" => [%{"appId" => "233637DE",
            "displayName" => "YouTube", "isIdleScreen" => false,
            "namespaces" => [%{"name" => "urn:x-cast:com.google.youtube.mdx"},
             %{"name" => "urn:x-cast:com.google.cast.media"},
             %{"name" => "urn:x-cast:com.google.cast.cac"},
             %{"name" => "urn:x-cast:com.google.cast.inject"}],
            "sessionId" => "9F2318D0-8581-446E-9BFB-AA8FDABD74F4",
            "statusText" => "YouTube", "transportId" => "web-13"}],
         "volume" => %{"controlType" => "attenuation", "level" => 1.0,
           "muted" => false, "stepInterval" => 0.05000000074505806}},
       "type" => "RECEIVER_STATUS"}, request_id: 39,
     session: "9F2318D0-8581-446E-9BFB-AA8FDABD74F4",
     ssl: {:sslsocket, {:gen_tcp, #Port<0.7995>, :tls_connection, :undefined},
      #PID<0.226.0>}}

## Explanation

`Chromecast.start_link(ip \\ {192, 168, 1, 15})` starts a `GenServer` that opens a binary SSL connection to the Chromecast. The protocol is based on Protobufs, and uses the `exprotobuf` library. Every few seconds the Chromecast will send out a `ping` request and expects a `pong` within a few seconds, otherwise it closes the session. Periodically Chromecast sends a request with it's current state, this is captured by the Chromecast process and it's state is updated. To pause media call `Chromecast.pause(:device)` where device is the `PID` returned when calling `Chromecast.start_link`. Play is similar `Chromecast.play(:device)`. You can easily connect to multiple Chromecasts by calling `Chromecast.start_link(ip)` with unique IP addresses. You can discover your Chromecast(s) using [mDNS](https://github.com/NationalAssociationOfRealtors/mdns) and/or [SSDP](https://github.com/NationalAssociationOfRealtors/ssdp).
