import 'package:stackoverflow_reader/model/model_tag.dart';
import 'package:tastypie/tastypie.dart';

class AppCheckFavoriteService with Topping {
  /// TODO read from another service or filesystem
  static const _myFavoriteTag = {
    'favoriteTag': ['android', 'dart', 'flutter']
  };

  AppCheckFavoriteService() {
    addInputTaste('checkListAppTag', _checkListAppTag); //from mapper
    addOutputTaste('listAppTag'); //to apptag
    addOutputTaste('error', onlyInTheLayer: false);
  }

  void _checkListAppTag(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      print('AppCheckFavoriteService-> $topic:$state');
      var tmp = data as List<AppModelTag>;
      var fav = _myFavoriteTag['favoriteTag']!;
      tmp.forEach((element) {
        if (fav.contains(element.name)) element.isFavorite = true;
      });
      send(TasteDTO('listAppTag', tmp));
    } catch (e) {
      print('Error in AppCheckFavoriteService: $e');
      send(TasteDTO('error', 'Error in AppCheckFavoriteService: $e'));
    }
  }
}
