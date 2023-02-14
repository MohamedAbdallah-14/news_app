import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:news_app/data/api_manager/models/failures/failure.dart';
import 'package:news_app/data/api_manager/models/failures/failure_info.dart';
import 'package:news_app/data/api_manager/models/request/request.dart';
import 'package:news_app/helpers/dio2curl.dart';
import 'package:news_app/helpers/request_to_curl.dart';
import 'package:path_provider/path_provider.dart';

abstract class ReportableFailure extends Failure {
  ReportableFailure({
    required this.failureInfo,
    required this.type,
  });
  final FailureInfo failureInfo;
  final String type;

  Future<String> generateReport() async {
    var text = 'Failure Report:\n${dateTime(id)}\nID: $id\nType: $type\n';

    //Exception
    if (failureInfo.exception != null) {
      text += 'Exception: ${failureInfo.exception}\n';
    }

    text += await requestInfo(failureInfo.request);

    text += await responseInfo(failureInfo.response);

    text = text.replaceAll('{', '{\n');
    text = text.replaceAll(',', ',\n');
    text = text.replaceAll('}', '\n}');

    return base64.encode(utf8.encode(text));
  }

  Future<File> toFile() async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/ErrorReposrt-$id.txt');
    final report = await generateReport();
    await file.writeAsString(report);

    return file;
  }

  String dateTime(String id) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(id) * 1000);
    final formattedDateTime =
        DateFormat('yyyy-MM-dd').add_jm().format(dateTime);

    return 'DateTime: $formattedDateTime\n';
  }

  Future<String> requestInfo(Request? request) async {
    var text = '';
    if (request != null) {
      text += '\nRequest:\n';
      text += 'URL: ${failureInfo.request!.url}\n';
      text += 'Method: ${failureInfo.request!.method}\n';
      //Query Parameters
      text += 'Query Parameters:\n';
      text += '${await failureInfo.request!.queryParameters}\n';

      //Data
      final data = await failureInfo.request!.data;
      if (data != null) {
        text += 'Data:\n';
        text += '${await failureInfo.request!.data}\n';
      }
      if (failureInfo.response?.requestOptions == null) {
        //headers
        text += 'Request Headers:\n';
        text += '${failureInfo.request!.headers}\n';
        //curl
        final curl = await request2curl(failureInfo.request);
        if (curl != null) {
          text += '\nStart Curl:\n\n';
          text += '$curl\n';
          text += '\nEnd Curl\n\n';
        }
      }
    }

    return '\n$text';
  }

  Future<String> responseInfo(Response<dynamic>? response) async {
    var text = '';

    if (response != null) {
      text += 'Request Headers:\n';
      text += '${failureInfo.response?.requestOptions.headers}\n';
      final curl = dio2curl(failureInfo.response?.requestOptions);
      if (curl != null) {
        text += '\nStart Curl:\n\n';
        text += '$curl\n';
        text += 'End Curl\n\n';
      }
      text += 'Response:\n';
      text += 'Status: ${failureInfo.response?.statusCode}\n';
      text += 'Response Headers:\n';
      text += '${failureInfo.response?.headers}\n';
      text += 'Data:\n';
      text += '${failureInfo.response?.data}\n';
    }

    return '\n$text';
  }

  @override
  List<Object?> get props => [id, failureInfo, type];
}
