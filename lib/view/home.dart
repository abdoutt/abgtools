import 'package:abgtools/constant.dart';
import 'package:abgtools/core/practices_view.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/reponsiveness.dart';
import 'package:abgtools/viewmodel/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomeView extends PracticesView<ArticleModel, HomeViewModel> {
  HomeView({super.key}) {
    practicesViewModel = HomeViewModel();
  }
  @override
  Widget buildCardContent(BuildContext context, ArticleModel item) {
    return Padding(
      padding: cardFieldPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.tableCoup} / ${item.color}",
                  style: cardTitleTextStyle,
                ),
                Text(
                  "${item.serigraphie} / ${item.epaisseur}",
                  style: cardResultTextStyle,
                ),
                Text(
                  "${item.largeure} / ${item.longueur} ",
                  style: cardResultTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  List<GridColumn> buildColumns(BuildContext context) {
    return <GridColumn>[
      GridColumn(
          columnName: 'model',
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'اسم الجزء',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),

      GridColumn(
          columnName: 'model',
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'مرجع',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
          
           GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'الباركود',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'اللون',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'السماكة',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'الطول',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'العرض',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'السطح',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'الكهرباء',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'تشكيل',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'غسل',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'طاولة الركلة',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnWidthMode: ResponsiveWidget.isLargeScreen(context)
              ? ColumnWidthMode.fill
              : ColumnWidthMode.auto,
          columnName: 'model',
          label: Row(
            children: [
              Expanded(
                child: Text(
                  'طباعة الشاشة',
                  style: columnTextStyle,
                ),
              ),
            ],
          )),
      GridColumn(
          columnName: 'model',
          label: Text(
            '',
          )),
    ];
  }
}
