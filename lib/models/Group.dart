class Group {
  final String groupId;
  String name;
  List<String> admins;
  List<String> members;
  List<String> banned = [];

  Group({required this.groupId, required this.name, required this.admins, required this.members});
}