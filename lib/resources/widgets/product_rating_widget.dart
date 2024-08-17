import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/app/networking/json_place_holder_api_service.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:flutter_app/resources/pages/profile_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import '/bootstrap/extensions.dart';
// import '../pages/profile_page.dart';
// import 'logo_widget.dart';
import 'safearea_widget.dart';
import 'create_member_widget.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: ListTile.divideTiles(context: context, tiles: [
            MaterialButton(
              onPressed: _logout,
              child: Text(
                "Logout".tr().capitalize(),
              )
                  .bodyLarge(context)
                  .setColor(context, (color) => color.surfaceContent),
            ),
            MaterialButton(
              onPressed: () => showCreateUserModal(context),
              child: Text(
                "Thêm thành viên".tr().capitalize(),
              )
                  .bodyLarge(context)
                  .setColor(context, (color) => color.surfaceContent),
            ),
          ]).toList(),
        ),
      ),
    );
  }

  SupabaseClient get supaclient => Supabase.instance.client;

  _logout() async {
    listMember.clear();
    mapMemberId.clear();
    // await Auth.logout();
    await supaclient.auth.signOut();
    routeTo(HomePage.path, navigationType: NavigationType.pushAndForgetAll);
  }
}


/**
 * class ProductRating extends StatelessWidget {
  const ProductRating({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        child: NyListView(child: (BuildContext context, dynamic data) {
      data as Posts;
      return ListTile(
        title: Text(
          data.title ?? "",
          maxLines: 1,
        ),
        subtitle: Text(
          data.body ?? "",
          maxLines: 1,
        ),
      );
    }, data: () async {
      return await api<JsonPlaceHolderApiService>(
          (request) => request.getPosts());
    }));
  }
}

 */