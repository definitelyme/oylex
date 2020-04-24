import 'package:oylex/Models/base-model.dart';

class CourseCategory extends Model {
  final String name;

  CourseCategory({String id, this.name}) : super(id: id);

  static List<CourseCategory> dummyCategories() {
    return [
      CourseCategory(id: 'science', name: "Science"),
      CourseCategory(id: 'law', name: "Law"),
      CourseCategory(id: 'mathematics', name: "Mathmatics"),
      CourseCategory(id: 'gst', name: "General Studies"),
      CourseCategory(id: 'technology', name: "Technology"),
      CourseCategory(id: 'arts-design', name: "Arts & Design"),
      CourseCategory(id: 'engineering', name: "Engineering"),
    ];
  }
}
