import 'dart:convert';
import 'dart:typed_data';

import 'package:abgtools/constant.dart';
import 'package:abgtools/core/filter_option.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/core/relay_command.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:abgtools/utils/service/artical_api.dart';
import 'package:abgtools/view/add_edit_article_view.dart';
import 'package:abgtools/view/cards/article_card_item.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:dxf/dxf.dart';

class HomeViewModel extends PracticesViewModel<ArticleModel> {
  HomeViewModel() : super(titleKey: "article") {
    md = 6;
    lg = 4;
    xl = 3;
    if (authService.env!.type != 0) {
      return;
    }
    addActionCommand(
        RelayCommand(0, "Ajout", () {
          return true;
        }, newItem),
        '');
    addActionCommand(
        RelayCommand(1, "Importer un fichier xlsx", () {
          return true;
        }, importFile),
        '');
    addActionCommand(
        RelayCommand(2, "Modification", () {
          return selectedItems.isNotEmpty ? true : false;
        }, updateItem),
        '');

    addActionCommand(
        RelayCommand(3, "Upload une photo", () {
          return selectedItems.isNotEmpty ? true : false;
        }, pickFileXDF),
        '');

    addActionCommand(
        RelayCommand(4, "supprimer", () {
          return selectedItems.isNotEmpty ? true : false;
        }, deleteItem),
        '');

    addPrintCommand(
        RelayCommand(0, "Printer", () {
          return selectedItems.isNotEmpty ? true : false;
        }, getArticlePrint),
        '');
  }
  late String imageLoad;
  @override
  List<Widget> buildRow(DataGridRow row) {
    return authService.env!.type != 0
        ? <Widget>[
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
                Text(
                  row.getCells()[0].value.prixVent.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: rowTextStyle,
                ),
              ],
            ),
          ]
        : <Widget>[
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
            Row(
              children: [
                Text(
                  row.getCells()[0].value.prixVent.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: rowTextStyle,
                ),
              ],
            ),
          ];
  }

  @override
  Future<int> getCount(String q, List<FilterArgs> filterArgs) async {
    late int count;
    await APIInvokeGeneral(() async {
      count = await getArticleCount(q);
    });
    return count;
  }

  @override
  Future<List<ArticleModel>> getPage(String filter, List<FilterArgs> filterArgs,
      int currentPage, int pageSize) async {
    await APIInvokeGeneral(() async {
      source = (await getArticlePage(filter, currentPage, pageSize));
    });
    return source;
  }

  @override
  void initializeCards() {
    if (authService.env!.type == 0) cards.add(ArticleInfoCardItem(title: ""));
  }

  @override
  void initializeFilter() {
    // TODO: implement initializeFilter
  }
  void importFile() async {
    List<ArticleModel> articleList = [];
    try {
      Get.back();
      //blocked
      Get.defaultDialog(
          title: "Veuillez patienter s'il vous plaît",
          titleStyle: TextStyle(fontSize: 14),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: SpinKitCircle(
                  color: primaryColor,
                  size: 32.0,
                ),
              ),
            ],
          ),
          radius: 3.0);
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        withData: true,
        allowedExtensions: ['xlsx'],
      );
      if (result == null) {
        return;
      }
      isBusy.value = true;
      PlatformFile file = result.files.first;
      //implement code to read file xlsx
      final bytes = file.bytes!;
      final excel = Excel.decodeBytes(bytes.buffer.asUint8List());
//? check sheet name
      var names = excel.sheets.keys.toList();
      String sheetname = names.first;
      final sheet = excel[sheetname];

      //?check if column contain the required fields.
      if (!sheet.rows[0].any((cell) => cell!.value.toString() == "Refrence")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Refrence', columnIndex: 0);

        return;
      }
      if (!sheet.rows[0]
          .any((cell) => cell!.value.toString() == "Designation")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Designation', columnIndex: 1);

        return;
      }
      if (!sheet.rows[0].any((cell) => cell!.value.toString() == "Codebar")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Codebar', columnIndex: 2);

        return;
      }

      if (!sheet.rows[0].any((cell) => cell!.value.toString() == "Couleur")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Couleur', columnIndex: 2);

        return;
      }
      if (!sheet.rows[0].any((cell) => cell!.value.toString() == "Epaisseur")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Epaisseur', columnIndex: 2);

        return;
      }
      if (!sheet.rows[0].any((cell) => cell!.value.toString() == "Trou")) {
        Get.back();
        columnRequiredCheckerMessage(columnName: 'Trou', columnIndex: 2);

        return;
      }
      bool isFirst = true;
      int rowNumber = 0;
      if (sheet.rows.length < 2) {
        Get.back();
        Get.defaultDialog(
            title: '',
            titlePadding: EdgeInsets.zero,
            content: Container(
                constraints: BoxConstraints(maxWidth: popUpMaxWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Ne existe pas",
                              style: popUpTitleMessageTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        //call back
                        Get.back();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OK",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ],
            radius: 3.0);
        return;
      }
      for (var row in sheet.rows) {
        rowNumber++;
        if (isFirst) {
          isFirst = false;
          continue;
        }
        String? refrence = row[0]?.value?.toString();
        String? designation = row[1]?.value?.toString();
        String? codebar = row[2]?.value.toString();
        String? couleur = row[3]?.value.toString();
        String? epaisseur = row[4]?.value.toString();
        int? trou = int.tryParse(row[5]?.value?.toString() ?? "");
        if (refrence == null || refrence.isEmpty) {
          Get.back();
          rowRequiredCheckerMessage(
              columnName: 'Refrence', rowIndex: rowNumber);

          return;
        }
        if (designation == null || designation.isEmpty) {
          Get.back();
          rowRequiredCheckerMessage(
              columnName: 'Designation', rowIndex: rowNumber);

          return;
        }
        if (codebar == null || codebar.isEmpty) {
          Get.back();
          rowRequiredCheckerMessage(columnName: 'Codebar', rowIndex: rowNumber);

          return;
        }

        if (couleur == null || couleur.isEmpty) {
          Get.back();
          rowRequiredCheckerMessage(columnName: 'Couleur', rowIndex: rowNumber);

          return;
        }
        if (epaisseur == null || epaisseur.isEmpty) {
          Get.back();
          rowRequiredCheckerMessage(
              columnName: 'Epaisseur', rowIndex: rowNumber);

          return;
        }
        if (trou == null || trou < 0) {
          Get.back();
          rowRequiredCheckerMessage(columnName: 'Trou', rowIndex: rowNumber);

          return;
        }
        articleList.add(ArticleModel(
            codebar: codebar,
            color: couleur,
            electricite: 0,
            epaisseur: epaisseur,
            faconnage: 0,
            largeure: 0,
            lavage: 0,
            longueur: 0,
            name: "",
            nomPiece: designation,
            refrence: refrence,
            serigraphie: 0,
            surface: 0,
            tableCoup: 0,
            cout: 0,
            prixVent: 0,
            service: 0,
            trou: trou,
            prixTrou: 0,
            tremp: 0,
            createdAt: DateTime.now(),
            id: 0));
      }

      isBusy.value = true;
      Get.back();
      await importArticleApi(articleList).then((value) {
        Get.back();
        Get.defaultDialog(
          radius: 3.00,
          title: '',
          titleStyle: const TextStyle(fontSize: 0),
          titlePadding: const EdgeInsets.all(0),
          confirm: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  initialize();
                  Get.back();
                  Get.back();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(primaryColor),
                ),
                child: Text(
                  "OK",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            constraints: const BoxConstraints(minWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Votre fichier a été ajouté avec succès",
                      style: TextStyle(
                        color: secondColor75,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
      Get.defaultDialog(
          title: 'Catching error'.tr,
          textCancel: "Ok".tr,
          cancelTextColor: Colors.black,
          buttonColor: Colors.black,
          content: Text(e.toString()),
          radius: 10.0);
      return;
    } finally {
      isBusy.value = false;
    }
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
                    title: "Ajouter un fichier",
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
                        cout: 0,
                        prixVent: 0,
                        service: 0,
                        trou: 0,
                        prixTrou: 0,
                        createdAt: DateTime.now(),
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
                    title: "Modifier un fichier",
                    entity: selectedItems[0],
                    p: this)),
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
                            Text("Voulez-vous supprimer ce fichier"),
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
                                        "Annulation",
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
                                      "supprimer",
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

  getArticlePrint() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Veuillez patienter s'il vous plaît"),
      ),
    );
    await APIInvokeGeneral(() async {
      imageLoad = await getImage(selectedItems[0].id.toString());
    });

    Uint8List byte = await generatePdf(PdfPageFormat.a4);
    String file = "${selectedItems[0].nomPiece}.pdf";
    FlutterFileSaver().writeFileAsBytes(
      fileName: file,
      bytes: byte,
    );
    Get.back();
  }

  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
    );
    final image = await imageFromAssetBundle(
      'assets/images/logo.png',
    );
  
    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(10),
        pageFormat: format,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(image, height: 55),
                  pw.Row(
                    children: [
                      pw.Text("SARL",
                          style: pw.TextStyle(
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          )),
                      pw.SizedBox(
                        width: 5,
                      ),
                      pw.Text("ABG",
                          style: pw.TextStyle(
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(0xFFFDAC48),
                          )),
                      pw.SizedBox(
                        width: 5,
                      ),
                      pw.Text("USINE",
                          style: pw.TextStyle(
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          )),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5.0,
              ),
              pw.Row(
                children: [
                  pw.Expanded(flex: 1, child: pw.SizedBox()),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        margin: pw.EdgeInsets.zero,
                        padding: pw.EdgeInsets.all(8.0),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.only(
                              topLeft: pw.Radius.circular(30)),
                          color: PdfColor.fromInt(0xFFFDAC48),
                        ),
                        child: pw.Text("Plus que suffisamment de choix",
                            style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            )),
                      )),
                ],
              ),
              pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                          top: pw.BorderSide(
                              width: 4, color: PdfColors.black)))),
              pw.SizedBox(
                height: 8.0,
              ),
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text("Date : ",
                              style: pw.TextStyle(
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              )),
                          pw.Text(formatter.format(selectedItems[0].createdAt),
                              style: pw.TextStyle(
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              )),
                        ],
                      ),
                      pw.Text(selectedItems[0].name,
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          )),
                    ],
                  )),
              pw.SizedBox(
                height: 15.0,
              ),
              selectedItems[0].image!.isEmpty
                  ? pw.SizedBox()
                  : pw.Center(
                      child: pw.Image(
                          width: 300,
                          height: 300,
                          pw.MemoryImage(base64Decode(imageLoad))),
                    ),
              pw.SizedBox(
                height: 25,
              ),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                          width: 125,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 1, style: pw.BorderStyle.solid)),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("NOM DE PIECE",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("REFRENCE",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("CODE BAAR",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("COULEUR",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                child: pw.Text("Epaisseur",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                child: pw.Text("Longoeur",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                child: pw.Text("Largeur",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("Surface(mm²)+15%",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text("N de Trou",
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                            ],
                          )),
                      pw.Container(
                          width: 360,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 1, style: pw.BorderStyle.solid)),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text(selectedItems[0].nomPiece,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text(selectedItems[0].refrence,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 3.0),
                                height: 20,
                                child: pw.Text(selectedItems[0].codebar,
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      color: PdfColors.black,
                                    )),
                              ),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    height: 20,
                                    child: pw.Text(selectedItems[0].color,
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    height: 20,
                                    child: pw.Text("Electricite",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].electricite.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    height: 20,
                                    child: pw.Text(
                                        selectedItems[0].epaisseur.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text("Table de Coup",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].tableCoup.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].longueur.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text("Façonnage",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].faconnage.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].largeure.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text("Lavage",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].lavage.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        "${selectedItems[0].surface + (selectedItems[0].surface * 0.15)}",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text("Serigraphie",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].serigraphie.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                          bottom: pw.BorderSide(
                                              width: 1,
                                              color: PdfColors.black)))),
                              pw.Container(
                                  child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].trou.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text("Tremp",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                  pw.Container(
                                      height: 20,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                              left: pw.BorderSide(
                                                  width: 1,
                                                  color: PdfColors.black)))),
                                  pw.Container(
                                    width: 120,
                                    height: 20,
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
                                    child: pw.Text(
                                        selectedItems[0].tremp.toString(),
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          color: PdfColors.black,
                                        )),
                                  ),
                                ],
                              )),
                            ],
                          )),
                    ]),
              ),
              pw.SizedBox(height: 30),
              pw.Container(
                margin: pw.EdgeInsets.symmetric(horizontal: 60),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      child: pw.Text("Prix de vente : ",
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                          )),
                    ),
                    pw.Container(
                      child: pw.Text(
                          "${formatCurrency.format(selectedItems[0].prixVent)}",
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> pickFileXDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg'],
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        final bytes = file.bytes!;
        await uploadImageApi(bytes, selectedItems[0].id, file.name);
        initialize();
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }
}
