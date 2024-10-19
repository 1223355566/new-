import 'package:flutter/material.dart';
import '../../data/api_manager.dart';
import '../../model/articles_respons_DM.dart';
import '../news_details/newsDetials.dart';

class NewsSearch extends SearchDelegate
{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: ()=>showResults(context),
          icon: Icon(Icons.search,
            size: 25,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close,
          size: 25,));
  }

  @override
  Widget buildResults (BuildContext context) {
   return FutureBuilder<ArticlesResponsDM>(
       future: APiManager.getArticles(searchKeyword: query),
       builder: (context, snapShot) {
         if (snapShot.hasError) {
           return Text(snapShot.error.toString());
         }
         else if (snapShot.hasData) {
           return ListView.builder(
               itemCount: snapShot.data!.articles!.length
               ,itemBuilder: (context,index){
                 return
                   buildNewsWidget(snapShot.data!.articles![index],context);
               });
         } else {
           return const Center(child: CircularProgressIndicator());
         }
       });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
 if(query.isEmpty)  {
   return const Center(child: Text("Enter Search Word....!"));
 }
 else {
      return FutureBuilder<ArticlesResponsDM>(
          future: APiManager.getArticles(searchKeyword: query),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Text(snapShot.error.toString());
            } else if (snapShot.hasData) {
              return ListView.builder(
                  itemCount: snapShot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    return buildNewsWidget(
                        snapShot.data!.articles![index], context);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    }
  }
  Widget buildNewsWidget(ArticleDM article,BuildContext context){
    return InkWell(onTap:(){
      Navigator.pushNamed(context,NewsDetails.routeName,arguments: article);
    },
      child: Container(margin:const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(alignment: Alignment.center,
              children: [const CircularProgressIndicator(),
                ClipRRect(borderRadius: BorderRadius.circular(12),
                  child:   Image.network(article.urlToImage??
                      "https://static.coloradolottery.com/media/filer_public/02/25/0225a196-0cbf-4af0-b913-2119c60b724e/placeholder-news.png"
                      ,height: MediaQuery.of(context).size.height*.25,fit:BoxFit.fill),
                ),
              ],
            ),
            const SizedBox(height: 4,),
            Text(article.author??"",textAlign: TextAlign.start,style: const TextStyle(fontSize: 12,color:  Color(0xff79828B))),
            const SizedBox(height: 8,),
            Text(article.title??"",textAlign: TextAlign.start,style: const TextStyle(fontWeight: FontWeight.bold
                ,fontSize: 15,color: Color(0xff42505C))),
            const SizedBox(height: 4,),
            Text(article.publishedAt??"",textAlign: TextAlign.end,style: const TextStyle(fontSize: 13,color: const Color(0xffA3A3A3))),
          ],),
      ),
    );


  }
}