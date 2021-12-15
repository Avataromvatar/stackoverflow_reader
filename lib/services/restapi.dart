import 'package:tastypie/tastypie.dart';

import 'package:http/http.dart' as http;

class RestApi with Archaea {
  RestApi() {
    addInPoint(ArchaeaPointInput('getRequest', _getRequest));
    addOutPoint(ArchaeaPointOutput('error'));
    addOutPoint(ArchaeaPointOutput('getResponse'));
  }
  void _getRequest(dynamic data, String topic, int state) async {
    try {
      Uri url = Uri.parse(data);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        send(TastyPieDTO('getResponse', {
          'body': response.body,
          'status': response.statusCode,
          state: state
        }));
      }
    } catch (e) {
      print('Error RestApi $e');
      send(TastyPieDTO('error', 'Error RestApi $e'));
    }
  }
}
