import 'package:analysis_web/models/user.dart';

class Users {
  static List<User> usersList = [
    User(
      id: 1,
      name: 'MASTER',
      username: 'root',
      password: 'toor',
      role: 'admin',
    ),
    User(
      id: 2,
      name: 'Gabriel Torelo',
      username: 'noroot',
      password: '123456',
      role: 'user',
    ),
  ];
}
