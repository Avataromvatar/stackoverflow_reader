import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/view_layer.dart';
import 'package:stackoverflow_reader/model/model_question.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:stackoverflow_reader/widget/question.dart';
import 'package:tastypie/tastypie.dart';

class QuestionsListLogic extends StatefulWidget {
  final List<Widget> _quistions = List<Widget>.empty(growable: true);
  final AppModelTag? _tag;
  QuestionsListLogic({Key? key, AppModelTag? tag})
      : _tag = tag,
        super(key: key) {}
  @override
  State<QuestionsListLogic> createState() => _QuestionsListLogicState();
}

class _QuestionsListLogicState extends State<QuestionsListLogic> with Topping {
  _QuestionsListLogicState() {
    addInputTaste('updateQuestionList', _updateQuesionList,
        onlyInTheLayer: false);
    addInputTaste('fullRefreshQuestions', _updateQuesionList,
        onlyInTheLayer: false);
    addOutputTaste('getNextQuestionPage', onlyInTheLayer: false);
    addOutputTaste('openTagList', onlyInTheLayer: false);
    addOutputTaste('error', onlyInTheLayer: false);
  }

  void _updateQuesionList(
      dynamic data, String topic, int state, ITasteOutput? out) {
    try {
      print('_QuestionsListLogicState-> $topic:$state');

      setState(() {
        print('rebuild Questions');
        if (topic == 'updateQuestionList') {
          (data as List<AppModelQuestion>).forEach((element) {
            widget._quistions.add(QuestionWidget(element, () {
              // send(TasteDTO('openQuestion', element));
              print('Question onTop ${element.title}');
            }));
          });
        } else if (topic == 'fullRefreshTags') {
          widget._quistions.clear();
          widget._quistions.addAll(
              (data as List<AppModelQuestion>).map((e) => QuestionWidget(e, () {
                    // send(TasteDTO('openQuestion', e));
                    print('Question onTop ${e.title}');
                  })));
        }
      });
    } catch (e) {
      print('Error _QuestionsListLogicState $e');
      send(TasteDTO('error', 'Error _QuestionsListLogicState $e'));
    }
  }

  @override
  void dispose() {
    if (own_layer != null) {
      print('_QuestionsListLogicState Remove from layer');
      own_layer!.removeTopping(this);
    }
    super.dispose();
  }

  Widget _tagItemBuilder(BuildContext context, int index) {
    print('Build Questions $index');
    if (widget._quistions.length > index) {
      if (widget._quistions.length - 2 < index) {
        print('_QuestionsListLogicState request new page');
        send(TasteDTO('getNextQuestionPage', widget._tag));
      }
      return widget._quistions[index];
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    if (own_layer == null) {
      print('_QuestionsListLogicState add to layer');
      ViewLayer.of(context).addTopping(this);
      ViewLayer.of(context).rebuildDirectNet();
      send(TasteDTO('getNextQuestionPage', widget._tag));
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget._quistions.length,
        itemBuilder: _tagItemBuilder);
  }
}
