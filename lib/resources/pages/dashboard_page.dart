import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/match_page.dart';
import 'package:flutter_app/resources/pages/ranking_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

// import '../widgets/loader_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/page1.dart';
import '../widgets/product_rating_widget.dart';
// import '../widgets/schedule_list.dart';
import 'package:flutter_app/app/controllers/globals.dart';

class DashboardPage extends NyStatefulWidget {
  static const path = '/dashboard';

  DashboardPage({super.key}) : super(path, child: () => _DashboardPageState());
}

class _DashboardPageState extends NyState<DashboardPage> {
  final List<Widget> _pages = [
    Container(
      child: RankingPage(),
    ),
    Container(
      child: MatchPage(),
    ),
    Container(
      child: ProductRating(),
    ),
  ];

  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }
// Main tab index
  int NNcurrentIndex = 0;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('NHÔM NHỰA TV'),
      //   automaticallyImplyLeading: false,
      // ),
      body: _pages[NNcurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NNcurrentIndex,
        onTap: (index) {
          setState(() {
            NNcurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'XẾP HẠNG',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'LUYỆN TẬP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'CẤU HÌNH',
          ),
        ],
      ),
    );
  }
}
