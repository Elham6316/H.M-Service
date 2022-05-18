import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  //Data
  final LoaderSize size;
  final Color? color;

  //Constructor
  const Loader({Key? key, this.size = LoaderSize.normal, this.color})
      : super(key: key);

  //Build *****************************
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size == LoaderSize.small
            ? 25
            : size == LoaderSize.verySmall
                ? 15
                : 35,
        height: size == LoaderSize.small
            ? 25
            : size == LoaderSize.verySmall
                ? 15
                : 35,
        child: SpinKitPouringHourGlass(
          color: color ?? Get.theme.primaryColor,
          size: size == LoaderSize.small
              ? 25
              : size == LoaderSize.verySmall
                  ? 15
                  : 35,
        ));
  }
}

enum LoaderSize { small, normal, verySmall }
