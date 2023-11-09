import 'package:chopper/chopper.dart';
import 'package:newsapp/Models/article_model.dart';
part 'service.chopper.dart';

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
  // Future<Response> getTopHeadlines({
  //   @Query('sources') String sources = 'bbc-news'
  // });

  @Get(path: '/everything')
  Future<Response> getTopHeadlines({
    @Query('domains') String sources = 'techcrunch.com,thenextweb.com'
  });
}


// void main() async {
//   List<ArticleModel> news = [];
//   final newsService = NewsService.create();
//   final response = await newsService.getTopHeadlines();
//
//   if (response.isSuccessful) {
//     // List<ArticleModel> news = [];
//     final newsList = (response.body['articles'] as List).map((json) => ArticleModel.fromJson(json)).toList();
//
//     for (var news_detail in newsList) {
//       ArticleModel articleModel = ArticleModel(
//         title: news_detail.title,
//         author: news_detail.author,
//         description: news_detail.description,
//         url: news_detail.url,
//         urlToImage: news_detail.urlToImage,
//         content: news_detail.content,
//       );
//       news.add(articleModel);
//       // print('Author: ${news.author}');
//       // print('Title: ${news.title}');
//       // print('Description: ${news.description}');
//       // print('URL: ${news.url}');
//       // print('urlToImage: ${news.urlToImage}');
//       // print('Content: ${news.content}');
//       // print('---------------------');
//     }
//     for (var article in news) {
//       print('Title: ${article.title}');
//       print('Author: ${article.author}');
//       print('Description: ${article.description}');
//       print('URL: ${article.url}');
//       print('URL to Image: ${article.urlToImage}');
//       print('Content: ${article.content}');
//       print('---------------------');
//     }
//   } else {
//     print('Request failed with status: ${response.statusCode}');
//   }

  // if (response.isSuccessful) {
  //   final articles = response.body;
  //   print(articles);
  // } else {
  //   print('Request failed with status: ${response.statusCode}');
  // }
// }