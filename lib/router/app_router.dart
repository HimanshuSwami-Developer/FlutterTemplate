import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubdev_widgets/router/my_routes.dart';
import 'package:pubdev_widgets/screens/cards/ui/cards_screen.dart';
import 'package:pubdev_widgets/screens/home/ui/home_screen.dart';
import 'package:pubdev_widgets/screens/scan/ui/scan_screen.dart';
import 'package:pubdev_widgets/screens/settings/ui/settings_screen.dart';
import 'package:pubdev_widgets/splash_screen.dart';

import '../../screens/auth/ui/auth_screen.dart';
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

    /// LOGIN
    GoRoute(
      path: MyRoutes.loginScreen,

      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: AuthScreen(),
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
        GoRoute(
          path: MyRoutes.homeScreen,

          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: HomeScreen(),
            );
          },
        ),

        /// SCAN
        GoRoute(
          path: MyRoutes.scanScreen,

          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: ScanScreen(),
            );
          },
        ),

        /// CARDS
        GoRoute(
          path: MyRoutes.cardsScreen,

          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: CardsScreen(),
            );
          },
        ),

        /// SETTINGS
        GoRoute(
          path: MyRoutes.settingsScreen,

          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: SettingsScreen(),
            );
          },
        ),
      ],
    ),
  ],
);