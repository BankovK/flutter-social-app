import 'package:flutter_app/models/NewsPost.dart';
import 'package:flutter_app/redux/actions.dart';

List<NewsPost> appReducers(List<NewsPost> posts, dynamic action) {
  if (action is AddPostAction) {
    return addItem(posts, action);
  }
  return posts;
}

List<NewsPost> addItem(List<NewsPost> posts, AddPostAction action) {
  return List.from(posts)..add(action.post);
}