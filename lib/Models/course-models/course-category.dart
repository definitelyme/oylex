import 'package:oylex/Models/base-model.dart';
import 'package:oylex/Models/course-models/course.dart';

class CourseCategory extends Model {
  final String name;
  List<Course> courses;

  CourseCategory({
    String id,
    this.name,
    this.courses,
  }) : super(id: id);

  void addCourse(Course course) {
    if (courses == null) courses = new List<Course>();
    if (!courses.any((val) => val.id == course.id)) courses.add(course);
  }

  static List<CourseCategory> dummyCategories() {
    return [
      CourseCategory(id: 'science', name: "Science"),
      CourseCategory(id: 'law', name: "Law"),
      CourseCategory(id: 'mathematics', name: "Mathematics"),
      CourseCategory(id: 'gst', name: "General Studies"),
      CourseCategory(id: 'management', name: "Management"),
      CourseCategory(id: 'technology', name: "Technology"),
      CourseCategory(id: 'arts-design', name: "Arts & Design"),
      CourseCategory(id: 'engineering', name: "Engineering"),
    ];
  }
}
