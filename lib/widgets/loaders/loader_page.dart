import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/loaders/loader.dart';

class LoaderPage extends StatelessWidget {
  final Widget child;
  final RxBool loading;
  const LoaderPage({Key? key, required this.child, required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        Obx(
          ()=> loading.value? Container(
            height: Get.height,
            width: Get.width,
            color: kGreyLight.withOpacity(0.5),
            child: const Center(child: Loader(color: kPrimary,),),
          ):const SizedBox(),
        ),
      ],
    );
  }
}
