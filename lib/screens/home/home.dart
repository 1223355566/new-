import 'package:flutter/material.dart';
import 'package:news2/screens/news_search/newsSearch.dart';
import 'package:news2/screens/tabs/news_tab.dart';

import '../../model/category_dm.dart';
import '../tabs/categories/categories_tab.dart';
import '../tabs/settings/settings.dart';

class Home extends StatefulWidget {
  static String routeName = "home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM? selectedCategory;
  late Widget selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = CategorisesTab(setSelectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (selectedTab is CategorisesTab) {
          return Future.value(true);
        } else {
          selectedTab = CategorisesTab(setSelectedCategory);
          setState(() {});
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: NewsSearch()),
              icon: Icon(Icons.search, size: 28),
            )
          ],
          centerTitle: true,
          title: const Text(
            "News",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromRGBO(57, 165, 82, 1),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: selectedTab,
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("News App!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.newspaper,
                  size: 40, color: Color.fromRGBO(57, 165, 82, 1)),
            ),
            decoration: BoxDecoration(color: Color.fromRGBO(57, 165, 82, 1)),
          ),
          buildDrawerItem(context, "Categories", Icons.menu, () {
            selectedCategory = null;
            selectedTab = CategorisesTab(setSelectedCategory);
            setState(() {});
          }),
          buildDrawerItem(context, "Settings", Icons.settings, () {
            selectedTab = SettingsTab();
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget buildDrawerItem(
      BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.black),
      title: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }

  void setSelectedCategory(CategoryDM category) {
    selectedCategory = category;
    selectedTab = NewsTab(selectedCategory!);
    setState(() {});
    print("Changed the selected category to ${selectedCategory?.title}");
  }
}
