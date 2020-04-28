abstract class Database {
  Future<void> initializeDatabase();
  Future<void> create();
  Future<void> get();
  Future<void> update();
  Future<void> delete();
}
