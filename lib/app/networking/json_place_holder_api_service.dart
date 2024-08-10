import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/config/decoders.dart';
import '/app/models/posts.dart';
import '/app/models/post_by_id.dart';

class JsonPlaceHolderApiService extends NyApiService {
  JsonPlaceHolderApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders);

  @override
  String get baseUrl => "";

  //GET
  /// https://jsonplaceholder.typicode.com/posts
  Future<List<Posts>?> getPosts() async => await network<List<Posts>>(
      request: (request) => request.get("/posts"),
      baseUrl: "https://jsonplaceholder.typicode.com");

  //GET
  /// https://jsonplaceholder.typicode.com/posts/1
  Future<PostById?> getPostById() async => await network<PostById>(
      request: (request) => request.get("/posts/1"),
      baseUrl: "https://jsonplaceholder.typicode.com");
}
