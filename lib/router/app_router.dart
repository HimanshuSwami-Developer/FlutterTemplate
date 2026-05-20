import 'package:go_router/go_router.dart';
import 'package:pubdev_widgets/router/my_routes.dart';
import 'package:pubdev_widgets/splash_screen.dart';

import '../../screens/mainLayout/main_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: MyRoutes.splashScreen,

  routes: [

    /// SPLASH
    GoRoute(
      path: MyRoutes.splashScreen,

      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: SplashScreen(),
        );
      },
    ),

   

    /// MAIN APP
    ShellRoute(

      builder: (context, state, child) {
        return MainLayout(
          child: child,
        );
      },

      routes: [

        /// HOME
      ],
    ),
  ],
);