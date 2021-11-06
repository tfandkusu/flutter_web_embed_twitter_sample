# Flutter WebにTwitterのツイート埋め込みを貼るサンプル

<img src="https://codebuild.ap-northeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiaUZ4aUpndE9jM0lvYk40Z1pqVGlmL1daRUZOQzRtTTlMcU1ES0pmTmpKcmJLZjBqNmFMUHpyZUtsTDYvVUI4M25rNnZLWUo0cGUzcUlXdnpUL1VuR29rPSIsIml2UGFyYW1ldGVyU3BlYyI6ImpIWjlKblBpNmIrT1gvdGwiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main">

プルリクエスト送信テスト3

## デプロイ先

https://flutter-web-embed-twitter.web.app/

## 解説

Flutter Webに[Twitterのツイート埋め込み](https://help.twitter.com/ja/using-twitter/embed-twitter-feed)を[HtmlElementView](https://api.flutter.dev/flutter/widgets/HtmlElementView-class.html)を使い設置してします。

さらにその上にFlutterの[ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)を設置しています。

<img src="https://user-images.githubusercontent.com/16898831/117028991-317dc800-ad39-11eb-9078-db9b7186628d.png" width="320">

それだけだと、Flutterのボタンを押したら、後ろのツイート埋め込みが押されたことになり、Twitterが別のタブで開かれます。

よって、[pointer_interceptor](https://pub.dev/packages/pointer_interceptor)パッケージのPointerInterceptorウィジットでボタンを囲み、Flutterのボタンを押せるようにします。

さらに、ボタンを押すとダイアログが表示されます。

<img src="https://user-images.githubusercontent.com/16898831/117028999-33478b80-ad39-11eb-8ab2-1427da0d5047.png" width="320">

ダイアログが表示されたときだけ、HtmlElementViewをPointerInterceptorウィジットで覆うことで、ダイアログに対するクリックを行えるようにしています。

## 注意点

ツイートの上ではスクロールできません。スクロールする画面とクリックできるHTML要素は組み合わせない方が良いことが分かりました。
