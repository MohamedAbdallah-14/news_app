import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/helpers/app_logger.dart';

String? dio2curl(RequestOptions? requestOption) {
  if (requestOption == null) return null;
  var curl = '';
  // Add PATH + REQUEST_METHOD
  curl +=
      """curl --request ${requestOption.method} '${requestOption.baseUrl}${requestOption.path}' """;
  // Include queryParamters
  var buffer = StringBuffer();
  if (requestOption.queryParameters.isNotEmpty) {
    curl += '-G';
    requestOption.queryParameters.forEach((key, value) {
      buffer.write(' --data-urlencode "$key=$value"');
    });
    curl += buffer.toString();
  }
  // Include headers
  buffer = StringBuffer();
  for (final key in requestOption.headers.keys) {
    if (key == 'content-length') continue;
    buffer.write(" -H '$key: ${requestOption.headers[key]}'");
  }
  curl += buffer.toString();
  // Include data if there is data
  if (requestOption.data != null) {
    curl += " --data-binary '${jsonEncode(requestOption.data)}'";
  }
  if (shouldLog) AppLogger.instance.log(curl);

  return curl;
}
