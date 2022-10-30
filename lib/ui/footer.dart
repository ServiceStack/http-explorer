import 'package:flutter/material.dart';
import 'package:httpexplorer/models/app.dart';
import 'package:provider/provider.dart';

class Footer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
        builder: (context, app, child) =>
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 4, 4),
              child: Row(
                children: [
                  Text(app.statusBarText, style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
            ));
  }
}
