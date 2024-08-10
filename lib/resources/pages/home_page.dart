import 'package:flutter_app/app/controllers/globals.dart';
import 'package:flutter_app/app/models/posts.dart';
import 'package:flutter_app/resources/pages/dashboard_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import '../../app/models/user.dart';
import '/bootstrap/extensions.dart';
import '/resources/widgets/logo_widget.dart';
import '/resources/widgets/safearea_widget.dart';
import '/bootstrap/helpers.dart';
import '/app/controllers/home_controller.dart';
import '/resources/pages/profile_page.dart';

class HomePage extends NyStatefulWidget<HomeController> {
  static const path = '/home';

  HomePage({super.key}) : super(path, child: () => _HomePageState());
}

class _HomePageState extends NyState<HomePage> {
  /// The boot method is called before the [view] is rendered.
  /// You can override this method to perform any async operations.
  /// Try uncommenting the code below.
  // @override
  // boot() async {
  //   dump("boot");
  //   await Future.delayed(Duration(seconds: 2));
  // }

  /// If you would like to use the Skeletonizer loader,
  /// uncomment the code below.
  // bool get useSkeletonizer => true;

  /// The Loading widget is shown while the [boot] method is running.
  /// You can override this method to show a custom loading widget.
  // @override
  // Widget loading(BuildContext context) {
  //   return Scaffold(
  //       body: Center(child: Text("Loading..."))
  //   );
  // }

  /// The [view] method should display your page.
  @override
  Widget view(BuildContext context) {
    // User? user = Auth.user();
    return Scaffold(
      appBar: AppBar(
        title: Text("NHÔM NHỰA TV".tr()),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.controller.showAbout,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeAreaWidget(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: _login,
                child: Text(
                  'Login',
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // MaterialButton(
              //   onPressed: _logout,
              //   child: Text('Logout'),
              // ),
              // if (user != null) Text("User is logged in, ${user.name}"),
            ],
            // children: [
            //   const Logo(),
            //   Text(
            //     getEnv("APP_NAME"),
            //   ).displayMedium(context),
            //   const Text("Micro-framework for Flutter",
            //           textAlign: TextAlign.center)
            //       .titleMedium(context)
            //       .setColor(context, (color) => color.primaryAccent),
            //   const Text(
            //     "Build something amazing 💡",
            //   ).bodyMedium(context).alignCenter(),
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       const Divider(),
            //       Container(
            //         height: 250,
            //         width: double.infinity,
            //         margin: const EdgeInsets.symmetric(
            //             horizontal: 16, vertical: 16),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 16, vertical: 16),
            //         decoration: BoxDecoration(
            //             color: ThemeColor.get(context).surfaceBackground,
            //             borderRadius: BorderRadius.circular(8),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.1),
            //                 spreadRadius: 1,
            //                 blurRadius: 9,
            //                 offset: const Offset(0, 3),
            //               ),
            //             ]),
            //         child: Center(
            //           child: ListView(
            //             padding: EdgeInsets.zero,
            //             shrinkWrap: true,
            //             children:
            //                 ListTile.divideTiles(context: context, tiles: [
            //               if (Nylo.containsRoutes(["/login", "/register"])) ...[
            //                 MaterialButton(
            //                   onPressed: () => routeTo("/login"),
            //                   child: Text(
            //                     "Login".tr(),
            //                   ).bodyLarge(context).setColor(
            //                       context, (color) => color.surfaceContent),
            //                 ),
            //                 MaterialButton(
            //                   onPressed: () => routeTo("/register"),
            //                   child: Text(
            //                     "Register".tr(),
            //                   ).bodyLarge(context).setColor(
            //                       context, (color) => color.surfaceContent),
            //                 ),
            //               ],
            //               MaterialButton(
            //                 onPressed: widget.controller.onTapDocumentation,
            //                 child: Text(
            //                   "documentation".tr().capitalize(),
            //                 ).bodyLarge(context).setColor(
            //                     context, (color) => color.surfaceContent),
            //               ),
            //               MaterialButton(
            //                 onPressed: widget.controller.onTapGithub,
            //                 child: const Text(
            //                   "GitHub",
            //                 ).bodyLarge(context).setColor(
            //                     context, (color) => color.surfaceContent),
            //               ),
            //               MaterialButton(
            //                 onPressed: widget.controller.onTapChangeLog,
            //                 child: Text(
            //                   "changelog".tr().capitalize(),
            //                 ).bodyLarge(context).setColor(
            //                     context, (color) => color.surfaceContent),
            //               ),
            //               MaterialButton(
            //                 onPressed: widget.controller.onTapYouTube,
            //                 child: Text(
            //                   "YouTube Channel".tr().capitalize(),
            //                 ).bodyLarge(context).setColor(
            //                     context, (color) => color.surfaceContent),
            //               ),
            //               MaterialButton(
            //                 onPressed: () => routeTo(ProfilePage.path),
            //                 child: Text(
            //                   "View Profile".tr().capitalize(),
            //                 ).bodyLarge(context).setColor(
            //                     context, (color) => color.surfaceContent),
            //               ),
            //             ]).toList(),
            //           ),
            //         ),
            //       ),
            //       const Text(
            //         "Framework Version: $nyloVersion",
            //       )
            //           .bodyMedium(context)
            //           .setColor(context, (color) => Colors.grey),
            //       if (!context.isDarkMode)
            //         Switch(
            //             value: isThemeDark,
            //             onChanged: (_) {
            //               NyTheme.set(context,
            //                   id: getEnv(isThemeDark != true
            //                       ? 'DARK_THEME_ID'
            //                       : 'LIGHT_THEME_ID'));
            //             }),
            //       if (!context.isDarkMode)
            //         Text("${isThemeDark ? "Dark" : "Light"} Mode"),
            //     ],
            //   ),
            // ],
          ),
        ),
      ),
    );
  }

  bool get isThemeDark =>
      ThemeProvider.controllerOf(context).currentThemeId ==
      getEnv('DARK_THEME_ID');

  TextEditingController _tfEmail = TextEditingController();
  TextEditingController _tfPassword = TextEditingController();

  SupabaseClient get supaclient => Supabase.instance.client;
  Session? get currentSession => supaclient.auth.currentSession;

  _login() async {
    print('On Login');

    if (listMember.isNotEmpty) listMember.clear();
    if (mapMemberId.isNotEmpty) mapMemberId.clear();

    // User user = User();
    // user.name = 'Nhomnhua';
    // await Auth.login(user);

    // // 1 - Example register via an API Service
    // User? user = await api<AuthApiService>((request) =>
    //     request.register(email: _tfEmail.text, password: _tfPassword.text));
    final AuthResponse res = await supaclient.auth.signInWithPassword(
      email: 'ltdev@vuiwork.space',
      password: 'Nhomnhua@123',
      // password: 'Ltdev@12345',
    );
    // final Session? session = res.session;
    final User? user = res.user;

    // // 2 - Returns the users session token
    // print(user?.token);
    // final data = await supaclient.from('nn_members').select('name');
    // print(data);

    // 3 - Save the user to Nylo
    await Auth.set(user);

    // get member list
    final data = await Supabase.instance.client
        .from('nn_member')
        .select('*')
        .order('id', ascending: true);
    for (var d in data) {
      print(d);
      Member member = Member.fromJson(d);
      listMember.add(member);
      mapMemberId[member.id!] = member.name!;
    }
    print(mapMemberId);
    print(mapMemberId[1]);

    // setState(() {});
    routeTo(DashboardPage.path);
  }

  // _logout() async {
  //   await Auth.logout();
  //   setState(() {});
  // }
}
