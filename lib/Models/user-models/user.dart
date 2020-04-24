import 'package:oylex/Foundation/Utils/helper.dart';
import 'package:oylex/Models/base-model.dart';

class User extends Model {
  final String firstName;
  final String lastName;
  List<String> otherNames;
  final String email;
  final bool useInitial;

  User({
    String id,
    this.firstName,
    this.lastName,
    this.email,
    this.otherNames = const [],
    this.useInitial = false,
  }) : super(id: id);

  String get fullName {
    if (otherNames.length > 0) return "$firstName $middleName $lastName";
    return "$firstName $lastName";
  }

  String get middleName => useInitial ? initials : "${otherNames.length > 0 ? otherNames.elementAt(0) : null}";

  String get initials {
    if (otherNames.length > 0) return this.otherNames.fold("", (oldValue, newValue) => "$oldValue${newValue.substring(0, 1)}.");
    return null;
  }

  @override
  String toString() => "User => {id: $id, first_name: $firstName, last_name: $lastName, email: $email, created_at: $createdAt, updated_at: $updatedAt}";

  static List<User> dummyUsers() {
    return [
      User(
        id: randomString(8),
        firstName: "John",
        lastName: "Michael",
        otherNames: ["Don", "Ingtar"],
        email: "johnmich12@yahoo.com",
        useInitial: true,
      ),
      User(
        id: randomString(8),
        firstName: "Joseph",
        lastName: "Rubinde",
        otherNames: ['Mary'],
        email: "rivrebik11@gmail.com",
      ),
      User(
        id: randomString(8),
        firstName: "Hilda",
        lastName: "Rhyne",
        otherNames: ["Willams"],
        email: "uchechi44@yahoo.com",
        useInitial: true,
      ),
      User(
        id: randomString(8),
        firstName: "Brendan",
        lastName: "Ejike",
        otherNames: ['Chukwunonso', 'Gabriel'],
        email: "ejike.br@gmail.com",
        useInitial: true,
      ),
      User(
        id: randomString(8),
        firstName: "Esther",
        lastName: "Amys",
        email: "esther.amys@outlook.com",
      ),
      User(
        id: randomString(8),
        firstName: "Rogers",
        lastName: "Samson",
        email: "aenonjosh@hotmail.com",
      ),
      User(
        id: randomString(8),
        firstName: "Frank",
        lastName: "Danger",
        otherNames: ['Ron'],
        email: "dangerdash4@yahoo.com",
        useInitial: true,
      ),
      User(
        id: randomString(8),
        firstName: "Brian",
        lastName: "Lhyte",
        otherNames: ['Augutus'],
        email: "brianrho94@gmail.com",
        useInitial: true,
      ),
      User(
        id: randomString(8),
        firstName: "Anne",
        lastName: "Ejike",
        email: "annebrian94@gmail.com",
      ),
    ];
  }
}
