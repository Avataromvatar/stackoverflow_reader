import 'package:tastypie/tastypie.dart';

import 'package:http/http.dart' as http;

class RestApi with Topping {
  RestApi() {
    addInputTaste('getRequest', _getRequest);
    addOutputTaste('error', onlyInTheLayer: false);
    addOutputTaste('getResponse', onlyInTheLayer: false);
  }
  void _getRequest(
      dynamic data, String topic, int state, ITasteOutput? out) async {
    try {
      print('RestApi-> $topic:$state');
      Uri url = Uri.parse(data);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        send(TasteDTO(
            'getResponse',
            {
              'body': response.body,
              'status': response.statusCode,
            },
            state: state));
      } else {
        print(
            'Response FromServer RestApi Status:${response.statusCode} Body:${response.body}');
        send(TasteDTO('error',
            'Response FromServer RestApi Status:${response.statusCode} Body:${response.body}'));
      }
    } catch (e) {
      print('Error RestApi $e');
      send(TasteDTO('error', 'Error RestApi $e'));
    }
  }
}
