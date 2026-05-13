import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';

class CustomTextField extends StatefulWidget {

  final String label;
  final String hint;

  final IconData? icon;

  final bool isPassword;
  final bool isTextArea;

  final TextEditingController? controller;

  /// NEW CUSTOMIZATION
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? labelColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,

    this.icon,
    this.isPassword = false,
    this.isTextArea = false,
    this.controller,

    /// OPTIONAL COLORS
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.labelColor,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {

    final background =
        widget.backgroundColor ??
            Colors.black.withOpacity(0.35);

    final text =
        widget.textColor ?? Colors.white;

    final hint =
        widget.hintColor ?? Colors.white24;

    final border =
        widget.borderColor ??
            Colors.white.withOpacity(0.05);

    final label =
        widget.labelColor ?? Colors.white70;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      mainAxisSize: MainAxisSize.min,

      children: [

        /// LABEL
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,

            style:
                AppTextStyles.label.copyWith(
              color: label,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 6),
        ],

        /// FIELD
        SizedBox(
          height:
              widget.isTextArea ? null : 52,

          child: TextField(
            controller: widget.controller,

            obscureText:
                widget.isPassword && !isVisible,

            textAlignVertical:
                TextAlignVertical.center,

            maxLines:
                widget.isTextArea ? 4 : 1,

            style:
                AppTextStyles.body.copyWith(
              color: text,
            ),

            decoration: InputDecoration(

              hintText: widget.hint,

              filled: true,

              fillColor: background,

              contentPadding:
                  const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),

              /// HINT
              hintStyle:
                  AppTextStyles.body.copyWith(
                color: hint,
              ),

              /// PREFIX ICON
              prefixIcon: widget.icon != null
                  ? Padding(
                      padding:
                          const EdgeInsets.all(12),

                      child: Icon(
                        widget.icon,
                        size: 18,
                        color: hint,
                      ),
                    )
                  : null,

              /// PASSWORD TOGGLE
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,

                        color: hint,
                      ),

                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    )
                  : null,

              /// BORDER
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),

                borderSide: BorderSide(
                  color: border,
                ),
              ),

              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),

                borderSide: BorderSide(
                  color: border,
                ),
              ),

              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),

                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}