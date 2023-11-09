import 'package:chopper/chopper.dart';
import 'package:newsapp/Models/article_model.dart';
part 'news.chopper.dart';

@ChopperApi(baseUrl: '/v2')
abstract class NewsService extends ChopperService {

  static NewsService create() {
    List<ArticleModel> news = [];
    final client = ChopperClient(
      baseUrl: Uri.parse('https://newsapi.org'),
      services: [_$NewsService()],
      converter: JsonConverter(),
      interceptors: [
            (Request request) async {
          final headers = {
            'Content-Type': 'application/json',
            'Authorization': 'f17f2121442743eb97e0f29dbfc0bcf3',
          };
          return request.copyWith(headers: headers);
        },
      ],
    );
    return _$NewsService(client);
  }

  // @Get(path: '/top-headlines')
  // Future<Response<List<ArticleModel>>> getTopHeadlines({
  //   @Query('sources') String sources = 'bbc-news'
  // });

  @Get(path: '/top-headlines')
  Future<Response> getTopHeadlines({
    @Query('sources') String sources = 'bbc-news'
  });

}

void main() async {
  final newsService = NewsService.create();
  final response = await newsService.getTopHeadlines();

  if (response.isSuccessful) {
    final newsList = (response.body['articles'] as List).map((json) => ArticleModel.fromJson(json)).toList();

    for (var news in newsList) {
      print('Author: ${news.author}');
      print('Title: ${news.title}');
      print('Description: ${news.description}');
      print('URL: ${news.url}');
      print('urlToImage: ${news.urlToImage}');
      print('Content: ${news.content}');
      print('---------------------');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }

  // if (response.isSuccessful) {
  //   final articles = response.body;
  //   print(articles);
  // } else {
  //   print('Request failed with status: ${response.statusCode}');
  // }
}