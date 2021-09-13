import 'package:flutter/material.dart';
import 'package:flutter_web_embed_twitter/main_navigator_observer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'main_dialog_open_state_notifier_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory('twitter', (viewId) {
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
      final a = html.AnchorElement(
          href: "https://twitter.com/tfandkusu/status/1372519390034370563");
      quote.children = [a];
      div.children = [quote, script];
      div.style.width = '100%';
      div.style.height = '100%';
      return div;
    });
    return MyAppWidget();
  }
}

class MyAppWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
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
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 300,
                    width: 540,
                    child: HtmlElementView(viewType: 'twitter')),
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
}
