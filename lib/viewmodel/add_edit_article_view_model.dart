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
  TextEditingController serviceController = TextEditingController();
  TextEditingController trouController = TextEditingController();
  TextEditingController PrixtrouController = TextEditingController();
  TextEditingController lavageController = TextEditingController();
  TextEditingController coutController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime createdAt = DateTime.now();

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
    serviceController.text = entity.service.toString();
    coutController.text = entity.cout.toString();
    trouController.text = entity.trou.toString();
    PrixtrouController.text = entity.prixTrou.toString();
    nameController.text = entity.name;
    createdAt = entity.createdAt;
  }

  @override
  void onInit() {
    super.onInit();
    super.validationProperties = [
      "name",
      "namePice",
      "color",
      "refrence",
      "epaisseur",
      "prix",
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
        prixVent: 0,
        cout: 0,
        service: 0,
        trou: 0,
        prixTrou: 0,
        createdAt: DateTime.now(),
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
    serviceController.text = temp.service.toString();
    coutController.text = temp.cout.toString();
    trouController.text = temp.trou.toString();
     PrixtrouController.text = temp.prixTrou.toString();
    nameController.text = temp.name;
    createdAt = temp.createdAt;
    return temp;
  }

  @override
  Future<bool> save() async {
    //fill properties
    surfaceController.text = (double.parse(largeureController.text) *
            double.parse(longueurController.text))
        .toString();
    entity.nomPiece = nomPieceController.text;
    entity.codebar = codeController.text;
    entity.color = colorController.text;
    entity.name = nameController.text;
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
    entity.cout = double.parse(coutController.text);
    entity.trou = double.parse(trouController.text);
    entity.prixTrou = double.parse(PrixtrouController.text);
    entity.serigraphie = double.parse(serigraphieController.text);
    entity.createdAt = createdAt;
    entity.prixVent =
        ((entity.surface + (entity.surface * 0.15)) * entity.cout) +
            entity.electricite +
            entity.faconnage +
            entity.lavage +
            entity.tremp +
            (entity.trou * entity.prixTrou) +
            entity.service +
            entity.serigraphie;
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
        return nomPieceController.text.isEmpty
            ? "Le nom est obligatoire"
            : null;
      case "namePice":
        return nomPieceController.text.isEmpty
            ? "Le nom de pice est obligatoire"
            : null;

      case "color":
        return colorController.text.isEmpty
            ? "La couleur est obligatoire"
            : null;
      case "refrence":
        return refrenceController.text.isEmpty
            ? "La référence est obligatoire"
            : null;
      case "epaisseur":
        return epaisseurController.text.isEmpty
            ? "Le epaisseur est obligatoire"
            : null;
      default:
        return null;
    }
  }
}
