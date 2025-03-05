/// A class that holds template-related data and methods.
class TemplateList {
  /// A static string that contains HTML content.
  /// Here it is initialized with a simple header element.
  static String html = """
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>vk_video</title>
        <script src="https://vk.com/js/api/videoplayer.js"></script>
        <style>
            * {
                margin: 0px;
                padding: 0;
            }
            body {
                height: 100vh;
                width: 100vw;
                overflow: hidden;
            }
        </style>
    </head>
        <body>
            <iframe id="vkVideo"
                width="100%" height="100%"
                src="https://vk.com/video_ext.php?oid=-176515503&id=456240000&autoplay=0%&js_api=1&t=%T%&controls=0" 
                allow="autoplay; encrypted-media; fullscreen; picture-in-picture; screen-wake-lock;" 
                allowfullscreen
            ></iframe>
            <script>
                var player = VK.VideoPlayer(document.getElementById("vkVideo"));
            </script>
        </body>
    </html>
  """;
}
