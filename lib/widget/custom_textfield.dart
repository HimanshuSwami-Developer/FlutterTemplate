import 'package:flutter/material.dart';
import 'package:pubdev_widgets/core/app_text.dart';

import '../../core/app_colors.dart';

class CustomTextField extends StatefulWidget {

  final String label;
  final String hint;

  final IconData? icon;

  final bool isPassword;
  final bool isTextArea;

  final bool readOnly;

  final TextEditingController? controller;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? labelColor;

  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,

    required this.label,
    required this.hint,

    this.icon,

    this.isPassword = false,
    this.isTextArea = false,

    this.readOnly = false,

    this.controller,

    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.labelColor,

    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {

  bool isVisible = false;

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {

    final background =
        widget.backgroundColor ??
            Colors.white.withOpacity(0.55);

    final text =
        widget.textColor ??
            AppColors.textPrimary;

    final hint =
        widget.hintColor ??
            AppColors.inactive;

    final border =
        widget.borderColor ??
            const Color(0xFFD6D6DE);

    final label =
        widget.labelColor ??
            AppColors.textSecondary;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        /// =========================
        /// LABEL
        /// =========================
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding:
                const EdgeInsets.only(left: 2),

            child: Text(
              widget.label,

              style:
                  AppTextStyles.caption.copyWith(
                color: label,

                fontSize: 10,

                letterSpacing: 1.8,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],

        /// =========================
        /// FIELD
        /// =========================
        AnimatedContainer(
          duration:
              const Duration(milliseconds: 220),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(18),

            boxShadow: [

              /// FOCUS SHADOW
              if (isFocused &&
                  !widget.readOnly)
                BoxShadow(
                  blurRadius: 18,

                  spreadRadius: 0,

                  offset: const Offset(
                      0, 6),

                  color: Colors.black
                      .withOpacity(0.06),
                ),
            ],
          ),

          child: Focus(
            onFocusChange: (value) {

              setState(() {
                isFocused = value;
              });
            },

            child: TextField(
              controller: widget.controller,

              keyboardType:
                  widget.keyboardType,

              readOnly: widget.readOnly,

              obscureText:
                  widget.isPassword &&
                      !isVisible,

              maxLines:
                  widget.isTextArea ? 4 : 1,

              style:
                  AppTextStyles.body.copyWith(

                color:
                    widget.readOnly
                        ? Colors.black54
                        : text,

                fontSize: 14,

                fontWeight:
                    widget.readOnly
                        ? FontWeight.w500
                        : FontWeight.w400,
              ),

              cursorColor:
                  AppColors.black,

              decoration: InputDecoration(

                /// HINT
                hintText: widget.hint,

                hintStyle:
                    AppTextStyles.body.copyWith(
                  color: hint,
                  fontSize: 14,
                ),

                /// BG
                filled: true,

                fillColor:
                    widget.readOnly
                        ? const Color(
                            0xFFF2F2F5)
                        : background,

                /// PADDING
                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 18,

                  vertical:
                      widget.isTextArea
                          ? 18
                          : 16,
                ),

                /// PREFIX ICON
                prefixIcon:
                    widget.icon != null
                        ? Padding(
                            padding:
                                const EdgeInsets.only(
                              left: 14,
                              right: 8,
                            ),

                            child: Icon(
                              widget.icon,

                              size: 18,

                              color:
                                  widget.readOnly
                                      ? Colors
                                          .black38
                                      : isFocused
                                          ? AppColors
                                              .black
                                          : hint,
                            ),
                          )
                        : null,

                prefixIconConstraints:
                    const BoxConstraints(
                  minWidth: 42,
                ),

                /// PASSWORD
                suffixIcon:
                    widget.isPassword
                        ? IconButton(
                            splashRadius: 18,

                            icon: Icon(
                              isVisible
                                  ? Icons
                                      .visibility
                                  : Icons
                                      .visibility_off,

                              size: 20,

                              color: hint,
                            ),

                            onPressed: () {

                              setState(() {
                                isVisible =
                                    !isVisible;
                              });
                            },
                          )
                        : null,

                /// BORDER
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),

                  borderSide: BorderSide(
                    color: border,
                    width: 1,
                  ),
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),

                  borderSide: BorderSide(
                    color:
                        widget.readOnly
                            ? const Color(
                                0xFFE4E4EA)
                            : border,

                    width: 1,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          18),

                  borderSide: BorderSide(
                    color:
                        widget.readOnly
                            ? const Color(
                                0xFFE4E4EA)
                            : AppColors.black,

                    width: 1.3,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}