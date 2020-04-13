import 'package:oylex/Foundation/Utils/constants.dart';

class Category {
  final String title;
  final String image;

  Category({this.title, this.image});

  static List<Category> generatedCategories() {
    return [
      Category(
          title: "Arts and Humanities",
          image: "$IMAGES_FOLDER/knowledge-03.jpg"),
      Category(title: "Computer Science", image: "$INTRO_IMAGES_FOLDER/10.png"),
      Category(
          title: "Economics and Marketing",
          image: "$IMAGES_FOLDER/laravel-1.jpg"),
      Category(
          title: "Social Enginerring", image: "$INTRO_IMAGES_FOLDER/13.png"),
      Category(
          title: "Law and The Government",
          image: "$INTRO_IMAGES_FOLDER/browse-courses.png"),
      Category(
          title: "Biological Sciences", image: "$INTRO_IMAGES_FOLDER/1.png"),
    ];
  }
}
