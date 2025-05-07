import 'package:tapping_quality/helpers/database_helper.dart';
import 'package:tapping_quality/models/user_model.dart';

class UserService {
  final DatabaseHelper db = DatabaseHelper();

  Future<List<UserModel>> getAllUsers() async {
    final dbClient = await db.database;
    final result = await dbClient.query('users');
    return result.map((user) => UserModel.fromMap(user)).toList();
  }

  Future<List<UserModel?>> getUserByDivision(String division) async {
    final dbClient = await db.database;
    final result = await dbClient.query(
      'users',
      where: 'departemen = ?',
      whereArgs: [division],
    );
    return result.map((user) => UserModel.fromMap(user)).toList();
  }
}
