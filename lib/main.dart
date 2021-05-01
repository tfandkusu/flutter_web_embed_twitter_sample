import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:pointer_interceptor/pointer_interceptor.dart';

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
      return div;
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
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
                    width: 600,
                    child: HtmlElementView(viewType: 'twitter')),
              ],
            ),
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
                          // TODO 押された
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('ブックマークする'),
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
}
