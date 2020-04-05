import 'package:oylex/Models/RouteArgs/route-args.dart';

class AuthArgs extends RouteArgs {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  AuthArgs(
      {this.firstName, this.lastName, this.email, this.password, this.phone});

  @override
  void isNonNull() {
    // TODO: implement isNonNull
  }
}
