
import 'package:go_router/go_router.dart';
import '../../screens/mainLayout/main_layout.dart';
import '../splash_screen.dart';
import '../router/my_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: MyRoutes.splashScreen,
  routes: [
    GoRoute(
      path: MyRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
   

     /// 🔥 MAIN APP WITH HEADER + BOTTOM NAV
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [

          ],
    ),
  ],
);
