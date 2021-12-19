import 'dart:convert';

import 'package:stackoverflow_reader/model/model_question.dart';
import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:tastypie/tastypie.dart';

class AppDataMapper with Topping {
  AppDataMapper() {
    addInputTaste('getResponse', _getResponseTag,
        stateMask: 1, onlyInTheLayer: false); //from service
    addInputTaste('getResponse', _getResponseQuestion,
        stateMask: 2, onlyInTheLayer: false); //from service
    addOutputTaste('checkListAppTag');
    addOutputTaste('updateQuestionList', onlyInTheLayer: false);
    addOutputTaste('error', onlyInTheLayer: false);
  }

  void _getResponseTag(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      print('AppDataMapper-> $topic:$state');
      var json = data['body'] as String;
      var ret = List<AppModelTag>.empty(growable: true);
      Map<String, dynamic> map = jsonDecode(json);
      List<Map<String, dynamic>> items =
          map['items'].cast<Map<String, dynamic>>();
      items.forEach((element) {
        var t = AppModelTag.fromMap(element);

        ret.add(t);
      });
      send(TasteDTO('checkListAppTag', ret));
    } catch (e) {
      print('Error AppDataMapper $e');
      send(TasteDTO('error', 'Error AppDataMapper $e'));
    }
  }

  void _getResponseQuestion(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      print('AppDataMapper-> $topic:$state');
      var json = data['body'] as String;
      var ret = List<AppModelQuestion>.empty(growable: true);
      Map<String, dynamic> map = jsonDecode(json);
      List<Map<String, dynamic>> items =
          map['items'].cast<Map<String, dynamic>>();
      items.forEach((element) {
        var t = AppModelQuestion.fromMap(element);

        ret.add(t);
      });
      send(TasteDTO('updateQuestionList', ret));
    } catch (e) {
      print('Error AppDataMapper $e');
      send(TasteDTO('error', 'Error AppDataMapper $e'));
    }
  }
}
