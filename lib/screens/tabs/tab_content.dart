import 'package:flutter/material.dart';
import 'package:news2/model/sourcesResponse.dart';
import 'package:news2/screens/news_details/newsDetials.dart';
import '../../data/api_manager.dart';
import '../../model/articles_respons_DM.dart';

class TabContent extends StatefulWidget {
  SourcesDM sourcesDM;
  TabContent(this.sourcesDM);
  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent> {
  final scrollController = ScrollController();
  int page = 1;
  bool shouldLoadNextPage = false;
  List<ArticleDM> articleList = [];

  @override
  void initState() {
    super.initState();
    // Setup the listener.
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          shouldLoadNextPage = true;
          scrollController.position.jumpTo(0);
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shouldLoadNextPage == true) {
      APiManager.getArticles(sourceId: widget.sourcesDM.id!, page: page++)
          .then((articlesRespons) {
        articleList.addAll(articlesRespons.articles ?? []);
        shouldLoadNextPage = false;
        setState(() {});
      });
    }
    return FutureBuilder<ArticlesResponsDM>(
        future:
            APiManager.getArticles(sourceId: widget.sourcesDM.id!, page: page),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Text(snapShot.error.toString());
          } else if (snapShot.hasData) {
            articleList = snapShot.data!.articles!;
            return ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (context, index) {
                print(index);
                return buildNewsWidget(articleList[index], context);
              },
              controller: scrollController,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildNewsWidget(ArticleDM article, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NewsDetails.routeName, arguments: article);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                      article.urlToImage ??
                          "https://static.coloradolottery.com/media/filer_public/02/25/0225a196-0cbf-4af0-b913-2119c60b724e/placeholder-news.png",
                      height: MediaQuery.of(context).size.height * .25,
                      fit: BoxFit.fill),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(article.author ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 12, color: Color(0xff79828B))),
            const SizedBox(
              height: 8,
            ),
            Text(article.title ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xff42505C))),
            const SizedBox(
              height: 4,
            ),
            Text(article.publishedAt ?? "",
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 13, color: const Color(0xffA3A3A3))),
          ],
        ),
      ),
    );
  }
}
