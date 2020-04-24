import 'package:oylex/Models/base-model.dart';

class Level extends Model {
  final String contentId;
  final String title;
  final String subtitle;
  final String description;
  final STATUS status;
  final List<Level> children;

  Level({
    String id = "default-id",
    this.contentId,
    this.title,
    this.subtitle,
    this.description,
    this.children = const <Level>[],
    this.status = STATUS.INCOMPLETE,
  }) : super(id: id);
}

enum STATUS {
  INCOMPLETE,
  IN_PROGRESS,
  COMPLETE,
}
