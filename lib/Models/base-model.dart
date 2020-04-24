import 'package:flutter/material.dart';

abstract class Model {
  final String id;
  String _createdAt;
  String _updatedAt;

  Model({@required this.id}) : assert(id != null);

  // ignore: unnecessary_getters_setters
  String get updatedAt => _updatedAt;

  // ignore: unnecessary_getters_setters
  set updatedAt(String value) => _updatedAt = value;

  // ignore: unnecessary_getters_setters
  String get createdAt => _createdAt;

  // ignore: unnecessary_getters_setters
  set createdAt(String value) => _createdAt = value;

  @override
  String toString() => "{id: $id, created_at: $createdAt, updated_at: $updatedAt}";
}
