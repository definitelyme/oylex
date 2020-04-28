import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oylex/services/database/database.dart';

class FirestoreDatabase implements Database {
  Firestore _database;

  @override
  Future<void> initializeDatabase() async {
    _database = Firestore.instance;
  }

  @override
  Future<void> create({String name}) {
    // TODO: implement create
    return null;
  }

  @override
  Future<void> get() {
    // TODO: implement get
    return null;
  }

  @override
  Future<void> update() {
    // TODO: implement update
    return null;
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    return null;
  }
}
