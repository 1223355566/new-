import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import '../../model/articles_respons_DM.dart';

class NewsDetails extends StatelessWidget {
  static String routeName = "newsDetails";

  @override
  Widget build(BuildContext context) {
    ArticleDM article = ModalRoute.of(context)!.settings.arguments as ArticleDM;
    return Scaffold(
      appBar: AppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        buildNewsWidget(article, context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            article.description ?? "",
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              _launchUrl(article.url);
            },
            child: const Row(
              children: [
                Text(
                  "View Full Article",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right_outlined,
                  color: Colors.black,
                )
              ],
            )),
        Spacer()
      ]),
    );
  }

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    // Using easy_url_launcher to launch the URL
    await EasyLauncher.url(
      url: url,
    );
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
