import 'package:abgtools/constant.dart';
import 'package:abgtools/core/filter_option.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/core/relay_command.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/service/artical_api.dart';
import 'package:abgtools/view/add_edit_article_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomeViewModel extends PracticesViewModel<ArticleModel> {
  HomeViewModel() : super(titleKey: "article") {
    addActionCommand(
        RelayCommand(0, "اضافة", () {
          return true;
        }, newItem),
        '');

    addActionCommand(
        RelayCommand(1, "تعديل", () {
          return selectedItems.isNotEmpty ? true : false;
        }, updateItem),
        '');

    addActionCommand(
        RelayCommand(2, "حذف", () {
          return selectedItems.isNotEmpty ? true : false;
        }, deleteItem),
        '');
    md = 6;
    lg = 4;
    xl = 3;
  }

  @override
  List<Widget> buildRow(DataGridRow row) {
    return <Widget>[
      Row(
        children: [
          Text(
            row.getCells()[0].value.nomPiece,
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              row.getCells()[0].value.refrence,
              overflow: TextOverflow.ellipsis,
              style: rowTextStyle,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              row.getCells()[0].value.codebar.toString(),
              style: rowTextStyle,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.color,
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              row.getCells()[0].value.epaisseur.toString(),
              style: rowTextStyle,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.longueur.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.largeure.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.surface.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.electricite.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.faconnage.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.lavage.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.tableCoup.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
      Row(
        children: [
          Text(
            row.getCells()[0].value.serigraphie.toString(),
            overflow: TextOverflow.ellipsis,
            style: rowTextStyle,
          ),
        ],
      ),
    ];
  }

  @override
  Future<int> getCount(String q, List<FilterArgs> filterArgs) async {
    int count = await getArticleCount(q);
    return count;
  }

  @override
  Future<List<ArticleModel>> getPage(String filter, List<FilterArgs> filterArgs,
      int currentPage, int pageSize) async {
    source = (await getArticlePage(filter, currentPage, pageSize));
    return source;
  }

  @override
  void initializeCards() {
    // TODO: implement initializeCards
  }

  @override
  void initializeFilter() {
    // TODO: implement initializeFilter
  }

  newItem() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            useMaterial3: false,
            fontFamily: 'NotoKufiArabic',
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                contentPadding: const EdgeInsets.all(10),
                elevation: 10,
                alignment: Alignment.center,
                title: null,
                content: AddEditArticleView(
                    title: "اضافة ملف",
                    entity: ArticleModel(
                        id: 0,
                        codebar: "",
                        color: "",
                        electricite: 0,
                        epaisseur: 0,
                        faconnage: 0,
                        largeure: 0,
                        lavage: 0,
                        longueur: 0,
                        name: "",
                        nomPiece: "",
                        refrence: "",
                        serigraphie: 0,
                        surface: 0,
                        tableCoup: 0,
                        tremp: 0),
                    p: this)),
          ),
        );
      },
    );
  }

  updateItem() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            useMaterial3: false,
            fontFamily: 'NotoKufiArabic',
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                contentPadding: const EdgeInsets.all(10),
                elevation: 10,
                alignment: Alignment.center,
                title: null,
                content: AddEditArticleView(
                    title: "تعديل ملف", entity: selectedItems[0], p: this)),
          ),
        );
      },
    );
  }

  deleteItem() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Theme(
            data: ThemeData(
              useMaterial3: false,
              fontFamily: 'NotoKufiArabic',
            ),
            child: Container(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 15),
                    contentPadding: const EdgeInsets.all(10),
                    elevation: 10,
                    title: null,
                    content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(" هل تريدحدف هدا الملف"),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                      return;
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              secondColor3),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "الغاء",
                                        style: TextStyle(
                                            color: secondColor75,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    deletecommand(selectedItems[0].id);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "حذف",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )))));
      },
    );
  }

  deletecommand(int id) async {

    await deleteArticleApi(id);
Get.back();
  initialize();

  }
}
