class User {
  final String username;
  final String password;
  User(
    this.username,
    this.password,
  );

  static final List<User> userList = [User('admin', 'admin')];

  static List<User> getUserList() {
    return userList;
  }
}
