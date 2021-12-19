import 'dart:convert';

import 'package:stackoverflow_reader/model/model_question.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:tastypie/tastypie.dart';

///2.3/questions?page=1&pagesize=10&order=desc&sort=activity&tagged=android&site=stackoverflow
class AppQuestionsService with Topping {
  List<AppModelQuestion> _list = List<AppModelQuestion>.empty(growable: true);
  int currentPage = 0;
  int startPage;
  String path;
  Map<String, dynamic> _param;
  bool waitResponse = false;
  AppModelTag? _tag;
  AppQuestionsService({
    int pageSize = 20,
    this.path = 'https://api.stackexchange.com/2.3/questions',
    String order = 'desc',
    String sort = 'activity',
    String tagged = 'dart',
    this.startPage = 1,
  })  : currentPage = startPage - 1,
        _param = {
          'page': startPage + 1,
          'pagesize': pageSize,
          'order': order,
          'sort': sort,
          'tagged': tagged,
          'site': 'stackoverflow',
        } {
    addInputTaste('listAppQuestion', _getListAppQuestion,
        stateMask: 1, onlyInTheLayer: false); //from service
    addInputTaste('getNextQuestionPage', _getNextPage,
        onlyInTheLayer: false); //from
    addInputTaste('openQuestion', _openQuestion,
        onlyInTheLayer: false); //from view

    addOutputTaste('error', onlyInTheLayer: false);
    addOutputTaste('getRequest', onlyInTheLayer: false); //to service
    addOutputTaste('updateQuestionList', onlyInTheLayer: false); //to view
    addOutputTaste('fullRefreshQuestions', onlyInTheLayer: false); //to view
  }
  void _openQuestion(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      _tag = data as AppModelTag;
    } catch (e) {
      print('Error AppQuestionsService $e');
      send(TasteDTO('error', 'Error AppQuestionsService $e'));
    }
  }

  void _getListAppQuestion(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      waitResponse = false;
      print('AppQuestionsService-> $topic:$state');
      var tmp = data as List<AppModelQuestion>;
      _list.addAll(tmp);
      currentPage++;
      // send(TasteDTO('updateQuestionList', tmp));
      send(TasteDTO('fullRefreshQuestions', _list));
    } catch (e) {
      print('Error AppQuestionsService $e');
      send(TasteDTO('error', 'Error AppQuestionsService $e'));
    }
  }

  void _getNextPage(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      if (!waitResponse) {
        print('AppQuestionsService-> $topic:$state');
        _param['page'] = startPage + currentPage;
        if (data != null) {
          _param['tagged'] = (data as AppModelTag).name;
        }
        String str = '${path}';
        str += '?';
        int count = _param.length;
        _param.forEach((key, value) {
          count--;
          if (count == 0)
            str += '$key=$value';
          else
            str += '$key=$value&';
        });
        waitResponse = send(TasteDTO('getRequest', str, state: 2));
      }
    } catch (e) {
      send(TasteDTO('error', 'Error RestApi $e'));
    }
  }
}
