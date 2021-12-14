import 'package:flutter/widgets.dart';
import 'package:tastypie/tastypie.dart';

class ViewLayer extends InheritedWidget with Colony {
  ViewLayer({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {}

  static ViewLayer of(BuildContext context) {
    final ViewLayer? result =
        context.dependOnInheritedWidgetOfExactType<ViewLayer>();
    assert(result != null, 'No ViewLayer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ViewLayer old) => false;
}
