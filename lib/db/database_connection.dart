import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  Future setDatabase() async
  {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db');
    var database = await openDatabase(path,version: 1,onCreate: _createDatabase);
    return database;
  }

  Future _createDatabase(Database database, int version) async{
    String sql = "CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, subtitle TEXT, date REAL, importance TEXT);";
    await database.execute(sql);
    //print(database.execute(sql));

  }
}