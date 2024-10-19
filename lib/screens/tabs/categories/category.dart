



import 'package:flutter/material.dart';

import '../../../model/category_dm.dart';

class Category extends StatelessWidget {
  CategoryDM categoryDM;
  Category({required this.categoryDM});
 double radius=30;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( color:categoryDM.backgroundColor,borderRadius:
      BorderRadius.only(topRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
      bottomLeft: categoryDM.isleftside ?
      Radius.circular(radius) :const Radius.circular(0),
        bottomRight: categoryDM.isleftside ?
        const Radius.circular(0):Radius.circular(radius) ,
      )),
      child: Column(
        children: [
          Spacer(),
          Image.asset(categoryDM.imagePath,),
          Spacer(),
          Text(categoryDM.title,style:const TextStyle(fontWeight:FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
}
