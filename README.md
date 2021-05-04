# Flutter WebにTwitterのツイート埋め込みを貼るサンプル

Flutter Webに[Twitterのツイート埋め込み](https://help.twitter.com/ja/using-twitter/embed-twitter-feed)を[HtmlElementView](https://api.flutter.dev/flutter/widgets/HtmlElementView/HtmlElementView.html)を使い設置してします。

さらにその上にFlutterの[ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)を設置しています。

<img src="https://raw.githubusercontent.com/tfandkusu/flutter_web_embed_twitter_sample/main/img/ss1.png" width="200">

それだけだと、Flutterのボタンを押したら、後ろのツイート埋め込みが押されたことになり、Twitterが別のタブで開かれます。

よって、[pointer_interceptor](https://pub.dev/packages/pointer_interceptor)パッケージのPointerInterceptorウィジットでボタンを囲み使い、Flutterのボタンを押せるようにします。

さらに、ボタンを押すとダイアログが表示されます。

<img src="https://raw.githubusercontent.com/tfandkusu/flutter_web_embed_twitter_sample/main/img/ss2.png" width="200">

ダイアログが表示されたときだけ、画面すべてをPointerInterceptorウィジットで覆うことで、ダイアログに対するクリックを行えるようにしています。




