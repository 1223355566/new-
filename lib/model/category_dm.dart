
import 'package:flutter/material.dart';

class CategoryDM
{
  String id;
  String title;
  String imagePath;
  bool isleftside;
  Color backgroundColor;

  CategoryDM({required this.id,
    required this.title,
    required this.imagePath,
    required this.isleftside,
    required this.backgroundColor});

  static List<CategoryDM> categories=[
    CategoryDM(id:"sports",title: "Sports",imagePath: "assets/sports.png"
      ,isleftside: true,backgroundColor: Colors.red[900]!),
    CategoryDM(id:"technology",title: "Technology",imagePath: "assets/science.png"
        ,isleftside: false,backgroundColor: Colors.blue[900]!),

    CategoryDM(id:"health",title: "Health",imagePath: "assets/health.png"
        ,isleftside: true,backgroundColor: Colors.pink[900]!),

    CategoryDM(id:"business",title: "Business",imagePath: "assets/bussines.png"
        ,isleftside: false,backgroundColor: Colors.orange[900]!),

    CategoryDM(id:"entertainment",title: "Entertainment",imagePath: "assets/environment.png"
        ,isleftside: true,backgroundColor: Colors.lightBlue),
    CategoryDM(id:"science",title: "Science",imagePath: "assets/science.png"
        ,isleftside: false,backgroundColor: Colors.yellow[500]!),
  ];
}
