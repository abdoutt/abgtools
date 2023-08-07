
import 'package:abgtools/constant.dart';
import 'package:abgtools/core/iidentity.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PracticesDataGridSource<T extends IIdentity> extends DataGridSource {
  late PracticesViewModel parent;
  PracticesDataGridSource({required this.parent}) {
    dataGridRows = parent.source
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<dynamic>(columnName: 'model', value: e),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    if (oldPageIndex == newPageIndex) return false;
    parent.currentPage = newPageIndex;
    parent.load();
    return true;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    Color getRowBackgroundColorlocal() {
      final int index = dataGridRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.white;
      }

      return secondColor3;
    }

    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'fontfamilly'.tr,
    );
    List<Widget> cells = parent.buildRow(row);
    cells.add(Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: IconButtonCustom(
            iconName: "show.png",
            mainColors: Colors.transparent,
            activeColors: Colors.transparent,
            hoverColors: Colors.transparent,
            height: 40,
            width: 40,
            onPressed: () {
              parent.openDetail(row.getCells()[0].value);
            },
            raduiseButton: 0,
          ),
        ),
      ],
    ));
    return DataGridRowAdapter(
        color: getRowBackgroundColorlocal(), cells: cells);
  }
}
