import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/Group.dart';
import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/models/UserProfile.dart';
import 'package:flutter_app/redux/actions.dart';

@immutable
class AppState{
  final List<NewsPost> posts;
  final List<UserProfile> users;
  final List<Group> groups;
  const AppState({required this.posts, required this.users, required this.groups});
}

AppState appReducers(AppState previousState, dynamic action) {
  if (action is AddPostAction) {
    return addItem(previousState, action);
  }
  if (action is UpdateProfileAction) {
    return updateProfile(previousState, action);
  }
  if (action is JoinGroupAction) {
    return joinGroup(previousState, action);
  }
  if (action is RegisterUserAction) {
    return registerUser(previousState, action);
  }
  if (action is ChangeUserPasswordAction) {
    return changeUserPassword(previousState, action);
  }
  if (action is AddFriendAction) {
    return addFriend(previousState, action);
  }
  if (action is RequestFriendshipAction) {
    return requestFriendship(previousState, action);
  }
  if (action is DenyFriendshipAction) {
    return denyFriendship(previousState, action);
  }
  return previousState;
}

AppState addItem(AppState previousState, AddPostAction action) {
  return AppState(
      posts: List.from(previousState.posts)..add(action.post),
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState updateProfile(AppState previousState, UpdateProfileAction action) {
  final updatedIndex = previousState.users.indexWhere((user) => user.userId == action.profile.userId);
  previousState.users[updatedIndex] = action.profile;
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState joinGroup(AppState previousState, JoinGroupAction action) {
  final updatedIndex = previousState.groups.indexWhere((group) => group.groupId == action.groupId);
  previousState.groups[updatedIndex].members.add(action.userId);
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState registerUser(AppState previousState, RegisterUserAction action) {
  previousState.users.add(action.profile);
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState changeUserPassword(AppState previousState, ChangeUserPasswordAction action) {
  final updatedIndex = previousState.users.indexWhere((user) => user.userId == action.userId);
  previousState.users[updatedIndex].password = action.password;
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState addFriend(AppState previousState, AddFriendAction action) {
  final updatedIndex = previousState.users.indexWhere((user) => user.userId == action.toUserId);
  previousState.users[updatedIndex].friends.add(action.friendUserId);
  final updatedIndex2 = previousState.users.indexWhere((user) => user.userId == action.friendUserId);
  previousState.users[updatedIndex2].friends.add(action.toUserId);
  previousState.users[updatedIndex].friendshipRequests.remove(action.friendUserId);
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState requestFriendship(AppState previousState, RequestFriendshipAction action) {
  final updatedIndex = previousState.users.indexWhere((user) => user.userId == action.toUserId);
  previousState.users[updatedIndex].friendshipRequests.add(action.fromUserId);
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}

AppState denyFriendship(AppState previousState, DenyFriendshipAction action) {
  final updatedIndex = previousState.users.indexWhere((user) => user.userId == action.toUserId);
  previousState.users[updatedIndex].friendshipRequests.remove(action.friendUserId);
  return AppState(
      posts: previousState.posts,
      users: previousState.users,
      groups: previousState.groups
  );
}