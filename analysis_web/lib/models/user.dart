class User {
  int id;
  String name;
  String username;
  String password;
  String role;

  User({
    int? id,
    String? name,
    String? username,
    String? password,
    String? role,
  })  : id = id ?? 0,
        name = name ?? '',
        username = username ?? '',
        password = password ?? '',
        role = role ?? '';

  Map<String, Object> toJsonWithoutData({
    required List<UserFields> fieldsToIgnore,
  }) {
    final Map<String, Object> data = {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'role': role,
    };

    for (UserFields field in fieldsToIgnore) {
      data.remove(field());
    }

    return data;
  }

  Map<String, Object> toJson() {
    return {
      ...toJsonWithoutData(fieldsToIgnore: []),
    };
  }
}

enum UserFields {
  id('id'),
  name('name'),
  username('username'),
  password('password'),
  role('role');

  final String value;
  const UserFields(this.value);

  String call() => value.toString();
}
