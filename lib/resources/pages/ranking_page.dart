import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/resources/widgets/create_member_widget.dart';
import 'package:flutter_app/resources/widgets/member_view_widget.dart';
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

class _RankingPageState extends NyState<RankingPage>
    with SingleTickerProviderStateMixin {
  Member selectedMember = Member();

  late TabController _tabController;
  static List<Tab> myTabs = <Tab>[
    Tab(text: 'Tuần'),
    Tab(text: 'Tháng'),
    Tab(text: 'Năm'),
  ];

  @override
  init() async {
    // super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  // List<Member> listMember = [];

  /// Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {}

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Match")),
      body: SafeArea(
        // child: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
                // indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                labelColor: Color.fromARGB(255, 0, 106, 255),
                labelStyle: GoogleFonts.workSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                unselectedLabelColor: Color(0xffA8A8A8),
                unselectedLabelStyle: GoogleFonts.workSans(
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xffA8A8A8),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                controller: _tabController,
                tabs: myTabs.map((e) => e).toList()),
            SizedBox(height: 5),
            Text(
              'Thứ ..., ngày ... tháng ... năm 2024',
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 106, 255),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                // decoration: BoxDecoration(
                //   color: Color.fromARGB(255, 255, 255, 255),
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(24),
                //     topRight: Radius.circular(24),
                //   ),
                //   boxShadow: [
                //     BoxShadow(
                //       color: const Color(0xffC4C4C4).withOpacity(0.25),
                //       spreadRadius: 0,
                //       blurRadius: 8,
                //       offset: const Offset(0, -4), // changes position of shadow
                //     ),
                //   ],
                // ),
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
                        onTap: () {
                          selectedMember.id = data.id;
                          selectedMember.name = data.name;
                          _onRakingItemsTap(context, data);
                        },
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
                ),
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  _onRakingItemsTap(BuildContext context, Member member) {
    showUpdateMemberModal(context, member);
    // showAboutDialog(
    //   context: context,
    //   applicationName: getEnv('APP_NAME'),
    //   applicationIcon: const Logo(),
    //   applicationVersion: nyloVersion,
    // );
  }
}
