import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/widget/tag.dart';
import 'package:tastypie/tastypie.dart';

class TagListLogic extends StatefulWidget with Archaea {
  final List<Widget> _tags = List<Widget>.empty(growable: true);
  TagListLogic({Key? key}) : super(key: key) {}
  @override
  State<TagListLogic> createState() => _TagListLogicState();
}

class _TagListLogicState extends State<TagListLogic> with Archaea {
  _TagListLogicState() {
    addInPoint(ArchaeaPointInput('updateTagList', _updateTagList));
    addInPoint(ArchaeaPointInput('fullRefreshTags', _updateTagList));
    addOutPoint(ArchaeaPointOutput('nextTagPage'));
    addOutPoint(ArchaeaPointOutput('openQuestion'));
  }
  @override
  void dispose() {
    if (colony != null) {
      colony!.removeArchaea(this);
    }
    super.dispose();
  }

  void _updateTagList(dynamic data, String topic, int state) {
    if (topic == 'updateTagList') {
      (data as List<AppModelTag>).forEach((element) {
        widget._tags.add(TagWidget(element));
      });
    } else if (topic == 'fullRefreshTags') {
      widget._tags.clear();
      widget._tags.addAll((data as List<AppModelTag>).map((e) => TagWidget(e)));
    }
    setState(() {});
  }

  Widget _tagItemBuilder(BuildContext context, int index) {
    if (widget._tags.length > index) {
      return widget._tags[index];
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    if (colony == null) {
      ViewLayer.of(context).addArchaea(this);
    }
    return ListView.builder(
        itemCount: widget._tags.length, itemBuilder: _tagItemBuilder);
  }
}
