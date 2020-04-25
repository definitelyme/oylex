import 'dart:math' as Math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oylex/Foundation/Utils/constants.dart';
import 'package:oylex/Models/base-model.dart';
import 'package:oylex/Models/course-models/content-levels.dart';
import 'package:oylex/Models/course-models/course-category.dart';
import 'package:oylex/Models/course-models/course-content.dart';
import 'package:oylex/Models/user-models/user.dart';

class Course extends Model {
  final String title;
  final String image;
  final CourseCategory category;
  final User user;
  final Content content;
  final double progress;
  final String tag;
  final double rating;
  final String currency;
  final String price;
  final String oldPrice;

  Course({
    String id,
    @required this.title,
    this.image,
    this.category,
    this.user,
    this.content,
    this.progress = 0.0,
    this.tag,
    this.rating = 1.0,
    this.price,
    this.currency = "NGN",
    this.oldPrice,
  })  : assert(image != null),
        assert(progress <= 1.0),
        assert(price != null),
        assert(rating <= 5.0),
        super(id: id);

  static List<Course> generatedCourses() {
    List<User> dummyUsers = User.dummyUsers();
    List<CourseCategory> categories = CourseCategory.dummyCategories();

    return [
      Course(
        id: "id-arts",
        title: "Arts and Humanities",
        image: "$IMAGES_FOLDER/knowledge-03.jpg",
        category: categories.firstWhere((category) => category.id == "arts-design"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.62,
        tag: "New",
        rating: 4.6,
        price: "550",
      ),
      Course(
        id: "id-computer-sciences",
        title: "Computer Science",
        image: "$MISC_IMAGES_FOLDER/02.jpg",
        category: categories.firstWhere((category) => category.id == "science"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.27,
        rating: 3.3,
        price: "340",
        oldPrice: "130",
      ),
      Course(
        id: "id-econnomics",
        title: "Economics and Marketing",
        image: "$IMAGES_FOLDER/laravel-1.jpg",
        category: categories.firstWhere((category) => category.id == "management"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.45,
        rating: 2.3,
        price: "190",
      ),
      Course(
        id: "id-social-eng",
        title: "Social Engineering",
        image: "$INTRO_IMAGES_FOLDER/13.png",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.86,
        tag: "Best",
        rating: 5.0,
        price: "550",
        oldPrice: "30",
      ),
      Course(
        id: "id-law",
        title: "Law and The Government",
        image: "$MISC_IMAGES_FOLDER/02.jpg",
        category: categories.firstWhere((category) => category.id == "law"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.73,
        rating: 3.1,
        price: "420",
        oldPrice: "700",
      ),
      Course(
        id: "id-bio-sciences",
        title: "Biological Sciences",
        image: "$MISC_IMAGES_FOLDER/03.jpg",
        category: categories.firstWhere((category) => category.id == "science"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.3,
        tag: "Best",
        rating: 4.2,
        price: "600",
        oldPrice: "240",
      ),
      Course(
        id: "id-pet-eng-resevoir-1",
        title: "Petroleum Reservoir I",
        image: "$INTRO_IMAGES_FOLDER/10.png",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.57,
        rating: 3.7,
        price: "550",
        oldPrice: "490",
      ),
      /////////
      Course(
        id: "id-gst-108",
        title: "General Studies, GST 102",
        image: "$MISC_IMAGES_FOLDER/04.jpg",
        category: categories.firstWhere((category) => category.id == "gst"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.57,
        rating: 2.0,
        price: "340",
        oldPrice: "306",
      ),
      Course(
        id: "id-pet-eng-resevoir-2",
        title: "Petroleum Reservoir II",
        image: "$MISC_IMAGES_FOLDER/01.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.14,
        tag: "New",
        rating: 1.7,
        price: "550",
        oldPrice: "210",
      ),
      Course(
        id: "id-pet-eng-prod-1",
        title: "Petroleum Production I",
        image: "$MISC_IMAGES_FOLDER/03.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.7,
        tag: "Popular",
        rating: 2.3,
        price: "420",
        oldPrice: "70",
      ),
      Course(
        id: "id-drilling-tech-1",
        title: "Drilling Technology I",
        image: "$MISC_IMAGES_FOLDER/04.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.81,
        rating: 4.5,
        price: "550",
        oldPrice: "109",
      ),
      Course(
        id: "id-pet-eng-resevoir-3",
        title: "Petroleum Reservoir III",
        image: "$MISC_IMAGES_FOLDER/03.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.4,
        tag: "Popular",
        rating: 4.2,
        price: "220",
        oldPrice: "500",
      ),
      Course(
        id: "id-drilling-tech-3",
        title: "Drilling Technology III",
        image: "$MISC_IMAGES_FOLDER/01.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.52,
        rating: 3.8,
        price: "550",
        oldPrice: "1000",
      ),
      Course(
        id: "id-pet-eng-prod-2",
        title: "Petroleum Production II",
        image: "$MISC_IMAGES_FOLDER/04.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.22,
        rating: 2.1,
        price: "600",
        oldPrice: "2490",
      ),
      Course(
        id: "id-drilling-tech-2",
        title: "Drilling Technology II",
        image: "$MISC_IMAGES_FOLDER/03.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.63,
        tag: "Popular",
        rating: 1.8,
        price: "340",
      ),
      Course(
        id: "thermo-1",
        title: "Thermodynamics",
        image: "$MISC_IMAGES_FOLDER/01.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.18,
        rating: 3.1,
        price: "1000",
      ),
      Course(
        id: "pet-204",
        title: "Petroleum Basic Geology, PET 204",
        image: "$MISC_IMAGES_FOLDER/04.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.93,
        tag: "New",
        rating: 2.80,
        price: "830",
      ),
      Course(
        id: "id-pet-eng-pollution",
        title: "Petroleum Pollution Control, PET 511",
        image: "$MISC_IMAGES_FOLDER/03.jpg",
        category: categories.firstWhere((category) => category.id == "engineering"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.36,
        rating: 3.7,
        price: "340",
      ),
      Course(
        id: "id-eng-maths-1",
        title: "Engineering Mathematics I",
        image: "$IMAGES_FOLDER/laravel-2.jpg",
        category: categories.firstWhere((category) => category.id == "mathematics"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.33,
        tag: "Selling",
        rating: 2.8,
        price: "450",
      ),
      Course(
        id: "id-pet-econs",
        title: "Petroleum Economics, PET 519",
        image: "$MISC_IMAGES_FOLDER/04.jpg",
        category: categories.firstWhere((category) => category.id == "management"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.76,
        rating: 5.0,
        price: "600",
      ),
      Course(
        id: "id-est-308",
        title: "Quantity Analysis, EST 308",
        image: "$MISC_IMAGES_FOLDER/01.jpg",
        category: categories.firstWhere((category) => category.id == "technology"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.67,
        tag: "New",
        rating: 3.7,
        price: "150",
      ),
      Course(
        id: "id-eng-maths-2",
        title: "Engineering Mathematics II",
        image: "$IMAGES_FOLDER/code-2.png",
        category: categories.firstWhere((category) => category.id == "mathematics"),
        user: dummyUsers.elementAt(Math.Random().nextInt(dummyUsers.length)),
        progress: 0.9,
        tag: "Best Selling",
        rating: 4.3,
        price: "1020",
        oldPrice: "340",
      ),
    ];
  }

  static Content generatedContentForCourse(Course course) {
    const desc =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    return Content(
      id: "art-fundamentals",
      courseId: course.id,
      levels: [
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Fundamentals of Art",
          description: desc,
          children: <Level>[
            Level(
              contentId: "art-fundamentals",
              title: "What is Art?",
              subtitle: "What does it really mean?",
              status: STATUS.COMPLETE,
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Different Forms of Art",
              subtitle: "It is not just painting",
              status: STATUS.IN_PROGRESS,
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Art Principles",
              subtitle: "Why are they important?",
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Color Theory",
              subtitle: "Understanding Color",
              children: [
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - What does it really mean?",
                ),
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - It is not just painting",
                ),
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - Why are they important?",
                ),
              ],
            ),
          ],
        ),
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Approches to Art History",
          description: desc,
          children: <Level>[
            Level(
              contentId: "art-history",
              title: "An Introduction",
              description: desc,
              subtitle: "Where does it matter?",
            ),
          ],
        ),
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Art & Design Fundamentals",
          description: desc,
          contentId: "art-n-design",
        ),
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Fundamentals of Art",
          description: desc,
          children: <Level>[
            Level(
              contentId: "art-fundamentals",
              title: "What is Art?",
              subtitle: "What does it really mean?",
              status: STATUS.COMPLETE,
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Different Forms of Art",
              subtitle: "It is not just painting",
              status: STATUS.IN_PROGRESS,
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Art Principles",
              subtitle: "Why are they important?",
            ),
            Level(
              contentId: "art-fundamentals",
              title: "Color Theory",
              subtitle: "Understanding Color",
              children: [
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - What does it really mean?",
                ),
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - It is not just painting",
                ),
                Level(
                  contentId: "art-fundamentals",
                  title: "Sub Tile Art 1",
                  subtitle: "Subtile - Why are they important?",
                ),
              ],
            ),
          ],
        ),
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Art & Design Fundamentals",
          description: desc,
          contentId: "art-n-design",
        ),
        Level(
          id: "${Math.Random.secure().nextDouble()}",
          title: "${course.title} - Approches to Art History",
          description: desc,
          children: <Level>[
            Level(
              contentId: "art-history",
              title: "An Introduction",
              description: desc,
              subtitle: "Where does it matter?",
            ),
          ],
        ),
      ],
    );
  }
}
