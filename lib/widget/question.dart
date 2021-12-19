import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/model/model_question.dart';

class QuestionWidget extends StatelessWidget {
  final AppModelQuestion question;
  final void Function() onTap;
  QuestionWidget(this.question, this.onTap, {Key? key}) : super(key: key);

  void _onTap(BuildContext context) {
    // Navigator.of(context).pushNamed('/', arguments: question);
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('${tag.name} count:${tag.count}');

    return ListTile(
      title: Text(question.title),
      subtitle: Text(
          'Author:${question.author} created:${question.date}\n${question.score != -1 ? "Score:${question.score} " : ""}${question.view_count != -1 ? "View:${question.view_count} " : ""}'),
      isThreeLine: true,
      onLongPress: () => _onTap(context),
    );
  }
}
