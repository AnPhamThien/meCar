class User {
  final String username;
  final String password;
  User({
    this.username = '',
    this.password = '',
  });

  final List<User> userList = [User(username: 'admin', password: 'admin')];

  List<User> getUserList() {
    return userList;
  }
}
