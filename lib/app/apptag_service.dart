import 'dart:convert';

import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:tastypie/tastypie.dart';

class AppTagService with Topping {
  List<AppModelTag> _list = List<AppModelTag>.empty(growable: true);
  int currentPage = 0;
  int startPage;
  String path;
  Map<String, dynamic> _param;
  bool waitResponse = false;
  AppTagService({
    int pageSize = 20,
    this.path = 'https://api.stackexchange.com/2.3/tags',
    String order = 'desc',
    String sort = 'popular',
    this.startPage = 1,
  })  : currentPage = startPage - 1,
        _param = {
          'page': startPage + 1,
          'pagesize': pageSize,
          'order': order,
          'sort': sort,
          'site': 'stackoverflow',
          'filter': '!nKzQUR*Po9'
        } {
    addInputTaste('listAppTag', _getListAppTag,
        stateMask: 1, onlyInTheLayer: false); //from service
    addInputTaste('getNextTagPage', _getNextPage,
        onlyInTheLayer: false); //from view

    addOutputTaste('error', onlyInTheLayer: false);
    addOutputTaste('getRequest', onlyInTheLayer: false); //to service
    addOutputTaste('updateTagList', onlyInTheLayer: false); //to view
    addOutputTaste('fullRefreshTags', onlyInTheLayer: false); //to view
  }
  void _getListAppTag(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      waitResponse = false;
      print('AppTagService-> $topic:$state');
      var tmp = data as List<AppModelTag>;
      _list.addAll(tmp);
      currentPage++;
      //send(TasteDTO('updateTagList', tmp));
      send(TasteDTO('fullRefreshTags', _list));
    } catch (e) {
      print('Error AppTagService $e');
      send(TasteDTO('error', 'Error AppTagService $e'));
    }
  }

  void _getNextPage(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      if (!waitResponse) {
        // "https://api.stackexchange.com/2.3/tags?page=1&pagesize=20&order=desc&sort=popular&site=stackoverflow"
        print('AppTagService-> $topic:$state');
        _param['page'] = startPage + currentPage;
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

        //// TODO for test/ remove after and uncomment waitResponse
        waitResponse = send(TasteDTO('getRequest', str, state: 1));
        // List<AppModelTag> tmp = List.generate(20, (int i) {
        //   return AppModelTag()..count = i;
        // });
        // send(TasteDTO('updateTagList', tmp));
      }
    } catch (e) {
      send(TasteDTO('error', 'Error RestApi $e'));
    }
  }
}
