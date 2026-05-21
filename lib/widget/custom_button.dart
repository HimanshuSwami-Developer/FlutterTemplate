import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  final bool isLoading;
  final bool isDisabled;

  final bool isFullWidth;

  final IconData? icon;

  final double height;
  final double radius;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? disabledColor;
  final Color? loadingColor;

  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,

    this.isLoading = false,
    this.isDisabled = false,

    this.isFullWidth = true,

    this.icon,

    this.height = 50,
    this.radius = 16,

    this.backgroundColor,
    this.textColor,
    this.disabledColor,
    this.loadingColor,

    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    final bool disabled =
        isDisabled || isLoading;

    final bg =
        backgroundColor ?? AppColors.primary;

    final txt =
        textColor ?? Colors.white;

    final disableBg =
        disabledColor ?? Colors.grey.shade300;

    return AnimatedOpacity(
      duration:
          const Duration(milliseconds: 180),

      opacity: disabled ? 0.7 : 1,

      child: GestureDetector(
        onTap: disabled ? null : onTap,

        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 220),

          curve: Curves.easeOut,

          height: height,

          width:
              isFullWidth ? double.infinity : null,

          padding:
              padding ??
              (isFullWidth
                  ? null
                  : const EdgeInsets.symmetric(
                      horizontal: 18,
                    )),

          decoration: BoxDecoration(
            color: disabled ? disableBg : bg,

            borderRadius:
                BorderRadius.circular(radius),

            boxShadow: disabled
                ? []
                : [
                    BoxShadow(
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                      color: Colors.black
                          .withOpacity(0.10),
                    ),
                  ],
          ),

          child: Center(
            child: isLoading

                /// LOADING
                ? SizedBox(
                    width: 20,
                    height: 20,

                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,

                      color:
                          loadingColor ??
                          Colors.white,
                    ),
                  )

                /// NORMAL
                : Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      /// TEXT
                      Text(
                        text,

                        style:
                            AppTextStyles.label
                                .copyWith(
                          color:
                              disabled
                                  ? Colors.grey
                                  : txt,

                          fontSize: 14,
                          fontWeight:
                              FontWeight.w700,

                          letterSpacing: 0.2,
                        ),
                      ),

                      /// ICON
                      if (icon != null) ...[
                        const SizedBox(width: 8),

                        Icon(
                          icon,
                          size: 18,
                          color: txt,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}