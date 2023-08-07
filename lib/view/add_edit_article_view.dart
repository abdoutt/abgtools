
import 'package:abgtools/constant.dart';
import 'package:abgtools/core/crud_view.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/helpers/reponsiveness.dart';
import 'package:abgtools/viewmodel/add_edit_article_view_model.dart';
import 'package:abgtools/viewmodel/homeViewModel.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                  child: Text(
                    "اسم الجزء",
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
                    vertical: 10,
                    horizontal: 10.0),
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
              keyboardType: TextInputType.emailAddress,
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 7.0, bottom: 7.0),
                              child: Text(
                                "كودبار",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("code"),
                      ),
                      
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "اللون",
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
                              vertical:10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("color"),
                      ),
                     
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "المرجع",
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
                              vertical:10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("refrence"),
                      ),
                      
                     
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "الطول",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("الطول"),
                      ),
                      //fax
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "العرض",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("العرض"),
                      ),
                     
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "السطح".tr,
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("السطح"),
                      ),
                   
                    ],
                  ),
                ),
                SizedBox(
                  width: ResponsiveWidget.isSmallScreen(context) ? 10 : 50.0,
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
                              "الكهرباء".tr,
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("الكهرباء"),
                      ),
                   
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "تشكيل",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        controller:
                            super.crudViewModel.faconnageController,
                        style: const TextStyle(fontSize: 13),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        validator: (val) => super
                            .crudViewModel
                            .validateField("تشكيل"),
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "غسل",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("غسل"),
                      ),
                   
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "طاولة الركلة",
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
                              vertical:10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("طاولة الركلة"),
                      ),
                      //bankNumber
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7.0, bottom: 7.0),
                              child: Text(
                                "طباعة الشاشة",
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
                              vertical: 10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("طباعة الشاشة"),
                      ),
                     
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 7.0, bottom: 7.0),
                            child: Text(
                              "السمك".tr,
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
                              vertical:10,
                              horizontal: 10.0),
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
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (val) =>
                            super.crudViewModel.validateField("epaisseur"),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
         
          ],
        ));
  }
}
