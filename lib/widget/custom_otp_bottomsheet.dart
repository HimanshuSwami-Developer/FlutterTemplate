import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pubdev_widgets/widget/custom_button.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';

class CustomOtpBottomSheet extends StatefulWidget {
  final String title;
  final String subtitle;

  final String buttonText;
  final TextEditingController? otpController;
  final int otpLength;

  final VoidCallback? onVerify;
  final VoidCallback? onResend;

  const CustomOtpBottomSheet({
    super.key,
    this.otpController,
    required this.title,
    required this.subtitle,

    this.buttonText = "Verify",

    this.otpLength = 6,

    this.onVerify,
    this.onResend,
  });

  @override
  State<CustomOtpBottomSheet> createState() =>
      _CustomOtpBottomSheetState();
}

class _CustomOtpBottomSheetState
    extends State<CustomOtpBottomSheet> {

  int seconds = 60;

  Timer? timer;

  bool canResend = false;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {

    seconds = 60;

    canResend = false;

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),

      (timer) {
        if (seconds == 0) {

          setState(() {
            canResend = true;
          });

          timer.cancel();

        } else {

          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,

      builder: (_, controller) {

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F3F8),

            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),

          child: SingleChildScrollView(
            controller: controller,

            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// =========================
                /// HANDLE
                /// =========================
                Center(
                  child: Container(
                    width: 70,
                    height: 5,

                    decoration: BoxDecoration(
                      color: Colors.black12,

                      borderRadius:
                          BorderRadius.circular(999),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                /// =========================
                /// TITLE
                /// =========================
                Text(
                  widget.title,

                  style:
                      AppTextStyles.headline.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  widget.subtitle,

                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 28),

                /// =========================
                /// OTP CARD
                /// =========================
                _glassCard(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// TOP
                      Row(
                        children: [

                          /// STEP
                          Container(
                            width: 24,
                            height: 24,

                            alignment: Alignment.center,

                            decoration:
                                const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),

                            child: const Text(
                              "1",

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          /// TITLE
                          Text(
                            "VERIFICATION",

                            style:
                                AppTextStyles.label
                                    .copyWith(
                              fontSize: 11,
                              letterSpacing: 1,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),

                          const Spacer(),

                          /// STATUS
                          Container(
                            width: 6,
                            height: 6,

                            decoration:
                                const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            canResend
                                ? "Ready"
                                : "Awaiting Code",

                            style:
                                AppTextStyles.small,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Text(
                        "Enter Verification Code",

                        style:
                            AppTextStyles.caption,
                      ),

                      const SizedBox(height: 14),

                      /// =========================
                      /// OTP
                      /// =========================
                      Pinput(
                        length: widget.otpLength,
                        controller: widget.otpController,
                        keyboardType:
                            TextInputType.number,

                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        defaultPinTheme: PinTheme(
                          width: 52,
                          height: 58,

                          textStyle:
                              AppTextStyles.title
                                  .copyWith(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w700,

                            color:
                                AppColors.textPrimary,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.92),

                            borderRadius:
                                BorderRadius.circular(
                                    18),

                            border: Border.all(
                              color:
                                  const Color(
                                      0xFFD9D9DF),
                            ),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset:
                                    const Offset(
                                  0,
                                  4,
                                ),

                                color: Colors.black
                                    .withOpacity(
                                  0.03,
                                ),
                              ),
                            ],
                          ),
                        ),

                        focusedPinTheme: PinTheme(
                          width: 52,
                          height: 58,

                          textStyle:
                              AppTextStyles.title
                                  .copyWith(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w700,

                            color: AppColors.black,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                                    18),

                            border: Border.all(
                              color:
                                  AppColors.black,

                              width: 1.5,
                            ),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: 18,
                                offset:
                                    const Offset(
                                  0,
                                  8,
                                ),

                                color: Colors.black
                                    .withOpacity(
                                  0.06,
                                ),
                              ),
                            ],
                          ),
                        ),

                        submittedPinTheme:
                            PinTheme(
                          width: 52,
                          height: 58,

                          textStyle:
                              AppTextStyles.title
                                  .copyWith(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w700,
                          ),

                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFF7F7FA),

                            borderRadius:
                                BorderRadius.circular(
                                    18),

                            border: Border.all(
                              color:
                                  const Color(
                                      0xFFD9D9DF),
                            ),
                          ),
                        ),

                        separatorBuilder:
                            (index) =>
                                const SizedBox(
                          width: 8,
                        ),

                        onCompleted: (pin) {
                          debugPrint(pin);
                        },
                      ),

                      const SizedBox(height: 18),

                      /// =========================
                      /// VERIFY BUTTON
                      /// =========================
                      CustomButton(
                        text: widget.buttonText,

                        icon:
                            Icons.arrow_forward_rounded,

                        onTap: widget.onVerify,
                      ),

                      const SizedBox(height: 18),

                      /// =========================
                      /// RESEND
                      /// =========================
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Text(
                            canResend
                                ? "Didn't receive code?"
                                : "Resend available in",

                            style:
                                AppTextStyles.body
                                    .copyWith(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(width: 6),

                          GestureDetector(
                            onTap: canResend
                                ? () {

                                    startTimer();

                                    widget.onResend
                                        ?.call();
                                  }
                                : null,

                            child: Text(
                              canResend
                                  ? "Resend OTP"
                                  : "00:${seconds.toString().padLeft(2, '0')}",

                              style:
                                  AppTextStyles.label
                                      .copyWith(
                                fontSize: 13,

                                color: canResend
                                    ? AppColors.black
                                    : AppColors
                                        .inactive,

                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "Please enter the verification code sent to your registered account.",

                        style:
                            AppTextStyles.small
                                .copyWith(
                          height: 1.5,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// =========================
                /// HELP CARD
                /// =========================
                _glassCard(
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      /// ICON
                      Container(
                        width: 42,
                        height: 42,

                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.06),

                          borderRadius:
                              BorderRadius.circular(
                                  14),
                        ),

                        child: const Icon(
                          Icons.security_rounded,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// TEXT
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              "Secure Verification",

                              style:
                                  AppTextStyles.label
                                      .copyWith(
                                fontWeight:
                                    FontWeight.w700,

                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Your OTP verification is encrypted and securely validated for enhanced protection.",

                              style:
                                  AppTextStyles.body
                                      .copyWith(
                                fontSize: 13,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  /// =========================
  /// GLASS CARD
  /// =========================
  static Widget _glassCard({
    required Widget child,
  }) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),

            borderRadius:
                BorderRadius.circular(24),

            border: Border.all(
              color:
                  Colors.white.withOpacity(0.8),
            ),

            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 10),

                color: Colors.black.withOpacity(
                  0.04,
                ),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}