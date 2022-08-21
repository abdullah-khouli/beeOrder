import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path =
            await getDatabasesPath() + 'mealShop.db'; //المسار الخاص بالداتا بيز

        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (Database db, int version) async {
            await db.execute(
              'CREATE TABLE auth ('
              'userId STRING ,'
              'token STRING ,'
              'expiresIn STRING)',
            );
          },
        );
      } catch (e) {
        print('errrrrooooooooorr');
        print(e);
      }
    }
  }

  static Future<List<Map<String, Object?>>> getAuthData() async {
    return await _db!.query('auth');
  }

  static setAuthData(Map authData) async {
    // print(authData['expireDate']);
    await _db!.insert('auth', {
      'userId': authData['userId'],
      'token': authData['token'],
      'expiresIn': authData['expiresIn']
    });
  }

  static resetAuthData() async {
    await _db!.delete('auth');
  }
}
