import 'package:flutter/material.dart';
import 'package:news2/screens/tabs/categories/category.dart';
import '../../../model/category_dm.dart';

class CategorisesTab extends StatelessWidget {
  static String routeName = "categorisesTab";
  Function(CategoryDM) onCategoryClick;
  CategorisesTab(this.onCategoryClick);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(flex: 1),
          Text(
            "pick your category of interest",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        onCategoryClick(CategoryDM.categories[index]);
                      },
                      child:
                          Category(categoryDM: CategoryDM.categories[index]));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
