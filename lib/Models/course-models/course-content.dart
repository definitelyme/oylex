import 'dart:math' as Math;

import 'package:oylex/Models/course-models/content-levels.dart';
import 'package:oylex/Models/course-models/course.dart';

class Content {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final List<Level> levels;

  Content({this.id, this.courseId, this.title, this.description, this.levels});

  static Content generatedContentForCourse(Course course) {
    const desc =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    return Content(id: "art-fundamentals", courseId: course.id, levels: [
      Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Fundamentals of Art",
          description: desc,
          children: <Level>[
            Level(
              contentId: "art-fundamentals",
              title: "What is Art?",
              subtitle: "What does it really mean?",
            ),
            Level(
                contentId: "art-fundamentals",
                title: "Different Forms of Art",
                subtitle: "It is not just painting"),
            Level(
                contentId: "art-fundamentals",
                title: "Art Principles",
                subtitle: "Why are they important?"),
            Level(
                contentId: "art-fundamentals",
                title: "Color Theory",
                subtitle: "Understanding Color"),
          ]),
      Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Approches to Art History",
          description: desc,
          children: <Level>[
            Level(
                contentId: "art-history",
                title: "An Introduction",
                description: desc,
                subtitle: "Where does it matter?"),
          ]),
      Level(
        id: "${Math.Random.secure().nextDouble()}",
        title: "${course.title} - Art & Design Fundamentals",
        description: desc,
        contentId: "art-n-design",
      )
    ]);
  }
}
