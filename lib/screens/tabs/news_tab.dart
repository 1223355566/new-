import 'package:flutter/material.dart';

import 'package:news2/model/category_dm.dart';
import 'package:news2/model/sourcesResponse.dart';
import 'package:news2/screens/tabs/tab_content.dart';
import '../../data/api_manager.dart';

class NewsTab extends StatefulWidget {
  CategoryDM selsctedCategory;

  NewsTab(this.selsctedCategory);

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourcesResponseDM>(
        future: APiManager.getSources(widget.selsctedCategory.id),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Text(snapShot.error.toString());
          } else if (snapShot.hasData) {
            return getScreenBody(snapShot.data!.sources!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getScreenBody(List<SourcesDM> sources) {
    return DefaultTabController(
        length: sources.length,
        child: Column(children: [
          SizedBox(
            height: 22,
          ),
          TabBar(
            tabs: sources.map((source) {
              return getTab(source, currentTab == sources.indexOf(source));
            }).toList(),
            onTap: (index) {
              currentTab = index;
              setState(() {});
            },
            isScrollable: true,
            indicatorColor: Colors.transparent,
          ),
          Expanded(
            child: TabBarView(
                children: sources.map((source) {
              return TabContent(source);
            }).toList()),
          ),
        ]));
  }

  Widget getTab(SourcesDM sources, bool isSelected) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color.fromRGBO(57, 165, 82, 100)),
          color: isSelected
              ? const Color.fromRGBO(57, 165, 82, 100)
              : Colors.white,
        ),
        child: Text(
          sources.name ?? "unknown",
          style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color.fromRGBO(57, 165, 82, 100)),
        ));
  }
}
