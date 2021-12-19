import 'package:stackoverflow_reader/app/appcheck_favorite_tag.dart';
import 'package:stackoverflow_reader/app/appdata_mapper.dart';
import 'package:stackoverflow_reader/app/appquest_service.dart';
import 'package:stackoverflow_reader/app/apptag_service.dart';
import 'package:stackoverflow_reader/app/appuser_service.dart';
import 'package:stackoverflow_reader/services/restapi.dart';
import 'package:tastypie/tastypie.dart';

class AppLayer extends TastyPieLayer {
  static final AppLayer _intrernal = AppLayer._();

  factory AppLayer() {
    return _intrernal;
  }
  AppLayer._() {
    addTopping(AppCheckFavoriteService());
    addTopping(AppUserService());
    addTopping(AppDataMapper());
    addTopping(AppTagService());
    addTopping(AppQuestionsService());
    rebuildDirectNet();
  }
}
