import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:httpexplorer/models/app.dart';
import 'package:httpexplorer/models/constants.dart';
import 'package:provider/provider.dart';
import 'package:servicestack/client.dart';

class Header extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, app, child) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: app.txtUrlController,
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: app.urlBarHint,
                    ),
                    onSubmitted: (value) => app.addSite(app.txtUrlController.text),
                  )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: FloatingActionButton(
                        child: const Icon(Icons.add),
                        onPressed: () => app.addSite(app.txtUrlController.text),
                      ))
                ],
              )),
          Flexible(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Row(children: [
                    if (app.loading)
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.grey.shade700, strokeWidth: 2)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: app.appError != ""
                            ? Text(app.appError,
                                style: TextStyle(
                                    color: AppStyles.errorTextColor,
                                    fontSize: 20))
                            : Text(app.appMessage,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppStyles.appMessageTextColor)))
                  ])))
        ]),
      );
    });
  }
}
