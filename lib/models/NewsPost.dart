class NewsPost {
  final int postId;
  final String authorId;
  final String? groupId;
  final String content;
  final DateTime dateTime;
  List<String> likedBy = [];

  NewsPost({required this.postId, required this.authorId, this.groupId, required this.content, required this.dateTime});
}
