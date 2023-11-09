// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$NewsService extends NewsService {
  _$NewsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsService;

  @override
  Future<Response<dynamic>> getTopHeadlines(
      {String sources = 'techcrunch.com,thenextweb.com'}) {
    final Uri $url = Uri.parse('/v2/everything');
    final Map<String, dynamic> $params = <String, dynamic>{'domains': sources};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
