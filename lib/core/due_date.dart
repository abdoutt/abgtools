import 'package:abgtools/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

abstract class DueDateViewModel extends GetxController {
  late DueDateView view;
  final ValueChanged<Map<String, dynamic>> onSelectionChange;
  Rx<DateTime> startDateSelect = DateTime(1, 1, 1).obs;
  Rx<DateTime> endDateSelect = DateTime(1, 1, 1).obs;
  Map<String, dynamic>? date;
  final DateRangePickerController controller = DateRangePickerController();


  DueDateViewModel(
      {required this.onSelectionChange,
      DateTime? startDate,
      DateTime? endDate,}) {
    view = DueDateView(dueDateViewModel: this);
    startDateSelect.value = startDate ?? DateTime(1, 1, 1);
    endDateSelect.value = endDate ?? DateTime(1, 1, 1);
    
  }
 
 


  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      if (args.value.startDate != DateTime(1, 1, 1) &&
          args.value.endDate != DateTime(1, 1, 1)&& args.value.endDate!=null) {
        startDateSelect.value = args.value.startDate ?? DateTime(1, 1, 1);
        endDateSelect.value = args.value.endDate ?? DateTime(1, 1, 1);
        date = {
          "dueDete": startDateSelect.value,
          "endDueDate": endDateSelect.value,
        };
        onSelectionChange(date!);
      }
    }
  }

}

class DueDateView extends StatelessWidget {
  DueDateViewModel dueDateViewModel;
  DueDateView({required this.dueDateViewModel});
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'fontfamilly'.tr,
        useMaterial3: false,
      ),
      child: PopupMenuButton(
        tooltip: "timeRange".tr,
        padding: const EdgeInsets.all(0.0),
        offset: const Offset(0, 45),
        key: _menuKey,
        elevation: 2,
        constraints: const BoxConstraints(maxWidth: 400, minWidth: 400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.resolveWith((states) {
            // If the button is pressed, return size 40, otherwise 20
            if (states.contains(MaterialState.hovered) &&
                states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.white;
          }),
          onTap: () {
            dynamic state = _menuKey.currentState;
            state.showButtonMenu();
          },
          child: Obx(() => dueDateViewModel.startDateSelect !=
                          DateTime(1, 1, 1) &&
                      dueDateViewModel.endDateSelect != DateTime(1, 1, 1)
                  ? Row(
                      children: [
                        Text(
                          formatter
                              .format(dueDateViewModel.startDateSelect.value)
                              .toString(),
                          style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        Text(
                          formatter
                              .format(dueDateViewModel.endDateSelect.value)
                              .toString(),
                          style:TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : dueDateViewModel.startDateSelect.value ==
                              DateTime(1, 1, 1) &&
                          dueDateViewModel.endDateSelect.value !=
                              DateTime(1, 1, 1)
                      ? Column(
                          children: [
                            Text(
                              "main_dueDate".tr,
                              style:TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formatter
                                  .format(dueDateViewModel.endDateSelect.value)
                                  .toString(),
                              style:TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : dueDateViewModel.startDateSelect.value !=
                                  DateTime(1, 1, 1) &&
                              dueDateViewModel.endDateSelect.value ==
                                  DateTime(1, 1, 1)
                          ? Row(
                              children: [
                                Text(
                                  formatter
                                      .format(dueDateViewModel
                                          .startDateSelect.value)
                                      .toString(),
                                  style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                                ),
                                Image.asset("assets/images/arrow.png",
                                    width: 20, height: 20),
                                Image.asset("assets/images/calander.png",
                                    width: 30, height: 30)
                              ],
                            )
                          : Row(
                              children: [
                                Text('filterByDate'.tr,
                                    style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold)),
                                Image.asset("assets/images/calander.png",
                                    width: 30, height: 30),
                              ],
                            ))
          ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              padding: const EdgeInsets.only(top: 5),
              enabled: false,
              child: Obx(() => SizedBox(
                height: 225,
                child: SfDateRangePickerTheme(
                  data: SfDateRangePickerThemeData(
                      cellTextStyle: const TextStyle(fontSize: 12),
                      selectionColor: primaryColor,
                      rangeSelectionColor: primaryColor,
                      todayHighlightColor: primaryColor,
                      startRangeSelectionColor: primaryColor,
                      endRangeSelectionColor: primaryColor,
                      todayTextStyle:
                          TextStyle(color: primaryColor, fontSize: 12)),
                  child: SfDateRangePicker(
                    selectionColor: primaryColor,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    view: DateRangePickerView.month,
                    controller: dueDateViewModel.controller,
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged:
                        dueDateViewModel.selectionChanged,
                    initialSelectedRange: PickerDateRange(
                        dueDateViewModel.startDateSelect.value !=
                                DateTime(1, 1, 1)
                            ? dueDateViewModel.startDateSelect.value
                            : null,
                        dueDateViewModel.endDateSelect.value !=
                                DateTime(1, 1, 1)
                            ? dueDateViewModel.endDateSelect.value
                            : null),
                    monthViewSettings:
                        const DateRangePickerMonthViewSettings(
                            showTrailingAndLeadingDates: true,
                            enableSwipeSelection: true),
                  ),
                ),
              ),
            ))
          ];
        },
      ),
    );
  }
}
