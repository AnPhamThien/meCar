part of 'discover_bloc.dart';

enum DiscoverStatus { initial, success, failure }

class DiscoverState extends Equatable {
  final DiscoverStatus status;
  final List<Post> postList;
  final String userAva;
  final String username;
  final String userRealName;

  const DiscoverState(
      {this.status = DiscoverStatus.initial,
      this.postList = const <Post>[],
      this.userAva = '',
      this.username = '',
      this.userRealName = ''});

  DiscoverState copyWith({
    DiscoverStatus? status,
    List<Post>? postList,
    String? userAva,
    String? username,
    String? userRealName,
  }) {
    return DiscoverState(
      status: status ?? this.status,
      postList: postList ?? this.postList,
      userAva: userAva ?? this.userAva,
      username: username ?? this.username,
      userRealName: userRealName ?? this.userRealName,
    );
  }

  @override
  List<Object?> get props =>
      [status, postList, userAva, userRealName, username];
}
