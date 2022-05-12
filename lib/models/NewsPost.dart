class NewsPost {
  final String authorId;
  final String? groupId;
  final String content;
  final DateTime dateTime;

  NewsPost({required this.authorId, this.groupId, required this.content, required this.dateTime});
}
