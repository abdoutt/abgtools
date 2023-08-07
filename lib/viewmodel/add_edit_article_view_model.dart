import 'dart:async';

import 'package:abgtools/core/crud_view_model.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:abgtools/utils/service/artical_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class AddEditArticleViewModel extends CRUDViewModel<ArticleModel> {
  TextEditingController codeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController electriciteController = TextEditingController();
  TextEditingController epaisseurController = TextEditingController();
  TextEditingController faconnageController = TextEditingController();
  TextEditingController largeureController = TextEditingController();
  TextEditingController longueurController = TextEditingController();
  TextEditingController nomPieceController = TextEditingController();
  TextEditingController refrenceController = TextEditingController();
  TextEditingController serigraphieController = TextEditingController();
  TextEditingController surfaceController = TextEditingController();
  TextEditingController tableCoupController = TextEditingController();
  TextEditingController trempController = TextEditingController();
  TextEditingController lavageController = TextEditingController();


  AddEditArticleViewModel(super.t, super.e, super.p) {
    nomPieceController.text = entity.nomPiece;
    codeController.text = entity.codebar;
    colorController.text = entity.color;
    refrenceController.text = entity.refrence;
    electriciteController.text = entity.electricite.toString();
    epaisseurController.text = entity.epaisseur.toString();
    largeureController.text = entity.largeure.toString();
    longueurController.text = entity.longueur.toString();
    surfaceController.text = entity.surface.toString();
    tableCoupController.text = entity.tableCoup.toString();
    faconnageController.text = entity.faconnage.toString();
    lavageController.text = entity.lavage.toString();
    serigraphieController.text = entity.serigraphie.toString();
    trempController.text = entity.tremp.toString();
  }

  @override
  void onInit() {
    super.onInit();
    super.validationProperties = [
      "name",
      "code",
      "color",
      "refrence",
      "epaisseur",
    ];
  }

  @override
  ArticleModel prepareNewItem() {
    var temp = ArticleModel(
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
                        tremp: 0);
    //re-initialize controller
    nomPieceController.text = temp.nomPiece;
    codeController.text = temp.codebar;
    colorController.text = temp.color;
    refrenceController.text = temp.refrence;
    electriciteController.text = temp.electricite.toString();
    epaisseurController.text = temp.epaisseur.toString();
    largeureController.text = temp.largeure.toString();
    longueurController.text = temp.longueur.toString();
    surfaceController.text = temp.surface.toString();
    tableCoupController.text = temp.tableCoup.toString();
    faconnageController.text = temp.faconnage.toString();
    lavageController.text = temp.lavage.toString();
    serigraphieController.text = temp.serigraphie.toString();
    trempController.text = temp.tremp.toString();
    return temp;
  }

  @override
  Future<bool> save() async {
    //fill properties
    entity.nomPiece = nomPieceController.text;
    entity.codebar = codeController.text;
    entity.color = colorController.text;
    entity.electricite = double.parse(electriciteController.text);
    entity.refrence = refrenceController.text;
    entity.faconnage = double.parse(faconnageController.text);
    entity.epaisseur = double.parse(epaisseurController.text);
    entity.largeure = double.parse(largeureController.text);
    entity.longueur = double.parse(longueurController.text);
    entity.lavage = double.parse(lavageController.text);
    entity.surface = double.parse(surfaceController.text);
    entity.tableCoup = double.parse(tableCoupController.text);
    entity.tremp = double.parse(trempController.text);

    //Todo save API methodes
    try {
      var id = entity.id == 0
          ? await postArticleApi(entity)
          : await putArticleApi(entity);
      if (id > 0) {
        entity.id = id;
        return true;
      }
      return false;
    } on NotifyException catch (e) {
      e.errorMessage();
      return false;
      // validateField(e.toString());
    } on UnauthorizedException catch (e) {
      //fix UnauthorizedException
      Get.snackbar(
        "",
        e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: 300,
      );
      return false;
    } on TimeoutException catch (e) {
      return false;
    } catch (e) {
      return false;
    } // save item in API
  }

  @override
  String? validateField(String propertyName) {
    switch (propertyName) {
      case "name":
        return nomPieceController.text.isEmpty ? "الاسم اجباري" : null;

      case "code":
        return codeController.text.isEmpty ? "كودبار اجباري" : null;

          case "color":
        return colorController.text.isEmpty ? "اللون اجباري" : null;
          case "refrence":
        return refrenceController.text.isEmpty ? "المرجع اجباري" : null;
          case "epaisseur":
        return epaisseurController.text.isEmpty ? "السمك" : null;
      default:
        return null;
    }
  }
}