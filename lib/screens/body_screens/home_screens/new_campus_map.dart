
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bible_bot/models/style_model.dart';

class WebViewExampleState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = Provider.of<StyleModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
                color: styleModel.getBackgroundColor()['reversalColorLevel1']),
            backgroundColor:
            styleModel.getBackgroundColor()['backgroundColorLevel1'],
            title: Text(
              '캡퍼스맵',
              style: styleModel.getTextStyle()['appBarTextStyle'],
            ),
          ),
          body: Container(
            child: WebView(
              initialUrl: "https://junbeomkim-01.github.io/Map_view/index.html",
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
      ),
    );
  }
}


//WebViewExampleState