import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/widget/error_msg.dart';
import 'package:stackoverflow_reader/widget/taglist_logic.dart';

class PageTag extends StatelessWidget {
  PageTag({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tags'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // const Text(
              //   'Tags :)',
              // ),
              ErrorMsgWidget(),
              Flexible(child: TagListLogic()),
            ],
          ),
        ));
  }
}
