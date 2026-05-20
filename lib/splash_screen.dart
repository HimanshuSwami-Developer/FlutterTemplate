import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_colors.dart';
import '../../router/my_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    /// ⏱ 2 sec delay → GoRouter navigation
    Timer(const Duration(seconds: 2), () {
      context.go(MyRoutes.loginScreen);
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background,
    body: Container(
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF070B14),
            Color(0xFF0F172A),
            Color(0xFF070B14),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Stack(
        children: [

          /// TOP GLOW
          Positioned(
            top: -120,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.18),
              ),
            ),
          ),

          /// BOTTOM PURPLE GLOW
          Positioned(
            bottom: -100,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.15),
              ),
            ),
          ),

          /// MAIN CONTENT
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// LOGO CONTAINER
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.glass,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 40,
                        spreadRadius: 2,
                      )
                    ],
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                      ),
                    ),

                    child: const Icon(
                      Icons.nfc,
                      size: 46,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                /// APP NAME
                const Text(
                  "TapVault",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 10),

                /// TAGLINE
                Text(
                  "Tap • Pay • Secure",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.65),
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 45),

                /// LOADER
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.primary,
                    ),
                    backgroundColor: Colors.white12,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "INITIALIZING SECURE NFC CHANNEL",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 11,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          /// FOOTER
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    _footerIcon(Icons.fingerprint),

                    const SizedBox(width: 14),

                    _footerIcon(Icons.security),

                    const SizedBox(width: 14),

                    _footerIcon(Icons.lock),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  "Powered by Secure NFC + QR Technology",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
 
 Widget _footerIcon(IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.06),
      ),
    ),
    child: Icon(
      icon,
      size: 18,
      color: AppColors.primary,
    ),
  );
}

 }