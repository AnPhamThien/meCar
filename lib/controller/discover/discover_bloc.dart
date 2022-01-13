import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mecarassignment/model/post.dart';
import 'package:meta/meta.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(const DiscoverState()) {
    on<InitialFetch>(_onInitFetched);
  }

  void _onInitFetched(
    InitialFetch event,
    Emitter<DiscoverState> emit,
  ) async {
    try {
      List<Post>? postList = Post.getPostList();
      String username = '@Thieen_aan';
      String userRealName = 'Thien An';
      String imagePath = 'assets/images/avatar.jpg';
      if (postList.isNotEmpty) {
        emit(state.copyWith(
            status: DiscoverStatus.success,
            postList: postList,
            userAva: imagePath,
            userRealName: userRealName,
            username: username));
      }
    } catch (e) {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }
}
