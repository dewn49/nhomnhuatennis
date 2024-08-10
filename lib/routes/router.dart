import '/resources/pages/match_view_page.dart';
import '/resources/pages/match_page.dart';
import '/resources/pages/ranking_page.dart';
import '/resources/pages/login_page.dart';
import '/resources/pages/dashboard_page.dart';
import '/resources/pages/profile_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'guards/auth_route_guard.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.20.0/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      router.route(HomePage.path, (context) => HomePage(), initialRoute: true);
      // Add your routes here

      // router.route(NewPage.path, (context) => NewPage(), transition: PageTransitionType.fade);

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      //   router.route(AccountPage.path, (context) => AccountPage());
      // });
      router.route(ProfilePage.path, (context) => ProfilePage());
      router.route(DashboardPage.path, (context) => DashboardPage(),
          routeGuards: [
            AuthRouteGuard() // Add your guard
          ]);
      router.route(LoginPage.path, (context) => LoginPage(), authPage: true);
      router.route(RankingPage.path, (context) => RankingPage());
      router.route(MatchPage.path, (context) => MatchPage());
      // router.route(MatchViewPage.path, (context) => MatchViewPage());
    });
