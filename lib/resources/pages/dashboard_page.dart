import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/match_page.dart';
import 'package:flutter_app/resources/pages/ranking_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

// import '../widgets/loader_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/page1.dart';
import '../widgets/product_rating_widget.dart';
// import '../widgets/schedule_list.dart';

class DashboardPage extends NyStatefulWidget {
  static const path = '/dashboard';

  DashboardPage({super.key}) : super(path, child: () => _DashboardPageState());
}

class _DashboardPageState extends NyState<DashboardPage> {
  int _currentIndex = 0;

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

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NHÔM NHỰA TV'),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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
