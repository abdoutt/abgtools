
import 'package:abgtools/constant.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterOptionView<P extends PracticesViewModel> extends StatefulWidget {
  late P practicesViewModel;

  FilterOptionView({super.key, required this.practicesViewModel});

  @override
  State<FilterOptionView> createState() => _FilterOptionViewState();
}

class _FilterOptionViewState extends State<FilterOptionView> {
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
         fontFamily: 'fontfamilly'.tr,
      ),
      child: PopupMenuButton(
        tooltip: "filter".tr,
        key: _menuKey,
        padding: const EdgeInsets.all(0),
        position: PopupMenuPosition.under,
        elevation: 2,
        constraints: const BoxConstraints(maxWidth: 200, minWidth: 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Theme(
          data: ThemeData(
            useMaterial3: true,
             fontFamily: 'fontfamilly'.tr,
          ),
          child: IconButton(
            onPressed: () {
              dynamic state = _menuKey.currentState;
              state.showButtonMenu();
            },
            constraints: const BoxConstraints(
                maxHeight: 33, minHeight: 33, maxWidth: 33, minWidth: 33),
            iconSize: 15,
            padding: const EdgeInsets.all(0),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(width: 1, color: secondColor75)),
              backgroundColor: secondColor3,
              hoverColor: secondColor7,
              focusColor: secondColor7,
            ),
            icon: Image.asset(
              "assets/images/searchfilterwhite.png",
              color: secondColor,
              width: 15,
              height: 15,
            ),
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                enabled: false, // DISABLED THIS ITEM

                child: StatefulBuilder(builder: (context, setState) {
                  return Column(
                    children: [
                      for (int i = 0;
                          i < widget.practicesViewModel.filterManger.length;
                          i++)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int j = 0;
                                j <
                                    widget.practicesViewModel.filterManger[i]
                                        .options.length;
                                j++)
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox(
                                      tristate: true,
                                      activeColor: primaryColor,
                                      value: widget
                                          .practicesViewModel
                                          .filterManger[i]
                                          .options[j]
                                          .isSelected,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          widget
                                              .practicesViewModel
                                              .filterManger[i]
                                              .options[j]
                                              .isSelected = value ?? false;
                                        });
                                        Future.delayed(
                                            const Duration(milliseconds: 100));
                                        widget.practicesViewModel.initialize();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomText(
                                    text: widget.practicesViewModel
                                        .filterManger[i].options[j].name,
                                    size: 13,
                                    color: secondColor75,
                                  ),
                                ],
                              ),
                            i ==
                                    widget.practicesViewModel.filterManger
                                            .length -
                                        1
                                ? const SizedBox()
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: secondColor50))),
                                  )
                          ],
                        ),
                    ],
                  );
                })),
          ];
        },
      ),
    );
  }
}
