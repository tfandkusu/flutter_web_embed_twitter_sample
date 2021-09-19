import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'shims/dart_ui.dart' as ui;
import 'dart:html' as html;
import 'package:pointer_interceptor/pointer_interceptor.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppWidget();
  }
}

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Embed Twitter sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage()
    );
  }
}

class MainPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Embed Twitter sample'),
      ),
      body: Center(
        child: ListView(
          children: [
            TweetWidget(
                "https://twitter.com/tfandkusu/status/1395988534347976704"),
            TweetWidget(
                "https://twitter.com/tfandkusu/status/1406226700170498051")
          ],
        ),
      ),
    );
  }
}

class TweetWidget extends StatefulWidget {
  final String _url;

  TweetWidget(this._url);

  @override
  State<StatefulWidget> createState() {
    return TweetWidgetState(_url);
  }
}

class TweetWidgetState extends State<TweetWidget> {
  static int id = 1;

  final String _url;

  String _viewTypeId = "";

  TweetWidgetState(this._url) {
    _viewTypeId = "twitter-$id";
    ++id;
    ui.platformViewRegistry.registerViewFactory(_viewTypeId, (viewId) {
      // <div>
      // <blockquote class="twitter-tweet">
      // <a href="https://twitter.com/tfandkusu/status/1325717641839874049"></a>
      // </blockquote>
      // <script src="https://platform.twitter.com/widgets.js">
      // </div>
      final div = html.DivElement();
      final script = html.ScriptElement();
      script.src = "https://platform.twitter.com/widgets.js";
      final quote = html.Element.tag('blockquote');
      quote.classes = ["twitter-tweet"];
      final a = html.AnchorElement(href: _url);
      quote.children = [a];
      div.children = [quote, script];
      div.style.width = '100%';
      div.style.height = '100%';
      return div;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceData = MediaQuery.of(context);
    if (deviceData.size.width >= 600) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Stack(children: [
              SizedBox(
                  width: 568,
                  height: 450,
                  child: HtmlElementView(viewType: _viewTypeId)),
              PointerInterceptor(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: SizedBox(
                      width: 568,
                      height: 450,
                    ),
                    onTap: () async {
                      if (await canLaunch(_url)) {
                        await launch(_url);
                      }
                    },
                  ),
                ),
              )
            ]),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 500,
              child: HtmlElementView(viewType: _viewTypeId),
            ),
          ),
          SizedBox(width: 16)
        ],
      );
    }
  }
}
