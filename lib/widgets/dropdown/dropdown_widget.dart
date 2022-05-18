import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_service/theme/app_colors.dart';
import 'package:hm_service/widgets/dropdown/dropdown_controller.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final String? initSelect;
  final String tag;
  final String hint;
  final ValueChanged<String> onItemSelect;

  const DropdownWidget(
      {Key? key,
      required this.items,
      required this.onItemSelect,
      required this.hint,
      required this.tag,
      this.initSelect})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  DropdownController? controller;

  @override
  void initState() {
    controller = Get.put(DropdownController(), tag: widget.tag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGreyMedium)),
      child: GetBuilder(
          init: controller,
          tag: widget.tag,
          initState: (state) => controller!.selectedString = widget.initSelect,
          builder: (_) => DropdownButton<String>(
                value: controller!.selectedString,
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: kBlack,
                  size: 40,
                ),
                isExpanded: true,
                elevation: 0,
                hint: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Text(
                    widget.hint,
                    style: const TextStyle(fontSize: 14, color: kBlack),
                  ),
                ),
                underline: const SizedBox(),
                onChanged: (String? value) {
                  widget.onItemSelect.call(value!);
                  controller!.onItemSelected(value);
                },
                items:
                    widget.items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 14, color: kBlack),
                      ),
                    ),
                  );
                }).toList(),
              )),
    );
  }
}
