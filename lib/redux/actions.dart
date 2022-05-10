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
