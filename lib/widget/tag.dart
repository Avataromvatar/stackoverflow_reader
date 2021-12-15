import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';

class TagWidget extends StatelessWidget {
  final AppModelTag tag;
  TagWidget(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('${tag.name} count:${tag.count}');
  }
}
