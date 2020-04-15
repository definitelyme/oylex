class Level {
  final String id;
  final String contentId;
  final String title;
  final String subtitle;
  final String description;
  final STATUS status;
  final List<Level> children;

  Level(
      {this.id,
      this.contentId,
      this.title,
      this.subtitle,
      this.description,
      this.children = const <Level>[],
      this.status = STATUS.INCOMPLETE});
}

enum STATUS {
  INCOMPLETE,
  IN_PROGRESS,
  COMPLETE,
}
