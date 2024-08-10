import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/models/posts.dart';
import '../../app/networking/json_place_holder_api_service.dart';
import '../widgets/logo_widget.dart';
import '../widgets/safearea_widget.dart';

class RankingPage extends NyStatefulWidget {
  static const path = '/ranking';

  RankingPage({super.key}) : super(path, child: () => _RankingPageState());
}

class _RankingPageState extends NyState<RankingPage> {
  @override
  init() async {}

  // List<Member> listMember = [];

  /// Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {}

  @override
  Widget view(BuildContext context) {
    return SafeAreaWidget(
        child: NyListView.separated(
      child: (BuildContext context, dynamic data) {
        data as Member;
        return ListTile(
            leading: CircleAvatar(
                radius: (30),
                backgroundColor: Color.fromARGB(255, 185, 199, 252),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "user2.png",
                    height: 100,
                    width: 100,
                  ).localAsset(),
                )),
            onTap: () => _onRakingItemsTap(context),
            title: Text(
              data.name ?? "",
              maxLines: 1,
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 0, 111),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            subtitle: SizedBox(
                child: Row(children: [
              SizedBox(
                child: Text('Win/Tie/Los: 35/8/12'),
                width: 200,
              ),
              SizedBox(
                child: Text('Điểm: 101'),
                width: 100,
              ),
            ])));
      },
      data: () async {
        // SupabaseClient get client => Supabase.instance.client;
        return listMember;
        //await api<JsonPlaceHolderApiService>((request) => request.getPosts());
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    ));
  }

  _onRakingItemsTap(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: getEnv('APP_NAME'),
      applicationIcon: const Logo(),
      applicationVersion: nyloVersion,
    );
  }
}
