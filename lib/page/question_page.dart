import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/widget/questionslist.dart';
import 'package:stackoverflow_reader/widget/tag.dart';

class PageQuestions extends StatelessWidget {
  final AppModelTag? _tag;
  PageQuestions({Key? key, AppModelTag? tag})
      : _tag = tag,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // _tag != null
          //     ? TagWidget(_tag!, () {
          //         Navigator.of(context).pushNamed('/');
          //       })
          //     : Text(''),

          FloatingActionButton.small(
            child: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          Flexible(
              child: QuestionsListLogic(
            tag: _tag,
          )),
        ],
      ),
    );
  }
}
