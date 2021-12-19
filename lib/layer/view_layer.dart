import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/layer/app_layer.dart';
import 'package:tastypie/tastypie.dart';

class ViewLayer extends InheritedWidget with TastyPieLayer {
  ViewLayer({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    connect(AppLayer());
    AppLayer().connect(this);
  }

  static ViewLayer of(BuildContext context) {
    final ViewLayer? result =
        context.dependOnInheritedWidgetOfExactType<ViewLayer>();
    assert(result != null, 'No ViewLayer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ViewLayer old) => false;
}
