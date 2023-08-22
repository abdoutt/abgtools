
import 'package:abgtools/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

abstract class DatePiker extends GetxController {
  late DatePikerView view;
  final ValueChanged<DateTime?> onSelectionChanged;
  final dateController = TextEditingController().obs;
  String waterMark = "";
  final DateRangePickerController controller = DateRangePickerController();

  DatePiker(
      {required this.onSelectionChanged,
      required this.waterMark,
      required DateTime val}) {
    view = DatePikerView(datePikerViewModel: this);
    dateController.value.text = DateFormat("yyyy-MM-dd").format(val);
    controller.selectedDate = val;
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args,BuildContext context) {
    dateController.value.text =
        DateFormat("yyyy-MM-dd").format(args.value);
    Navigator.pop(context);
    onSelectionChanged(args.value);
  }
}

class DatePikerView extends StatelessWidget {
  DatePiker datePikerViewModel;
  DatePikerView({required this.datePikerViewModel});
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: false,
         fontFamily: 'fontfamilly'.tr,
      ),
      child: PopupMenuButton(
        tooltip: datePikerViewModel.waterMark,
        padding: const EdgeInsets.all(0.0),
        offset: const Offset(0, 45),
        key: _menuKey,
        elevation: 2,
        constraints: const BoxConstraints(maxWidth: 280, minWidth: 280),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Obx(() => SizedBox(
          height: 35,
          child: TextFormField(
                decoration: InputDecoration(
                    counterText: "",
                    errorStyle: TextStyle(fontSize: 0.1),
                    fillColor: Colors.white,
                    hoverColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                    prefixStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    isDense: true,
                    hintStyle: TextStyle(color: secondColor25, fontSize: 10),
                    hintText: datePikerViewModel.waterMark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      borderSide: BorderSide(
                        color:secondColor7,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      borderSide: BorderSide(
                        color: secondColor20,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: BorderSide(
                          color: secondColor20,
                          width: 1.0,
                        )),
                    suffixIcon: InkWell(
                        overlayColor: MaterialStateProperty.resolveWith((states) {
                          // If the button is pressed, return size 40, otherwise 20
                          if (states.contains(MaterialState.hovered) &&
                              states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return Colors.transparent;
                        }),
                        onTap: () {
                          dynamic state = _menuKey.currentState;
                          state.showButtonMenu();
                        },
                        child: Icon(
                          Icons.date_range,
                          size: 15,
                          color: primaryColor,
                        ))),
        
                onChanged: (val) {
                  if (val.isNotEmpty) {
                   
                    datePikerViewModel.onSelectionChanged(DateTime.parse(val));
                    datePikerViewModel.controller.selectedDate =
                        DateTime.parse(val);
                       
                  }
                },
                validator: (val) {
                  //validateDate(val!);
                },
                controller: datePikerViewModel.dateController.value,
                keyboardType: TextInputType.datetime,
                style: const TextStyle(fontSize: 12),
                readOnly: true,
                autocorrect: false,
              ),
        )),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              padding: const EdgeInsets.symmetric(vertical: 2),
              enabled: false,
              child: SizedBox(
                height: 250,
                child: SfDateRangePickerTheme(
                  data: SfDateRangePickerThemeData(
                    
                      cellTextStyle: TextStyle(fontSize: 12),
                      selectionColor: primaryColor,
                      disabledCellTextStyle:
                          TextStyle(fontSize: 12, color: secondColor),
                      leadingCellTextStyle:
                          TextStyle(fontSize: 12, color: secondColor),
                      leadingDatesTextStyle:
                          TextStyle(fontSize: 12, color: secondColor),
                      rangeSelectionColor: primaryColor.withOpacity(0.20),
                      todayHighlightColor: primaryColor,
                      startRangeSelectionColor: primaryColor,
                      endRangeSelectionColor: primaryColor,
                      headerTextStyle:
                          TextStyle(fontSize: 12, color: secondColor),
                      viewHeaderTextStyle:
                          TextStyle(fontSize: 10, color: secondColor),
                      todayTextStyle:
                          TextStyle(color: primaryColor, fontSize: 12)),
                  child: SfDateRangePicker(
                    selectionColor: primaryColor,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
                    onSelectionChanged: (arg){
                       datePikerViewModel.selectionChanged(arg,context);
                    },
                    showNavigationArrow: true,
                    view: DateRangePickerView.month,
                    controller: datePikerViewModel.controller,
                    selectionMode: DateRangePickerSelectionMode.single,
                    yearCellStyle: DateRangePickerYearCellStyle(
                      todayTextStyle:
                          TextStyle(fontSize: 12, color: primaryColor),
                    ),
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: true,
                      enableSwipeSelection: true,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
