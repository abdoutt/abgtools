
import 'package:abgtools/core/iidentity.dart';
import 'package:abgtools/core/practices_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CRUDViewModel<T extends IIdentity> extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool closeAfterSave = true.obs;
  String title = "Title";
  late T entity;
  PracticesViewModel<T>? parent;
  List<String> validationProperties = [];
  CRUDViewModel(String t, T e, PracticesViewModel<T>? p) {
    title = t;
    entity = e;
    parent = p;
  }

  @protected
  void internalSave() async {
    if (formKey.currentState!.validate()) {
      bool result = await save();
      if (result && parent != null) {
        parent!.onItemSaved(entity);
      }
      //Close Dialog After Save
      if (result && closeAfterSave.value) {
        close();
      }
      return;
    }
  }

  Future<bool> save();

  @protected
  void internalCreateNew() {
    entity = prepareNewItem();
  }

  T prepareNewItem();

  void cancel() {
    close();
  }

  void close() {
    Get.back();
  }

  String? validateField(String propertyName);
}
