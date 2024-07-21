import "package:sqflite/sqflite.dart";
import "database_connection.dart";

class Repository
{
  late DatabaseConnection _databaseConnection;
  Repository(){
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await _databaseConnection.setDatabase();
      return _database;
    }

  }
  insetData(table, data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readData(table) async{
    var connection = await database;
    return await connection?.quary(table);
  }
  readDataById(table, itemId) async{
    var connection = await database;
    return await connection?.quary(table, where: 'id=?',whereArgs: [itemId]);
  }
  updateData(table, data) async{
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?',whereArgs: [data['id']]);
  }
  deleteDataById(table, itemId) async{
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id = $itemId");
  }


}