import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';

class TagWidget extends StatelessWidget {
  final AppModelTag tag;
  final void Function() onTap;
  TagWidget(this.tag, this.onTap, {Key? key}) : super(key: key);

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/questions', arguments: tag);
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    // return Text('${tag.name} count:${tag.count}');

    return ListTile(
      title: Text(tag.name),
      subtitle: Text(
          'count:${tag.count}${tag.synonyms != null ? "\nSynonim:${tag.synonyms}" : ''}'),
      isThreeLine: tag.synonyms != null,
      leading: tag.isFavorite ? Icon(Icons.star) : null,
      onLongPress: () => _onTap(context),
    );
  }
}
