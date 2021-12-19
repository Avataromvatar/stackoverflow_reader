import 'dart:convert';

// {
//       "has_synonyms": true,
//       "is_moderator_only": false,
//       "is_required": false,
//       "count": 2307953,
//       "name": "javascript"
//  }

class AppModelTag {
  List<String>? synonyms;
  bool hasSynonyms = false;
  bool isModeratorOnly = false;
  bool isRequered = false;
  int count = -1;
  String name = '';
  bool isFavorite = false;
  bool isTrue = false;
  AppModelTag();
  AppModelTag.fromMap(Map<String, dynamic> map) {
    _loadFromMap(map);
  }
  AppModelTag.fromJson(String json) {
    var map = jsonDecode(json);
    if (map is Map<String, dynamic>) {
      _loadFromMap(map);
    }
  }
  void _loadFromMap(Map<String, dynamic> map) {
    if (map.containsKey('has_synonyms') &&
        map.containsKey('is_moderator_only') &&
        map.containsKey('is_required') &&
        map.containsKey('count') &&
        map.containsKey('name')) {
      try {
        hasSynonyms = map['has_synonyms'];
        isModeratorOnly = map['is_moderator_only'];
        isRequered = map['is_required'];
        count = map['count'];
        name = map['name'];
        if (map.containsKey('isFavorite')) {
          isFavorite = map['isFavorite'];
        }
        if (map.containsKey('synonyms')) {
          synonyms = (map['synonyms'] as List<dynamic>).cast<String>();
        }
        isTrue = true;
      } catch (e) {
        isTrue = false;
        print('ERROR: Create AppModelTag from $json\n$e');
      }
    }
  }
}
