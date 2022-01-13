import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mecarassignment/controller/discover/discover_bloc.dart';
import 'package:mecarassignment/model/post.dart';
import 'package:mecarassignment/presentation/global_widgets/widgets.dart';

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
                        const SliverToBoxAdapter(
                          child: HeadLine(label: 'Discover'),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getContentHeadline("WHAT'S NEW TODAY"),
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/discover.jpg"),
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
                              )
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: getContentHeadline("BROWSE ALL"),
                        ),
                        SliverMasonryGrid(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            final Post item = state.postList[index];
                            return Image.asset(
                              item.postImage,
                            );
                          }, childCount: state.postList.length),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: TextButton(
                              onPressed: () {
                                //TODO fetchmore
                              },
                              style: TextButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * .100,
                                      60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(width: 3)),
                                  backgroundColor: Colors.white,
                                  alignment: Alignment.center,
                                  primary: Colors.black,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16)),
                              child: const Text("SEE MORE"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case DiscoverStatus.failure:
              return const Center(
                child: Text("Load failed"),
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

  Text getContentHeadline(String content) {
    return Text(
      content,
      style: const TextStyle(
          fontSize: 18, fontFamily: "Roboto", fontWeight: FontWeight.w900),
    );
  }
}
