import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:tastypie/tastypie.dart';

class TagListLogic extends StatefulWidget with Archaea {
  TagListLogic({Key? key}) : super(key: key) {}
  @override
  State<TagListLogic> createState() => _TagListLogicState();
}

class _TagListLogicState extends State<TagListLogic> with Archaea {
  _TagListLogicState() {
    addInPoint(ArchaeaPointInput('updateTagList', _updateTagList));
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (colony == null) {
      ViewLayer.of(context).addArchaea(this);
    }
    return Text('data');
  }
}
