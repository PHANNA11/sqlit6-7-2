import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_local_storage/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/property.dart';

abstract class DatabaseStucture {
  Future<Database> initializeDatabase();
  Future<void> insertData(UserModel userModel);
  Future<void> updateData(UserModel userModel);
  Future<void> deleteData(int id);
  Future<List<UserModel>> getUserData();
}

class DatabaseHelper extends DatabaseStucture {
  @override
  Future<void> deleteData(int id) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUserData() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> rest = await db.query(userTableName);
    return rest.map((e) => UserModel.userModelFromJson(e)).toList();
  }

  @override
  Future<Database> initializeDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var databasesPath = await getDatabasesPath();
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'userdb.db'), onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $userTableName($fid INTEGER PRIMIRY KEY,$fname TEXT,$fprofile TEXT)');
    }, version: 1);
  }

  @override
  Future<void> insertData(UserModel userModel) async {
    var db = await initializeDatabase();
    db.insert(userTableName, userModel.userModeltoJson());
    print('object was insert');
  }

  @override
  Future<void> updateData(UserModel userModel) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
