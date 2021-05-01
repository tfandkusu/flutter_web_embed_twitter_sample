import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory('twitter', (viewId) {
      final div = html.DivElement();
      final script = html.ScriptElement();
      script.src = "https://platform.twitter.com/widgets.js";
      // シングルトンなVideo要素を作成するメソッド
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 300,
                width: 600,
                child: HtmlElementView(viewType: 'twitter')
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
