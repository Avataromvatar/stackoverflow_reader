import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/widget/tag.dart';
import 'package:tastypie/tastypie.dart';

class TagListLogic extends StatefulWidget {
  final List<Widget> _tags = List<Widget>.empty(growable: true);
  TagListLogic({Key? key}) : super(key: key) {}
  @override
  State<TagListLogic> createState() => _TagListLogicState();
}

class _TagListLogicState extends State<TagListLogic> with Topping {
  _TagListLogicState() {
    addInputTaste('updateTagList', _updateTagList, onlyInTheLayer: false);
    addInputTaste('fullRefreshTags', _updateTagList, onlyInTheLayer: false);
    addInputTaste('changedPath', _changedPath, onlyInTheLayer: false);

    addOutputTaste('getNextTagPage', onlyInTheLayer: false);
    addOutputTaste('openQuestion', onlyInTheLayer: false);
    addOutputTaste('error', onlyInTheLayer: false);
  }
  @override
  void dispose() {
    if (own_layer != null) {
      print('_TagListLogicState Remove from layer');
      own_layer!.removeTopping(this);
    }
    super.dispose();
  }

  void _changedPath(dynamic data, String topic, int state, ITasteOutput? out) {
    print('_TagListLogicState-> $topic:$state');
  }

  void _updateTagList(
      dynamic data, String topic, int state, ITasteOutput? out) {
    try {
      print('_TagListLogicState-> $topic:$state');

      setState(() {
        print('rebuild');
        if (topic == 'updateTagList') {
          (data as List<AppModelTag>).forEach((element) {
            widget._tags.add(TagWidget(element, () {
              send(TasteDTO('openQuestion', element));
              // send(TasteDTO('error', 'Blablablaa'));
            }));
          });
        } else if (topic == 'fullRefreshTags') {
          widget._tags.clear();
          widget._tags
              .addAll((data as List<AppModelTag>).map((e) => TagWidget(e, () {
                    send(TasteDTO('openQuestion', e));
                    // send(TasteDTO('error', 'Blablablaa'));
                  })));
        }
      });

      // WidgetsBinding.instance?.addPostFrameCallback((_) {
      //   setState(() {});
      // });

    } catch (e) {
      print('Error _TagListLogicState $e');
      send(TasteDTO('error', 'Error _TagListLogicState $e'));
    }
  }

  Widget _tagItemBuilder(BuildContext context, int index) {
    print('Build TAG $index');
    if (widget._tags.length > index) {
      if (widget._tags.length - 2 < index) {
        print('_TagListLogicState request new page');

        send(TasteDTO('getNextTagPage', null));
      }
      return widget._tags[index];
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    if (own_layer == null) {
      print('_TagListLogicState add to layer');
      ViewLayer.of(context).addTopping(this);
      ViewLayer.of(context).rebuildDirectNet();
      send(TasteDTO('getNextTagPage', null));
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget._tags.length,
        itemBuilder: _tagItemBuilder);
  }
}
