import 'package:flutter/material.dart';
import 'package:flutter_web_embed_twitter/main_navigator_observer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'shims/dart_ui.dart' as ui;
import 'dart:html' as html;
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'main_dialog_open_state_notifier_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAppWidget();
  }
}

class MyAppWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Embed Twitter sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      navigatorObservers: [MainNavigatorObserver(ref)],
    );
  }
}

class MainPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDialogOpen = ref.watch(mainDialogOpenStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Embed Twitter sample'),
      ),
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: [
                TweetWidget(
                    "https://twitter.com/tfandkusu/status/1395988534347976704"),
                _buildScrollMessage(),
                TweetWidget(
                    "https://twitter.com/tfandkusu/status/1406226700170498051")
              ],
            ),
            Positioned.fill(
                child: Visibility(
              visible: isDialogOpen,
              child: PointerInterceptor(
                child: Container(),
              ),
            )),
            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  PointerInterceptor(
                    child: ElevatedButton(
                        onPressed: () {
                          _showDialog(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Bookmark'),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        routeSettings: RouteSettings(name: "dialog"),
        builder: (_) => AlertDialog(
              title: Text('Information', style: TextStyle(fontSize: 18)),
              content: Text('It is bookmarked.'),
              actions: [
                TextButton(
                    onPressed: () {
                      // Close dialog
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }

  Row _buildScrollMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("Can't scroll over tweets.",
              style: TextStyle(fontSize: 14, color: Colors.black87)),
        )
      ],
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

  String _viewTypeId = "";

  TweetWidgetState(String url) {
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
      final a = html.AnchorElement(href: url);
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
          SizedBox(
              width: 568,
              height: 450,
              child: HtmlElementView(viewType: _viewTypeId))
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
