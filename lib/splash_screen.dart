import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubdev_widgets/core/app_colors.dart';
import 'package:pubdev_widgets/core/app_text.dart';
import 'package:pubdev_widgets/router/my_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// =========================================
  /// LOADING TEXTS
  /// =========================================

  final List<String> loadingTexts = [
    "Initializing secure workspace...",
    "Loading academic modules...",
    "Connecting institution database...",
    "Preparing attendance system...",
    "Syncing dashboard resources...",
    "System ready. Entering workspace...",
  ];

  int currentIndex = 0;

  Timer? timer;

  /// =========================================
  /// ANIMATIONS
  /// =========================================

  late AnimationController fadeController;

  late Animation<double> fadeAnimation;

  late AnimationController scaleController;

  late Animation<double> scaleAnimation;

  late AnimationController progressController;

  @override
  void initState() {
    super.initState();

    /// FADE

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    );

    /// SCALE

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    scaleAnimation = Tween<double>(
      begin: .85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: scaleController,
        curve: Curves.easeOutBack,
      ),
    );

    /// PROGRESS

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    fadeController.forward();

    scaleController.forward();

    progressController.forward();

    /// TEXT CHANGER

    timer = Timer.periodic(
      const Duration(milliseconds: 900),
      (timer) {
        if (currentIndex < loadingTexts.length - 1) {
          setState(() {
            currentIndex++;
          });
        } else {
          timer.cancel();

          /// NAVIGATE HERE
          ///
         context.go(MyRoutes.institutionSetupScreen);
        }
      },
    );
  }

  @override
  void dispose() {
    fadeController.dispose();

    scaleController.dispose();

    progressController.dispose();

    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,

      body: Stack(
        children: [
          /// =========================================
          /// DOT BACKGROUND
          /// =========================================

          Positioned.fill(
            child: CustomPaint(
              painter: DotPainter(),
            ),
          ),

          /// =========================================
          /// MAIN CONTENT
          /// =========================================

          Center(
            child: FadeTransition(
              opacity: fadeAnimation,

              child: ScaleTransition(
                scale: scaleAnimation,

                child: Container(
                  width: 330,

                  padding: const EdgeInsets.all(28),

                  decoration: BoxDecoration(
                    color: AppColors.card,

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(
                      color: AppColors.border,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),

                        blurRadius: 30,

                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      /// ===================================
                      /// LOGO
                      /// ===================================

                      Container(
                        height: 64,
                        width: 64,

                        decoration: BoxDecoration(
                          color: AppColors.primary,

                          borderRadius:
                              BorderRadius.circular(18),

                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(.12),

                              blurRadius: 20,

                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.school_outlined,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// ===================================
                      /// TITLE
                      /// ===================================

                      Text(
                        "Eclipse Engine",
                        textAlign: TextAlign.center,

                        style:
                            AppTextStyles.headline.copyWith(
                          fontSize: 35,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// ===================================
                      /// SUBTITLE
                      /// ===================================

                      Text(
                        "PRECISION\nEXCELLENCE",
                        textAlign: TextAlign.center,

                        style: AppTextStyles.label.copyWith(
                          color: AppColors.neutral,

                          letterSpacing: 2,

                          height: 1.1,

                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 42),

                      /// ===================================
                      /// POWERED BY
                      /// ===================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          Text(
                            "POWERED BY",
                            style:
                                AppTextStyles.caption.copyWith(
                              letterSpacing: 1.5,

                              fontWeight: FontWeight.w700,

                              color: AppColors.inactive,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(
                            Icons.blur_on,
                            size: 15,
                            color: AppColors.black,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "De Silent Order",
                            style:
                                AppTextStyles.label.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 26),

                      /// ===================================
                      /// STATUS TEXT
                      /// ===================================

                      AnimatedSwitcher(
                        duration:
                            const Duration(milliseconds: 400),

                        transitionBuilder:
                            (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin:
                                    const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(animation),

                              child: child,
                            ),
                          );
                        },

                        child: Text(
                          loadingTexts[currentIndex],

                          key: ValueKey(currentIndex),

                          textAlign: TextAlign.center,

                          style:
                              AppTextStyles.small.copyWith(
                            fontWeight: FontWeight.w600,

                            color:
                                AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// ===================================
                      /// PROGRESS BAR
                      /// ===================================

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(100),

                        child: SizedBox(
                          height: 3,

                          child: AnimatedBuilder(
                            animation: progressController,

                            builder: (context, child) {
                              return LinearProgressIndicator(
                                value:
                                    progressController.value,

                                backgroundColor:
                                    Colors.black12,

                                valueColor:
                                    const AlwaysStoppedAnimation(
                                  AppColors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =============================================
/// DOT BACKGROUND
/// =============================================

class DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(.035);

    const spacing = 18.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          1,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}