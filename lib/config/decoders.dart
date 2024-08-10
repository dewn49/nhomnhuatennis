import '/app/controllers/match_view_controller.dart';
import '/app/controllers/match_controller.dart';
import '/app/models/post_by_id.dart';
import '/app/models/posts.dart';
import '/app/networking/json_place_holder_api_service.dart';
import '/app/controllers/home_controller.dart';
import '/app/models/user.dart';
import '/app/networking/api_service.dart';

/* Model Decoders
|--------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/5.20.0/decoders#model-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> modelDecoders = {
  List<User>: (data) => List.from(data).map((json) => User.fromJson(json)).toList(),
  //
  User: (data) => User.fromJson(data),

  // User: (data) => User.fromJson(data),

  List<Posts>: (data) => List.from(data).map((json) => Posts.fromJson(json)).toList(),

  Posts: (data) => Posts.fromJson(data),

  List<PostById>: (data) => List.from(data).map((json) => PostById.fromJson(json)).toList(),

  PostById: (data) => PostById.fromJson(data),
};

/* API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/5.20.0/decoders#api-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> apiDecoders = {
  ApiService: () => ApiService(),

  // ...

  JsonPlaceHolderApiService: JsonPlaceHolderApiService(),
};


/* Controller Decoders
| -------------------------------------------------------------------------
| Controller are used in pages.
|
| Learn more https://nylo.dev/docs/5.20.0/controllers
|-------------------------------------------------------------------------- */
final Map<Type, dynamic> controllers = {
  HomeController: () => HomeController(),

  // ...


  MatchController: () => MatchController(),

  MatchViewController: () => MatchViewController(),
};

