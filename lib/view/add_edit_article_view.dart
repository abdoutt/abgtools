import 'package:abgtools/constant.dart';
import 'package:abgtools/core/crud_view.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/reponsiveness.dart';
import 'package:abgtools/viewmodel/add_edit_article_view_model.dart';
import 'package:abgtools/viewmodel/homeViewModel.dart';
import 'package:abgtools/widgets/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditArticleView extends CRUDView<AddEditArticleViewModel> {
  AddEditArticleView(
      {super.key,
      required String title,
      required ArticleModel entity,
      HomeViewModel? p}) {
    super.crudViewModel = AddEditArticleViewModel(title, entity, p);
  }

  @override
  Widget buildContent(BuildContext context) {
    return Form(
        key: super.crudViewModel.formKey,
        child: Column(
          mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Informations de base",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: secondColor75),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    "Nom de la voiture",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: secondColor75),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: 10,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: secondColor7,
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
              ),
              controller: super.crudViewModel.nameController,
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.text,
              autocorrect: false,
              validator: (val) => super.crudViewModel.validateField("name"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Nom de la pièce",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.nomPieceController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("namePice"),
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Date de création",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      DatePikerWidget(
                              onSelectionChanged: (val) {
                                super.crudViewModel.createdAt = val!;
                              },
                              waterMark: "",
                              val: super.crudViewModel.createdAt)
                          .view,
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Référence",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.refrenceController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("refrence"),
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "code à barre",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.codeController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid))),
            ),
            Row(
              children: [
                Text(
                  "Coût d'achat",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: secondColor75),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "la couleur",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.colorController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("color"),
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Epaisseur",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.epaisseurController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("epaisseur"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    "le coût",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: secondColor75),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: 10,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: secondColor7,
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
              ),
              controller: super.crudViewModel.coutController,
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
              autocorrect: false,
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid))),
            ),
            Row(
              children: [
                Text(
                  "Les informations sont personnalisées",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: secondColor75),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Longueur",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.longueurController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        onChanged: (Value) {
                          super.crudViewModel.surfaceController.text =
                              (double.parse(super
                                          .crudViewModel
                                          .largeureController
                                          .text) *
                                      double.parse(super
                                          .crudViewModel
                                          .longueurController
                                          .text))
                                  .toString();
                        },
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "Largeure",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.largeureController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        onChanged: (Value) {
                          super.crudViewModel.surfaceController.text =
                              (double.parse(super
                                          .crudViewModel
                                          .largeureController
                                          .text) *
                                      double.parse(super
                                          .crudViewModel
                                          .longueurController
                                          .text))
                                  .toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    "Surface",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: secondColor75),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: 10,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: secondColor7,
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
              ),
              controller: super.crudViewModel.surfaceController,
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
              autocorrect: false,
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid))),
            ),
            Row(
              children: [
                Text(
                  "les frais généraux",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: secondColor75),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "ُElectricité",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: secondColor75),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.electriciteController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Façonnage",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.faconnageController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Table de Coup",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.tableCoupController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Lavage",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.lavageController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Sérigraphie",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.serigraphieController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Service",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.serviceController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "Termp",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.trempController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
                ResponsiveWidget.isSmallScreen(context)
                    ? SizedBox(
                        width: 5,
                      )
                    : SizedBox(
                        width: 20,
                      ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "N de Trou",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: secondColor75),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide(
                              color: secondColor7,
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
                        ),
                        controller: super.crudViewModel.trouController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                    child: Text(
                      "Prix de trou",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: secondColor75),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: 10,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: secondColor7,
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
              ),
              controller: super.crudViewModel.PrixtrouController,
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
              autocorrect: false,
            ),
          ],
        ));
  }
}
