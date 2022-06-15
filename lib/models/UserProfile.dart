class UserProfile {
  final String userId;
  String name;
  String password;
  DateTime? dateOfBirth;
  String? location;
  String? phoneNumber;
  List<String> friends = [];
  List<String> friendshipRequests = [];

  UserProfile({
    required this.userId,
    required this.name,
    required this.password,
    this.dateOfBirth,
    this.location,
    this.phoneNumber,
  });

}
