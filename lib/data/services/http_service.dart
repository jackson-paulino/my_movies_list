import 'dart:convert';

import 'package:http/http.dart' as http;

class Response {
  int statusCode;
  Map<String, dynamic>? content;
  Exception? exception;

  Response({required this.statusCode, this.content, this.exception});

  bool get success => statusCode == 200;
}

class HttpService {
  final _cliente = http.Client();

  Future<Response> getRequest(String uri,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    if (params != null) {
      uri += _buildQueryString(params);
    }
    var httpResponse = await _cliente.get(Uri.parse(uri), headers: headers);
    return _parseHttpResponse(httpResponse);
  }

  Future<Response> postRequest(String uri, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    } else {
      headers = {'Content-Type': 'application/json'};
    }
    var httpResponse = await _cliente.post(Uri.parse(uri),
        body: jsonEncode(body), headers: headers);
    return _parseHttpResponse(httpResponse);
  }

  Future<Response> putRequest(String uri, Map<String, dynamic> body) async {
    var httpResponse =
        await _cliente.put(Uri.parse(uri), body: jsonEncode(body));
    return _parseHttpResponse(httpResponse);
  }

  Future<Response> deleteRequest(String uri) async {
    var httpResponse = await _cliente.delete(Uri.parse(uri));
    return _parseHttpResponse(httpResponse);
  }

  Response _parseHttpResponse(http.Response httpResponse) {
    Response response;

    try {
      response = Response(
          statusCode: httpResponse.statusCode,
          content: jsonDecode(httpResponse.body));
    } on Exception catch (e) {
      response = Response(statusCode: 500, exception: e);
    }
    return response;
  }

  String _buildQueryString(Map<String, dynamic> paramns) {
    var output = '?';

    paramns.forEach((key, value) {
      output += '$key=$value&';
    });
    return output;
  }
}
