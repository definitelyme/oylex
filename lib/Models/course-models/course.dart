import 'package:oylex/Foundation/Utils/constants.dart';

class Course {
  final String id;
  final String title;
  final String image;

  Course({this.id, this.title, this.image});

  static List<Course> generatedCourses() {
    return [
      Course(
          id: "id-arts",
          title: "Arts and Humanities",
          image: "$IMAGES_FOLDER/knowledge-03.jpg"),
      Course(
          id: "id-compiter-sciences",
          title: "Computer Science",
          image: "$INTRO_IMAGES_FOLDER/10.png"),
      Course(
          id: "id-econnomics",
          title: "Economics and Marketing",
          image: "$IMAGES_FOLDER/laravel-1.jpg"),
      Course(
          id: "id-social-eng",
          title: "Social Enginerring",
          image: "$INTRO_IMAGES_FOLDER/13.png"),
      Course(
          id: "id-law",
          title: "Law and The Government",
          image: "$INTRO_IMAGES_FOLDER/browse-courses.png"),
      Course(
          id: "id-bio-sciences",
          title: "Biological Sciences",
          image: "$INTRO_IMAGES_FOLDER/1.png"),
    ];
  }
}
