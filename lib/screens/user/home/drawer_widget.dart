import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/helper/auth_helper.dart';
import 'package:hm_service/model/client.dart';
import 'package:hm_service/navigation/app_routes.dart';
import 'package:hm_service/theme/app_colors.dart';


class DrawerWidget extends StatelessWidget {
  final Client? client;
  const DrawerWidget({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.75,
      height: Get.height,
      color: kWhite,
      child: Column(
        children: [
          Container(
            decoration:
            const BoxDecoration(shape: BoxShape.circle, color: kGreyDark),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.person,
                color: kWhite,
                size: 80,
              ),
            ),
          ).paddingOnly(bottom: 10),
          if(client != null)
            Text(
              client!.fullName!,
              style: const TextStyle(fontSize: 20, color: kBlack),
            ),

          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _drawerItem(title: 'home_page'.tr, onTap: ()=> Get.back()),
              _drawerItem(title: 'my_requests'.tr, onTap:()=> Get.toNamed(Routes.myRequest)),
              _drawerItem(title: 'logout'.tr,showHorizontalLine: false,onTap: ()=> Get.find<AuthHelper>().logout()),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
            ],
          )),
        ],
      ).paddingOnly(top: 50),
    );
  }

  Widget _drawerItem({required String title, Function? onTap ,showHorizontalLine = true}){
    return InkWell(
      onTap: (){
        Get.back();
        onTap!.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(fontSize: 16,color: kBlack),).paddingOnly(bottom: 15).paddingSymmetric(horizontal: 10),
          if(showHorizontalLine)
            Container(
              height: 1,
              width: Get.width,
              color: kGreyMedium,
            ),
        ],
      ),
    );
  }
}
