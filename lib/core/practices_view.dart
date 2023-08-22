import 'package:abgtools/constant.dart';
import 'package:abgtools/core/custom_button_dropdown.dart';
import 'package:abgtools/core/filter_option.dart';
import 'package:abgtools/core/filter_option_view.dart';
import 'package:abgtools/core/iidentity.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/core/relay_command.dart';
import 'package:abgtools/widgets/button_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../utils/helpers/reponsiveness.dart' as res;

abstract class PracticesView<T extends IIdentity,
    P extends PracticesViewModel<T>> extends StatelessWidget {
  PracticesView({super.key});
  late P practicesViewModel;
  //Widget buildListContant(BuildContext context);
  Widget buildCardContent(BuildContext context, T item);
  List<GridColumn> buildColumns(BuildContext context);
  Widget buildFilterParts() {
    List<FilterDisplayItem> selectedOptions = practicesViewModel.filterManger
        .where((element) => element.options.any((o) => o.isSelected))
        .map((e) => FilterDisplayItem(
            group: e.name,
            option: e.options
                .where((op) => op.isSelected)
                .map((eop) => eop.name)
                .toList()
                .join(' or ')))
        .toList();

    return selectedOptions.isEmpty
        ? const SizedBox()
        : Row(
            children: [
              SizedBox(
                width: 200,
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedOptions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            selectedOptions[index].group,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                        Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Center(
                                    child: Text(
                                  selectedOptions[index].option,
                                  style: TextStyle(
                                      fontSize: 10, color: secondColor75),
                                )),
                                const SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.redAccent),
                                  child: InkWell(
                                      onTap: () {
                                        practicesViewModel.removeFilterPart(
                                            selectedOptions[index].group);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )),
                      ]),
                    );
                  },
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: secondColor20,
                        width: 1,
                      ),
                    ),
                  ))
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    practicesViewModel.context = context;

    if (res.ResponsiveWidget.isSmallScreen(context)) {
      practicesViewModel.closeDetail();
    }
    Widget _buildStack(BuildContext context) {
      List<Widget> _getChildren() {
        final List<Widget> stackChildren = [];
        stackChildren.add(practicesViewModel.source.isEmpty
            ? Center(
                child: Icon(
                  MdiIcons.formatListText,
                  color: Colors.grey.withOpacity(0.5),
                  size: 200,
                ),
              )
            : SfDataGridTheme(
                data: SfDataGridThemeData(
                    gridLineColor: Colors.transparent,
                    headerHoverColor: Colors.transparent,
                    headerColor: secondColor7,
                    gridLineStrokeWidth: 1.0),
                child: SfDataGrid(
                  onSelectionChanged: (addedRows, removedRows) {
                    practicesViewModel.onSelectedChanged(
                        addedRows.map((e) => e.getCells()[0].value).toList(),
                        removedRows.map((e) => e.getCells()[0].value).toList());
                  },
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  headerRowHeight: 35,
                  frozenColumnsCount: 0,
                  verticalScrollController: ScrollController(),
                  horizontalScrollController: ScrollController(),
                  rowHeight: 34.0,
                  source: practicesViewModel.dataGridSource,
                  highlightRowOnHover: false,
                  selectionMode: SelectionMode.single,
                  showCheckboxColumn: true,
                  columns: buildColumns(context),
                ),
              ));

        if (practicesViewModel.isBusy.value) {
          stackChildren.add(Container(
              color: secondColor7,
              child: const Align(
                  alignment: Alignment.center,
                  child: SpinKitCircle(
                    color: Colors.amber,
                    size: 30.0,
                  ))));
        }

        return stackChildren;
      }

      return Stack(
        children: _getChildren(),
      );
    }

    if (res.ResponsiveWidget.isSmallScreen(context))
      practicesViewModel.changeView(false);
    return Scaffold(
      body: Container(
        color: secondColor3,
        padding: res.ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.only(top: 60, bottom: 0, left: 0, right: 0)
            : EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: res.ResponsiveWidget.isSmallScreen(context)
                      ? const EdgeInsets.only(top: 5)
                      : const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                  child: Text(
                    practicesViewModel.Title(),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NotoKufiArabic',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                    child: Text(practicesViewModel.Description(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontFamily: 'NotoKufiArabic',
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
            res.ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                height: 33,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1, color: secondColor20),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    Obx(() => practicesViewModel
                                            .filterManger.isEmpty
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: 25,
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(children: [
                                                  buildFilterParts(),
                                                ])))),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          prefixStyle: const TextStyle(
                                              color: Colors.black),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
                                          hintStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 12),
                                          hintText: 'Recherche',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0,
                                              )),
                                        ),
                                        controller: practicesViewModel.filter,
                                        onSubmitted: (value) {
                                          practicesViewModel.initialize();
                                        },
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(fontSize: 14),
                                        autocorrect: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButtonCustom(
                                            iconName: "searchicon.png",
                                            height: 30,
                                            width: 30,
                                            raduiseButton: 6,
                                            activeColors: Colors.transparent,
                                            hoverColors: Colors.transparent,
                                            mainColors: Colors.transparent,
                                            onPressed: () {
                                              practicesViewModel.initialize();
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            practicesViewModel.filterManger.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    width: 7,
                                  ),
                            practicesViewModel.filterManger.isEmpty
                                ? SizedBox()
                                : FilterOptionView(
                                    practicesViewModel: practicesViewModel),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => practicesViewModel.actionsCommands.isEmpty
                                      ? const SizedBox()
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            dropdownElevation: 1,
                                            buttonOverlayColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) {
                                              // If the button is pressed, return size 40, otherwise 20
                                              if (states.contains(
                                                      MaterialState.pressed) &&
                                                  states.contains(
                                                      MaterialState.pressed)) {
                                                return Colors.transparent;
                                              }
                                              return Colors.transparent;
                                            }),
                                            customButton: CustomButtonDropDown(
                                                preImage: "action.png",
                                                text: "Action",
                                                suffixImage: "dropdown.png"),
                                            dropdownWidth: 200,
                                            items: practicesViewModel
                                                .actionsCommands
                                                .map((item) => DropdownMenuItem<
                                                        RelayCommand>(
                                                      enabled:
                                                          item.canExecuteValue,
                                                      value: item,
                                                      child: Text(
                                                        item.value,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              item.canExecuteValue
                                                                  ? Colors.black
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              (value as RelayCommand).execute();
                                            },
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.white,
                                            ),
                                            dropdownPadding:
                                                const EdgeInsets.all(0),
                                            buttonHeight: 35,
                                            itemHeight: 35,
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Obx(() => practicesViewModel.printCommands.isEmpty
                                    ? const SizedBox()
                                    : DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          dropdownElevation: 1,
                                          buttonOverlayColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            // If the button is pressed, return size 40, otherwise 20
                                            if (states.contains(
                                                    MaterialState.pressed) &&
                                                states.contains(
                                                    MaterialState.pressed)) {
                                              return Colors.transparent;
                                            }
                                            return Colors.transparent;
                                          }),
                                          customButton: CustomButtonDropDown(
                                              preImage: "printer.png",
                                              text: "Printer",
                                              suffixImage: "dropdown.png"),
                                          dropdownWidth: 200,
                                          items: practicesViewModel.printCommands
                                              .map((item) =>
                                                  DropdownMenuItem<RelayCommand>(
                                                    enabled: item.canExecuteValue,
                                                    value: item,
                                                    child: Text(
                                                      item.value,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            item.canExecuteValue
                                                                ? Colors.black
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                          (value as RelayCommand).execute();
                                          },
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.white,
                                          ),
                                          dropdownPadding:
                                              const EdgeInsets.all(0),
                                          buttonHeight: 35,
                                          itemHeight: 35,
                                        ),
                                      )),
                              ],
                            ),
                         
                            Obx(() => Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            practicesViewModel.changeView(true);
                                          },
                                          padding: const EdgeInsets.all(3),
                                          icon: practicesViewModel
                                                  .listDisplay.value
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/whitelist.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor7,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/list.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              practicesViewModel
                                                  .changeView(false);
                                            },
                                            padding: const EdgeInsets.all(3),
                                            icon: practicesViewModel
                                                    .listDisplay.value
                                                ? Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor7,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/column.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/whitecolumn.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )),
                                      ],
                                    ))
                          ],
                        ),
                      ],
                    ),
                  )
                : res.ResponsiveWidget.isMediumScreen(context)
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5),
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => practicesViewModel.actionsCommands.isEmpty
                                      ? const SizedBox()
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            dropdownElevation: 1,
                                            buttonOverlayColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) {
                                              // If the button is pressed, return size 40, otherwise 20
                                              if (states.contains(
                                                      MaterialState.pressed) &&
                                                  states.contains(
                                                      MaterialState.pressed)) {
                                                return Colors.transparent;
                                              }
                                              return Colors.transparent;
                                            }),
                                            customButton: CustomButtonDropDown(
                                                preImage: "action.png",
                                                text: "Action",
                                                suffixImage: "dropdown.png"),
                                            dropdownWidth: 200,
                                            items: practicesViewModel
                                                .actionsCommands
                                                .map((item) => DropdownMenuItem<
                                                        RelayCommand>(
                                                      enabled:
                                                          item.canExecuteValue,
                                                      value: item,
                                                      child: Text(
                                                        item.value,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              item.canExecuteValue
                                                                  ? Colors.black
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              (value as RelayCommand).execute();
                                            },
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.white,
                                            ),
                                            dropdownPadding:
                                                const EdgeInsets.all(0),
                                            buttonHeight: 30,
                                            itemHeight: 35,
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Obx(() => practicesViewModel.printCommands.isEmpty
                                    ? const SizedBox()
                                    : DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          dropdownElevation: 1,
                                          buttonOverlayColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            // If the button is pressed, return size 40, otherwise 20
                                            if (states.contains(
                                                    MaterialState.pressed) &&
                                                states.contains(
                                                    MaterialState.pressed)) {
                                              return Colors.transparent;
                                            }
                                            return Colors.transparent;
                                          }),
                                          customButton: CustomButtonDropDown(
                                              preImage: "printer.png",
                                              text: "Printer",
                                              suffixImage: "dropdown.png"),
                                          dropdownWidth: 200,
                                          items: practicesViewModel.printCommands
                                              .map((item) =>
                                                  DropdownMenuItem<RelayCommand>(
                                                    enabled: item.canExecuteValue,
                                                    value: item,
                                                    child: Text(
                                                      item.value,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            item.canExecuteValue
                                                                ? Colors.black
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            // value!.execute();
                                          },
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.white,
                                          ),
                                          dropdownPadding:
                                              const EdgeInsets.all(0),
                                          buttonHeight: 35,
                                          itemHeight: 35,
                                        ),
                                      )),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      height: 33,
                                      width: 350,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1, color: secondColor20),
                                          borderRadius: BorderRadius.circular(6)),
                                      child: Row(
                                        children: [
                                          Obx(() => practicesViewModel
                                                  .filterManger.isEmpty
                                              ? const SizedBox()
                                              : SizedBox(
                                                  height: 25,
                                                  child: SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(children: [
                                                        buildFilterParts(),
                                                      ])))),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                prefixStyle: const TextStyle(
                                                    color: Colors.black),
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.all(0.0),
                                                hintStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12),
                                                hintText: 'Recherche',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0.0,
                                                    )),
                                              ),
                                              controller:
                                                  practicesViewModel.filter,
                                              onSubmitted: (value) {
                                                practicesViewModel.initialize();
                                              },
                                              keyboardType: TextInputType.text,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              autocorrect: false,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButtonCustom(
                                                  iconName: "searchicon.png",
                                                  height: 30,
                                                  width: 30,
                                                  raduiseButton: 6,
                                                  activeColors:
                                                      Colors.transparent,
                                                  hoverColors: Colors.transparent,
                                                  mainColors: Colors.transparent,
                                                  onPressed: () {
                                                    practicesViewModel
                                                        .initialize();
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    practicesViewModel.filterManger.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            width: 7,
                                          ),
                                    practicesViewModel.filterManger.isEmpty
                                        ? SizedBox()
                                        : FilterOptionView(
                                            practicesViewModel:
                                                practicesViewModel),
                                  ],
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                
                                   Obx(() => Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            practicesViewModel.changeView(true);
                                          },
                                          padding: const EdgeInsets.all(3),
                                          icon: practicesViewModel
                                                  .listDisplay.value
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/whitelist.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor7,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/list.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              practicesViewModel
                                                  .changeView(false);
                                            },
                                            padding: const EdgeInsets.all(3),
                                            icon: practicesViewModel
                                                    .listDisplay.value
                                                ? Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor7,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/column.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/whitecolumn.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )),
                                      ],
                                    ))
                                 ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => practicesViewModel.actionsCommands.isEmpty
                                      ? const SizedBox()
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            dropdownElevation: 1,
                                            buttonOverlayColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) {
                                              // If the button is pressed, return size 40, otherwise 20
                                              if (states.contains(
                                                      MaterialState.pressed) &&
                                                  states.contains(
                                                      MaterialState.pressed)) {
                                                return Colors.transparent;
                                              }
                                              return Colors.transparent;
                                            }),
                                            customButton: CustomButtonDropDown(
                                                preImage: "action.png",
                                                text: "Action",
                                                suffixImage: "dropdown.png"),
                                            dropdownWidth: 200,
                                            items: practicesViewModel
                                                .actionsCommands
                                                .map((item) => DropdownMenuItem<
                                                        RelayCommand>(
                                                      enabled:
                                                          item.canExecuteValue,
                                                      value: item,
                                                      child: Text(
                                                        item.value,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              item.canExecuteValue
                                                                  ? Colors.black
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              (value as RelayCommand).execute();
                                            },
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.white,
                                            ),
                                            dropdownPadding:
                                                const EdgeInsets.all(0),
                                            buttonHeight: 35,
                                            itemHeight: 35,
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Obx(() => practicesViewModel.printCommands.isEmpty
                                    ? const SizedBox()
                                    : DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          dropdownElevation: 1,
                                          buttonOverlayColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            // If the button is pressed, return size 40, otherwise 20
                                            if (states.contains(
                                                    MaterialState.pressed) &&
                                                states.contains(
                                                    MaterialState.pressed)) {
                                              return Colors.transparent;
                                            }
                                            return Colors.transparent;
                                          }),
                                          customButton: CustomButtonDropDown(
                                              preImage: "printer.png",
                                              text: "Printer",
                                              suffixImage: "dropdown.png"),
                                          dropdownWidth: 200,
                                          items: practicesViewModel.printCommands
                                              .map((item) =>
                                                  DropdownMenuItem<RelayCommand>(
                                                    enabled: item.canExecuteValue,
                                                    value: item,
                                                    child: Text(
                                                      item.value,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            item.canExecuteValue
                                                                ? Colors.black
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            (value as RelayCommand).execute();
                                          },
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Colors.white,
                                          ),
                                          dropdownPadding:
                                              const EdgeInsets.all(0),
                                          buttonHeight: 40,
                                          itemHeight: 35,
                                        ),
                                      )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      height: 33,
                                      width:
                                          MediaQuery.of(context).size.width > 600
                                              ? 450
                                              : MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1, color: secondColor20),
                                          borderRadius: BorderRadius.circular(6)),
                                      child: Row(
                                        children: [
                                          Obx(() => practicesViewModel
                                                  .filterManger.isEmpty
                                              ? const SizedBox()
                                              : SizedBox(
                                                  height: 25,
                                                  child: SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(children: [
                                                        buildFilterParts(),
                                                      ])))),
                                          Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                prefixStyle: const TextStyle(
                                                    color: Colors.black),
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.all(0.0),
                                                hintStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 12),
                                                hintText: 'Recherche',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0.0,
                                                    )),
                                              ),
                                              controller:
                                                  practicesViewModel.filter,
                                              onSubmitted: (value) {
                                                practicesViewModel.initialize();
                                              },
                                              keyboardType: TextInputType.text,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              autocorrect: false,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButtonCustom(
                                                  iconName: "searchicon.png",
                                                  height: 30,
                                                  width: 30,
                                                  raduiseButton: 6,
                                                  activeColors:
                                                      Colors.transparent,
                                                  hoverColors: Colors.transparent,
                                                  mainColors: Colors.transparent,
                                                  onPressed: () {
                                                    practicesViewModel
                                                        .initialize();
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    practicesViewModel.filterManger.isEmpty
                                        ? SizedBox()
                                        : SizedBox(
                                            width: 7,
                                          ),
                                    practicesViewModel.filterManger.isEmpty
                                        ? SizedBox()
                                        : FilterOptionView(
                                            practicesViewModel:
                                                practicesViewModel),
                                  ],
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Obx(() => Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            practicesViewModel.changeView(true);
                                          },
                                          padding: const EdgeInsets.all(3),
                                          icon: practicesViewModel
                                                  .listDisplay.value
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/whitelist.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: secondColor7,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0)),
                                                  child: Image.asset(
                                                    "assets/images/list.png",
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              practicesViewModel
                                                  .changeView(false);
                                            },
                                            padding: const EdgeInsets.all(3),
                                            icon: practicesViewModel
                                                    .listDisplay.value
                                                ? Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor7,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/column.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: secondColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                    child: Image.asset(
                                                      "assets/images/whitecolumn.png",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                  )),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
            /* - - - -- */
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: res.ResponsiveWidget.isSmallScreen(
                                          context)
                                      ? Border.all(width: 1, color: secondColor20)
                                      :  Border(
                                              bottom: BorderSide(
                                                  width: 1, color: secondColor20),
                                              top: BorderSide(
                                                  width: 1, color: secondColor20),
                                              left: BorderSide(
                                                  width: 1, color: secondColor20))
                                          ),
                              child: Column(children: [
                                Obx(() => practicesViewModel.loading.value
                                    ? Expanded(
                                        child: const Center(
                                        child: SpinKitCircle(
                                          color: Colors.amber,
                                          size: 30.0,
                                        ),
                                      ))
                                    : practicesViewModel.listDisplay.value
                                        ? Expanded(child: _buildStack(context))
                                        //list of card content
                                        : Expanded(
                                            child: practicesViewModel.isBusy.value
                                                ? const SpinKitCircle(
                                                    color: Colors.amber,
                                                    size: 30.0,
                                                  )
                                                : practicesViewModel
                                                        .source.isEmpty
                                                    ? Center(
                                                        child: Icon(
                                                          MdiIcons.formatListText,
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          size: 200,
                                                        ),
                                                      )
                                                    : SingleChildScrollView(
                                                        child: ResponsiveGridRow(
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      practicesViewModel
                                                                          .source
                                                                          .length;
                                                                  i++)
                                                                ResponsiveGridCol(
                                                                  xs: practicesViewModel
                                                                      .xs,
                                                                  md: practicesViewModel
                                                                      .md,
                                                                  sm: practicesViewModel
                                                                      .sm,
                                                                  lg: practicesViewModel
                                                                      .lg,
                                                                  xl: practicesViewModel
                                                                      .xl,
                                                                  child: InkWell(
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10)),
                                                                    overlayColor: MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                0.5)),
                                                                    onTap: () {
                                                                      practicesViewModel
                                                                          .openDetail(
                                                                              practicesViewModel.source[i]);
                                                                    },
                                                                    onLongPress:
                                                                        () {
                                                                      practicesViewModel
                                                                          .onSelectedChanged(
                                                                              [
                                                                            practicesViewModel
                                                                                .source[i]
                                                                          ],
                                                                              [
                                                                            practicesViewModel
                                                                                .source[i]
                                                                          ]);
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: !practicesViewModel.selectedItems.contains(practicesViewModel.source[i]) ? Colors.white : secondColor7,
                                                                            //color: Colors.white,
                                                                            border: Border.all(width: 0.6, color: secondColor20)),
                                                                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                                        padding: EdgeInsets.all(5.0),
                                                                        child: buildCardContent(context, practicesViewModel.source[i])),
                                                                  ),
                                                                ),
                                                            ]),
                                                      ))),
                              ])),
                        ),
                        Obx(() => Container(
                            padding: EdgeInsets.zero,
                            child: SfDataPagerTheme(
                              data: SfDataPagerThemeData(
                                itemColor: Colors.white,
                                selectedItemColor: primaryColor,
                                itemBorderRadius: BorderRadius.circular(5),
                                backgroundColor: Colors.transparent,
                              ),
                              child: SfDataPager(
                                delegate: practicesViewModel.dataGridSource,
                                // onPageNavigationStart: (int pageIndex) {
                                //   practicesViewModel.onPagination(pageIndex);
                                // },
                                pageCount:
                                    practicesViewModel.totalPages.toDouble(),
                                navigationItemHeight: 30,
                                initialPageIndex: 0,
                                itemHeight: 30,
                                itemWidth: 30,
                                direction: Axis.horizontal,
                              ),
                            ))),
                      ],
                    ),
                  ),
                  Obx(() => practicesViewModel.sideView.value
                      ? Container(
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: secondColor20)),
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButtonCustom(
                                        iconName: "popup-arow-ar.png"
                                               ,
                                        mainColors: primaryColor,
                                        hoverColors: primaryColor,
                                        activeColors: primaryColor,
                                        raduiseButton: 3,
                                        width: 35,
                                        height: 35,
                                        onPressed: () {
                                          practicesViewModel.closeDetail();
                                        }),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      width: 235,
                                      height: 55,
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            hoverColor: secondColor7,
                                            filled: true,
                                            hintText: 'يحث',
                                            counter: const SizedBox.shrink(),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical:8,
                                                horizontal: 10.0),
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              borderSide: BorderSide(
                                                color: secondColor50,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                              borderSide: BorderSide(
                                                color: secondColor20,
                                                width: 2.0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                borderSide: BorderSide(
                                                  color: secondColor7,
                                                  width: 2.0,
                                                )),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: IconButtonCustom(
                                                mainColors: Colors.transparent,
                                                activeColors: Colors.transparent,
                                                hoverColors: Colors.transparent,
                                                iconName: "searchbyfilter.png",
                                                height: 30,
                                                width: 30,
                                                onPressed: () {
                                                  practicesViewModel
                                                      .onFilterDetailChanged();
                                                },
                                                raduiseButton: 4,
                                              ),
                                            )),
                                        controller:
                                            practicesViewModel.filterDetail,
                                        onFieldSubmitted: (value) {
                                          practicesViewModel
                                              .onFilterDetailChanged();
                                        },
                                        onChanged: (val) => practicesViewModel
                                            .onFilterDetailChanged(),
                                        keyboardType: TextInputType.text,
                                        maxLength: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => practicesViewModel.displayCards.isEmpty
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("cartes vides"),
                                      ))
                                    : Expanded(
                                        child: ListView.builder(
                                            itemCount: practicesViewModel
                                                .displayCards.length,
                                            itemBuilder: ((context, index) {
                                              return practicesViewModel
                                                  .displayCards[index].view;
                                            })),
                                      )),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox())
                ],
              ),
            ),
            /* - - - - */
          ],
        ),
      ),
    );
  }
}
