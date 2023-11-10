import 'package:flutter/material.dart';
import 'package:newsapp/Models/article_model.dart';
import 'package:newsapp/Helps/news.dart';
import 'package:newsapp/Screens/article_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    News news = News();
    List<ArticleModel> fetchedArticles = await news.getNews();
    setState(() {
      articles = fetchedArticles;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'App',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
            child: CircularProgressIndicator(),
          )
          : Slide(articles: articles),
      // ScrollView News
      // body: _loading
      //     ? Center(
      //         child: Container(
      //         child: CircularProgressIndicator(),
      //       ))
      //     : SingleChildScrollView(
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 16),
      //           child: Column(
      //             children: <Widget>[
      //               Container(
      //                 padding: EdgeInsets.only(top: 16),
      //                 child: ListView.builder(
      //                     shrinkWrap: true,
      //                     physics: ClampingScrollPhysics(),
      //                     itemCount: articles.length,
      //                     itemBuilder: (context, index) {
      //                       return BlogTile(
      //                         imageUrl: articles[index].urlToImage,
      //                         title: articles[index].title,
      //                         description: articles[index].description,
      //                         url: articles[index].url,
      //                       );
      //                     }),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Article_View(
                      blogUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: TextStyle(color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final List<ArticleModel> articles;
  Slide({required this.articles});

  @override
  Widget build(BuildContext context) {
    double slideHeight = MediaQuery.of(context).size.height * 0.6;

    return Center(
      child: Container(
        height: slideHeight,
        child: CarouselSlider.builder(
          itemCount: articles.length,
          options: CarouselOptions(
            height: 500.0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            viewportFraction: 0.9,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return NewsCard(article: articles[index]);
          },
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final ArticleModel article;
  NewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Article_View(blogUrl: article.url),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  child: Image.network(
                    article.urlToImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      article.description ?? '',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}