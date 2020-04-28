import 'definitions.dart';

var database = {
  DATABASE_DEFINE__.DATABASE: DATABASE.SQLITE,
  DATABASE_DEFINE__.DATABASE_NAME: "oylex",
  DATABASE_DEFINE__.DATABASE_HOST: "localhost",
  DATABASE_DEFINE__.DATABASE_VERSION: 1,
  DATABASE_DEFINE__.DATABASE_USER: "root",
  DATABASE_DEFINE__.DATABASE_PASSWORD: "",
};

MapEntry<DATABASE_DEFINE__, Object> get(DATABASE_DEFINE__ key) => database.entries.firstWhere((elem) => elem.key == key);
