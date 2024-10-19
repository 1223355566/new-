import 'package:http/http.dart';

import 'dart:convert';

import 'package:news2/model/sourcesResponse.dart';
import '../model/articles_respons_DM.dart';

abstract class APiManager {
  static const String key = "05f5962de7de413890219f102c4f6926";
  static const String baseUrl = "newsapi.org";

  static Future<SourcesResponseDM> getSources(String CategoryId) async {
    Uri url = Uri.https(baseUrl, 'v2/top-headlines/sources',
        {"apiKey": key, "category": CategoryId});
    Response response = await get(url);
    Map json = jsonDecode(response.body) as Map;
    SourcesResponseDM sourceResponse = SourcesResponseDM.fromJson(json);
    if (sourceResponse.code != null) {
      throw Exception(sourceResponse.code);
    }
    return sourceResponse;
  }

  static Future<ArticlesResponsDM> getArticles(
      {String? sourceId, String? searchKeyword, int? page}) async {
    Uri url = Uri.https(baseUrl, 'v2/everything', {
      "apiKey": key,
      "sources": sourceId,
      "q": searchKeyword,
      "pageSize": "20",
      "page": "$page"
    });
    Response response = await get(url);
    print("ArticlesResponsDM${response.body}");
    Map json = jsonDecode(response.body) as Map;
    ArticlesResponsDM articlesResponsDM = ArticlesResponsDM.fromJson(json);
    if (articlesResponsDM.code != null) {
      throw Exception(articlesResponsDM.code);
    }
    return articlesResponsDM;
  }
}
