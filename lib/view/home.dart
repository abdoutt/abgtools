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
          authService.env!.type != 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    children: [
                      Text(
                        item.nomPiece,
                        style: cardTitleTextStyle,
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Prix ​​de vente",
                        style: cardTitleTextStyle,
                      ),
                      Text(
                        item.nomPiece,
                        style: cardTitleTextStyle,
                      ),
                    ],
                  ),
                ])
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.nomPiece} / ${item.name}",
                        style: cardTitleTextStyle,
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.refrence,
                        style: cardTitleTextStyle,
                      ),
                      Text(
                        formatter.format(item.createdAt),
                        style: cardTitleTextStyle,
                      ),
                    ],
                  ),
                  Text(
                    "${item.faconnage} / ${item.color} =  ${item.cout}",
                    style: cardSubTitleTextStyle,
                  ),
                  Text(
                    "${item.largeure} / ${item.epaisseur} / ${item.serigraphie}",
                    style: cardSubTitleTextStyle,
                  ),
                  Text(
                    "${item.largeure} / ${item.longueur}  = ${item.surface} ",
                    style: cardSubTitleTextStyle,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prix ​​de vente',
                        style: cardSubTitleTextStyle,
                      ),
                      Text(
                        formatCurrency.format(item.prixVent),
                        style: cardTitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
        ],
      ),
    );
  }

  @override
  List<GridColumn> buildColumns(BuildContext context) {
    return authService.env!.type != 0
        ? <GridColumn>[
            GridColumn(
                columnName: 'model',
                columnWidthMode: ResponsiveWidget.isLargeScreen(context)
                    ? ColumnWidthMode.fill
                    : ColumnWidthMode.auto,
                label: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Nom de piece',
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
                        'Prix ​​de vente',
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
          ]
        : <GridColumn>[
            GridColumn(
                columnName: 'model',
                columnWidthMode: ResponsiveWidget.isLargeScreen(context)
                    ? ColumnWidthMode.fill
                    : ColumnWidthMode.auto,
                label: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Nom de piece',
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
                        'Refrence',
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
                        ' code a baar',
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
                        'Couleur',
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
                        'Epaisseur',
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
                        'Longueur',
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
                        'Largeur',
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
                        'Surface',
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
                        'Electricite',
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
                        'Façonnage',
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
                        'Lavage',
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
                        'Table de coup',
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
                        'Sérigraphie',
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
                        'Prix ​​de vente',
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
