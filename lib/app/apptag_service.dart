import 'dart:convert';

import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:tastypie/tastypie.dart';

class AppTagService with Archaea {
  List<AppModelTag> _list = List<AppModelTag>.empty(growable: true);
  int currentPage = 0;
  int startPage;
  String path;
  Map<String, dynamic> _param;
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
          'site': 'stackoverflow'
        } {
    addInPoint(ArchaeaPointInput('getResponse', _getResponse));
    addInPoint(ArchaeaPointInput('nextTagPage', _getNextPage));

    addOutPoint(ArchaeaPointOutput('error'));
    addOutPoint(ArchaeaPointOutput('getRequest'));
    addOutPoint(ArchaeaPointOutput('updateTagList'));
    addOutPoint(ArchaeaPointOutput('fullRefreshTags'));
  }
  void _getResponse(dynamic data, String topic, int state) async {
    try {
      var json = data as String;
      var ret = List<AppModelTag>.empty(growable: true);
      Map<String, dynamic> map = jsonDecode(json);
      List<Map<String, dynamic>> items =
          map['items'].cast<Map<String, dynamic>>();
      items.forEach((element) {
        var t = AppModelTag.fromMap(element);
        _list.add(t);
        ret.add(t);
      });
      currentPage++;
      send(TastyPieDTO('updateTagList', ret));
    } catch (e) {
      print('Error AppTagService $e');
      send(TastyPieDTO('error', 'Error AppTagService $e'));
    }
  }

  void _getNextPage(dynamic data, String topic, int state) async {
    try {
      // "https://api.stackexchange.com/2.3/tags?page=1&pagesize=20&order=desc&sort=popular&site=stackoverflow"
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

      send(TastyPieDTO('getRequest', str, state: 1));
    } catch (e) {
      send(TastyPieDTO('error', 'Error RestApi $e'));
    }
  }
}
