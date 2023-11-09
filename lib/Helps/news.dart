import 'package:newsapp/Services/service.dart';
import 'package:newsapp/Models/article_model.dart';

class News {
  Future<List<ArticleModel>> getNews() async {
    List<ArticleModel> news = [];
    final newsService = NewsService.create();
    final response = await newsService.getTopHeadlines();
    final newsList = (response.body['articles'] as List).map((json) =>
        ArticleModel.fromJson(json)).toList();
    for (var news_detail in newsList) {
      ArticleModel articleModel = ArticleModel(
        title: news_detail.title,
        author: news_detail.author,
        description: news_detail.description,
        url: news_detail.url,
        urlToImage: news_detail.urlToImage,
        content: news_detail.content,
      );
      news.add(articleModel);
    }
    return news;
  }
}

// void main() async {
//   News newsInstance = News();
//   List<ArticleModel> news = await newsInstance.getNews();
//   for (var article in news) {
//     print('Title: ${article.title}');
//     print('Author: ${article.author}');
//     print('Description: ${article.description}');
//     print('URL: ${article.url}');
//     print('URL to Image: ${article.urlToImage}');
//     print('Content: ${article.content}');
//     print('---------------------');
//   }
// }