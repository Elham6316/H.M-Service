import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/theme/app_colors.dart';

class BaseTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword, enabled;
  final int? maxLength;
  final Function? onTap;
  final double verticalPadding, horizontalPadding;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const BaseTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onTap,
        this.maxLength,
        this.enabled = true,
      this.isPassword = false,
      this.horizontalPadding = 10,
      this.verticalPadding = 5,
      this.hintStyle,
      this.keyboardType,
      this.validator})
      : super(key: key);

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap == null ? null :widget.enabled?null:  () => widget.onTap!.call(),
      child: TextFormField(
        enabled: widget.enabled,
        maxLines: widget.maxLength??1,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        style: Get.textTheme.bodyText2!.copyWith(fontSize: 14, color: kBlack),
        obscureText: widget.isPassword,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                Get.textTheme.bodyText2!
                    .copyWith(fontSize: 14, color: kGreyMedium),
            errorStyle:
                Get.textTheme.bodyText2!.copyWith(fontSize: 14, color: kRedError),
            contentPadding: EdgeInsets.only(
                left: 14.0,
                bottom: widget.verticalPadding,
                top: widget.verticalPadding,
                right: 14.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreyDark),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreyDark),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreyDark),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kRed),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGreyDark),
            )),
      ),
    );
  }
}
