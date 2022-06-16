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

class AddFriendAction {
  final String friendUserId;
  final String toUserId;

  AddFriendAction({required this.friendUserId, required this.toUserId});
}

class DenyFriendshipAction {
  final String friendUserId;
  final String toUserId;

  DenyFriendshipAction({required this.friendUserId, required this.toUserId});
}

class RequestFriendshipAction {
  final String fromUserId;
  final String toUserId;

  RequestFriendshipAction({required this.fromUserId, required this.toUserId});
}

class MakeAdminAction {
  final String groupId;
  final String userId;

  MakeAdminAction({required this.groupId, required this.userId});
}

class BanFromGroupAction {
  final String groupId;
  final String userId;

  BanFromGroupAction({required this.groupId, required this.userId});
}
