import 'package:flutter/widgets.dart';
import 'package:stackoverflow_reader/services/restapi.dart';
import 'package:tastypie/tastypie.dart';

class ServiceLayer extends TastyPieLayer {
  static final ServiceLayer _intrernal = ServiceLayer._();

  factory ServiceLayer() {
    return _intrernal;
  }
  ServiceLayer._() {
    addTopping(RestApi());
  }
}
