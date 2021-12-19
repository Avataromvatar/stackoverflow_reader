import 'package:tastypie/tastypie.dart';

class AppUserService with Topping {
  AppUserService() {
    addInputTaste('changePath', _changePath); //from view
    addInputTaste('openTagList', _changePath, onlyInTheLayer: false);
    addInputTaste('openQuestion', _changePath, onlyInTheLayer: false);
    addOutputTaste('changedPath');
  }

  void _changePath(dynamic data, String topic, int state, ITasteOutput? out) {
    print('AppUserService-> $topic:$state');
    send(TasteDTO('changedPath', data));
  }
}
