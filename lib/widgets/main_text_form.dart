
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class MainTextField extends StatefulWidget {
  final Color? iconColor;
  final Color? labelColor;
  final Color? hintColor;
  final TextInputType? type;
  final String? hint;
  final Iterable<String>? autoFillHints;
  final String? anotherHint;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;
  final String? Function(String?)? validate;
  final int? maxLines;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool keyboardPadding;
  final bool contentPadding;
  final int? maxLength;
  final int? minLines;

  final bool? autoFocus;
  final String? errorText;
  final Color? fillColor;
  final Color? textColor;
  final Widget? suffixIcon;

  final String? initialValue;
  final Widget? prefixIcon;

  final bool isEnabled;
  final bool needMargin;

  final bool readOnly;
  final double? textSize;

  final TextDirection? textDirection;

  final List<TextInputFormatter>? formattedType;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final bool isNeedToElevation;
  final TextAlign? textAlign;
  final bool needToSuffixConstraints;
  final bool isResendSuffixIcon;
  final bool isBold;
  final TextInputAction inputAction;
  final FocusNode? focusNode;
  final String name;
  final bool isPassword;
  final void Function(bool)? onFocusChange;
  final void Function()? onEditingComplete;
  const MainTextField({
    Key? key,
    this.focusNode,
    this.type,
    this.hint,
    this.autoFillHints,
    this.isPassword = false,
    this.onChange,
    this.validate,
    this.onFocusChange,
    this.inputAction = TextInputAction.next,
    this.onTap,
    this.maxLines,
    this.isEnabled = true,
    this.onEditingComplete,
    this.controller,
    this.errorText,
    this.fillColor,
    this.textColor,
    this.maxLength,
    this.formattedType,
    this.iconColor,
    this.labelColor,
    this.keyboardPadding = true,
    this.contentPadding = false,
    this.autoFocus,
    this.initialValue,
    this.onSubmit,
    this.prefixIcon,
    this.readOnly = false,
    this.needMargin = true,
    this.textDirection,
    this.anotherHint,
    this.suffixIcon,
    this.textSize,
    this.height = 50,
    this.borderRadius = 12,
    this.isNeedToElevation = false,
    this.hintColor,
    this.textAlign,
    this.borderColor = Colors.cyan,
    this.needToSuffixConstraints = false,
    this.isResendSuffixIcon = false,
    this.isBold = true,
    this.minLines = 1,
    this.name = "",
  }) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool showPassword = false;
  int passwordStrength = 0;
  Color strengthColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.height,
        minWidth: 1,
        maxHeight: widget.height + 200,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: TextFormField(
        enableSuggestions: true,
        focusNode: widget.focusNode,
        autofillHints: widget.autoFillHints,
        onTap: widget.onTap,
        textInputAction: widget.inputAction,
        readOnly: widget.readOnly,
        onEditingComplete: widget.onEditingComplete,
        initialValue: widget.initialValue,
        autofocus: widget.autoFocus ?? false,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign ?? TextAlign.start,
        controller: widget.controller,
        maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,
        obscureText: widget.isPassword && !showPassword,
        validator: widget.validate,
        keyboardType: widget.type,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: widget.isPassword
            ? (password) {
          setState(() {
            passwordStrength = int.parse(password);
          });
        }
            : (txt) {
          if (widget.onChange != null) widget.onChange!(txt);
        },
        inputFormatters: widget.formattedType ?? [],
        style: TextStyle(
          fontSize: widget.textSize ?? 14,
          color: widget.textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
        scrollPadding: EdgeInsets.only(
          bottom: widget.keyboardPadding
              ? MediaQuery.of(context).size.height * .2
              : 0.0,
        ),
        cursorColor: Colors.cyan,
        decoration: InputDecoration(
          isDense: true,
          enabled: widget.isEnabled,
          // labelText: textDirection != null ? "" : hint ?? "",
          hintText: widget.anotherHint ?? widget.hint ?? "",
          labelStyle: TextStyle(
            color: widget.labelColor ?? (Colors.white),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(color: widget.borderColor!, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(color: widget.borderColor!, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(color: widget.borderColor!, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(color: widget.borderColor!, width: 0.5),
          ),
          //  alignLabelWithHint: true,
          fillColor: widget.fillColor ?? widget.borderColor,
          filled: true,
          errorText: widget.errorText,
          errorMaxLines: 1,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9D9DA6),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? SizedBox(
            width: 38,
            child: Row(
              children: [
                PopupMenuButton(
                  color: Colors.white,
                  shadowColor: strengthColor,
                  elevation: 50,
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        height: 20,
                        value: 3,
                        child: Text(
                          "Delete",
                        ),
                      ),
                    ];
                  },
                  child: Icon(
                    passwordStrength >= 3 ? Icons.lock : Icons.lock_open,
                    size: 16,
                    color: strengthColor,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                  child: Icon(
                    showPassword ? Iconsax.eye : Iconsax.eye_slash,
                    size: 16,
                  ),
                ),
              ],
            ),
          )
              : widget.suffixIcon,
          suffixIconConstraints: widget.needToSuffixConstraints
              ? BoxConstraints(
            minHeight: 47,
            minWidth: widget.isResendSuffixIcon ? 30 : 1,
            maxHeight: 48,
            maxWidth: widget.isResendSuffixIcon ? 30 : 1,
          )
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: widget.height < 49
                ? widget.suffixIcon != null || widget.prefixIcon != null
                ? 0
                : widget.height - 30
                : (7 + widget.height - 50),
          ),
        ),
      ),
    );
  }
}