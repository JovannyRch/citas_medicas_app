import 'dart:convert';
import 'package:citas_medicas_app/enviroment/enviroment.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    final resp = await http.post(formatUrl(url),
        body: jsonEncode(data), headers: await _getHeaders());
    return resp;
  }

  Future<http.Response> put(String url, Map<String, dynamic> data) async {
    final resp = await http.put(formatUrl(url),
        body: jsonEncode(data), headers: await _getHeaders());

    return resp;
  }

  Future<http.Response> get(String url) async {
    final resp = await http.get(formatUrl(url), headers: await _getHeaders());

    return resp;
  }

  Future<http.Response> delete(String url) async {
    final resp =
        await http.delete(formatUrl(url), headers: await _getHeaders());

    return resp;
  }

  Future<Map<String, String>> _getHeaders() async {
    return {'Content-Type': 'application/json'};
  }

  Uri formatUrl(String endpointService) {
    String finalEndpoint = "${Enviroment.apiUrl}$endpointService";
    print(finalEndpoint);
    return Uri.parse(finalEndpoint);
  }
}
