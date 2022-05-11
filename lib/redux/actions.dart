import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/models/UserProfile.dart';

class AddPostAction {
  final NewsPost post;

  AddPostAction(this.post);
}

class UpdateProfileAction {
  final UserProfile profile;

  UpdateProfileAction(this.profile);
}

class JoinGroupAction {
  final String userId;
  final String groupId;

  JoinGroupAction({required this.userId, required this.groupId});
}

class RegisterUserAction {
  final UserProfile profile;

  RegisterUserAction(this.profile);
}

class ChangeUserPasswordAction {
  final String userId;
  final String password;

  ChangeUserPasswordAction({required this.userId, required this.password});
}
