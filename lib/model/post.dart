class Post {
  final String postImage;
  Post(
    this.postImage,
  );
  static List<Post> getPostList() {
    return [
      Post("assets/images/1.jpg"),
      Post("assets/images/2.jpg"),
      Post("assets/images/3.jpg"),
      Post("assets/images/4.jpg"),
      Post("assets/images/5.jpg"),
      Post("assets/images/6.jpg"),
      Post("assets/images/7.jpg"),
      Post("assets/images/8.jpg"),
      Post("assets/images/9.jpg"),
      Post("assets/images/10.jpg"),
    ];
  }
}
