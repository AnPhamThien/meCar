import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mecarassignment/controller/discover/discover_bloc.dart';
import 'package:mecarassignment/model/post.dart';
import 'package:mecarassignment/presentation/global_widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Post> postList = Post.getPostList();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverBloc()..add(InitialFetch()),
      child: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          switch (state.status) {
            case DiscoverStatus.success:
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 50,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: HeadLine(
                              label: AppLocalizations.of(context)!.discover),
                        ),
                        getTodayPost(context, state),
                        SliverToBoxAdapter(
                          child: getContentHeadline(
                              AppLocalizations.of(context)!.all.toUpperCase()),
                        ),
                        getPostList(state),
                        getSeeMoreBtn(context),
                      ],
                    ),
                  ),
                ),
              );
            case DiscoverStatus.failure:
              return Center(
                child: Text(AppLocalizations.of(context)!.stwr),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  SliverToBoxAdapter getTodayPost(BuildContext context, DiscoverState state) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getContentHeadline(
              AppLocalizations.of(context)!.todaypost.toUpperCase()),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/discover.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          UserHeadLine(
            username: state.username,
            userRealName: state.userRealName,
            imgPath: state.userAva,
          ),
          const SizedBox(
            height: 50,
          ),
          getContentHeadline(AppLocalizations.of(context)!.all.toUpperCase()),
        ],
      ),
    );
  }

  SliverMasonryGrid getPostList(DiscoverState state) {
    return SliverMasonryGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final Post item = state.postList[index];
        return Image.asset(
          item.postImage,
        );
      }, childCount: state.postList.length),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
    );
  }

  SliverToBoxAdapter getSeeMoreBtn(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: TextButton(
          onPressed: () {
            //TODO fetchmore
          },
          style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * .100, 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 3)),
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              primary: Colors.black,
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          child: Text(AppLocalizations.of(context)!.more.toUpperCase()),
        ),
      ),
    );
  }

  Text getContentHeadline(String content) {
    return Text(
      content,
      style: const TextStyle(
          fontSize: 18, fontFamily: "Roboto", fontWeight: FontWeight.w900),
    );
  }
}
