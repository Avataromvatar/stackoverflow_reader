import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/widget/error_msg.dart';
import 'package:stackoverflow_reader/widget/questionslist.dart';
import 'package:stackoverflow_reader/widget/tag.dart';

class PageQuestions extends StatelessWidget {
  final AppModelTag? _tag;
  PageQuestions({Key? key, AppModelTag? tag})
      : _tag = tag,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Questions${_tag != null ? '/${_tag!.name}' : ''}'),
        ),
        // floatingActionButton: FloatingActionButton.small(
        //   child: Icon(Icons.keyboard_return),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed('/');
        //   },
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _tag != null
              //     ? TagWidget(_tag!, () {
              //         Navigator.of(context).pushNamed('/');
              //       })
              //     : Text(''),
              ErrorMsgWidget(),
              Flexible(
                  child: QuestionsListLogic(
                tag: _tag,
              )),
            ],
          ),
        ));
  }
}
