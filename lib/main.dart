import 'dart:math';
import 'dart:developer' as logger;
import 'package:httpexplorer/models/app.dart';
import 'package:httpexplorer/ui/body.dart';
import 'package:httpexplorer/ui/footer.dart';
import 'package:httpexplorer/ui/header.dart';
import 'package:httpexplorer/ui/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppModel>(create: (context) => AppModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Explorer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'HTTP Explorer'),
    );
  }
}

class Option {
  static const String treasury = "treasury";
  static const String state = "state";
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    var app = Provider.of<AppModel>(context);
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(flex: 1, child: Body()),
          Footer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        switch(await showDialog<String>(
      context: context,
        builder: (BuildContext context) => SimpleDialog(
            title: const Text('Dialog Title'),
            children: <Widget>[
              const Text('Dialog description'),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, Option.treasury); },
                child: const Text('Treasury department'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, Option.state); },
                child: const Text('State department'),
              ),
            ]
        ),
      )) {
          case Option.treasury:
            logger.log("treasury");
          break;
          case Option.state:
            logger.log("state");
            break;
          case null:
            logger.log("dialog dismissed");
            break;
    }
    },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
