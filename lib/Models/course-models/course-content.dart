import 'package:oylex/Models/base-model.dart';
import 'package:oylex/Models/course-models/content-levels.dart';

class Content extends Model {
  final String courseId;
  final String title;
  final String description;
  final List<Level> levels;

  Content({String id, this.courseId, this.title, this.description, this.levels}) : super(id: id);
}
