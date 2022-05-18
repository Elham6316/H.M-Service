import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:get/get.dart';
import 'package:hm_service/theme/app_colors.dart';


class FlashHelper {
  static void showTopFlash(String? msg,
      {FlashStyle style = FlashStyle.grounded,
      bool persistent = true,
      Color bckColor = kWarning,
      String title = "",
      bool showDismiss = false}) {
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 5),
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: bckColor,
          brightness: Brightness.light,
          boxShadows: const [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          style: style,
          position: FlashPosition.top,
          child: FlashBar(
            title: title.isEmpty
                ? null
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style:const TextStyle(
                        color: kWhite,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
            message: Center(
              child: Text(msg != null && msg.isNotEmpty ? msg : 'error_code',
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      height: 1.5,
                      color: kWhite,
                      fontSize: 14)),
            ),
            showProgressIndicator: false,
            primaryAction: null,
          ),
        );
      },
    );
  }
}
