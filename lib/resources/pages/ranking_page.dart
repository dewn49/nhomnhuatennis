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
import '/app/controllers/ranking_controller.dart';

class RankingPage extends NyStatefulWidget<RankingController> {
  static const path = '/ranking';

  RankingPage({super.key}) : super(path, child: () => _RankingPageState());
}

class _RankingPageState extends NyState<RankingPage>
    with SingleTickerProviderStateMixin {
  Member selectedMember = Member();

  // late TabController _tabController;
  // static List<Tab> myTabs = <Tab>[
  //   Tab(text: 'Tuần'),
  //   Tab(text: 'Tháng'),
  //   Tab(text: 'Năm'),
  // ];

  @override
  init() async {
    // super.initState();
    // _tabController = TabController(vsync: this, length: myTabs.length);
  }

  // List<Member> listMember = [];

  // List of items in our dropdown menu
  static List<String> nnMonths = <String>[
    'Chọn thời gian',
    'Tháng 1/2024',
    'Tháng 2/2024',
    'Tháng 3/2024',
    'Tháng 4/2024',
    'Tháng 5/2024',
    'Tháng 6/2024',
    'Tháng 7/2024',
    'Tháng 8/2024',
    'Tháng 9/2024',
    'Tháng 10/2024',
    'Tháng 11/2024',
    'Tháng 12/2024',
  ];

  String nnTimeForRanking = nnTimeForRankingStore;

  /// Use boot if you need to load data before the [view] is rendered.
  @override
  boot() async {}

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bảng xếp hạng Nhôm Nhựa',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 255, 255, 0),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 32,
            ),
            tooltip: 'Cập nhật',
            onPressed: _onUpdateRanking,
            color: Color.fromARGB(255, 254, 254, 0),
          ),
        ],
      ),
      body: SafeArea(
        // child: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TabBar(
            //     // indicator: CircleTabIndicator(color: Colors.black, radius: 3),
            //     labelColor: Color.fromARGB(255, 0, 106, 255),
            //     labelStyle: GoogleFonts.workSans(
            //       textStyle: TextStyle(
            //         fontSize: 16,
            //         color: Color.fromARGB(255, 255, 0, 0),
            //         fontStyle: FontStyle.normal,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //     unselectedLabelColor: Color(0xffA8A8A8),
            //     unselectedLabelStyle: GoogleFonts.workSans(
            //       textStyle: TextStyle(
            //         fontSize: 12,
            //         color: Color(0xffA8A8A8),
            //         fontStyle: FontStyle.normal,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     controller: _tabController,
            //     tabs: myTabs.map((e) => e).toList()),
            // SizedBox(height: 5),
            // Text(
            //   'Thứ ..., ngày ... tháng ... năm 2024',
            //   style: GoogleFonts.nunitoSans(
            //     textStyle: TextStyle(
            //       fontSize: 16,
            //       color: Color.fromARGB(255, 0, 106, 255),
            //       fontStyle: FontStyle.normal,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            DropdownButton(
              // Initial Value
              value: nnTimeForRanking,
              // fixed: black background
              focusColor: Theme.of(context).scaffoldBackgroundColor,
              // Down Arrow Icon
              // icon: const Icon(Icons.keyboard_arrow_down),
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
              ),

              // Array list of items
              items: nnMonths.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  nnTimeForRanking = newValue!;
                  nnTimeForRankingStore = newValue!;
                });
              },
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
                            child: Text(
                                'Thăg/Hòa/Thua: ${data.stats[NN_STAT_WIN]}/${data.stats[NN_STAT_TIE]}/${data.stats[NN_STAT_LOS]}'),
                            width: 200,
                          ),
                          SizedBox(
                            child: Text('Điểm: ${data.stats[NN_STAT_POINT]}'),
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

  _onUpdateRanking() {
    int mo = nnMonths.indexOf(nnTimeForRanking);
    print('Chọn thống kê tháng: ' + mo.toString());
    widget.controller.updateRankingByMonth(2024, mo);

    // setState(() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    // });
  }
}
