import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/widget/taglist_logic.dart';

class PageTag extends StatelessWidget {
  PageTag({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const Text(
          //   'Tags :)',
          // ),
          Flexible(child: TagListLogic()),
        ],
      ),
    );
  }
}
