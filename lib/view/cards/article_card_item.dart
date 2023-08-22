import 'dart:typed_data';

import 'package:abgtools/constant.dart';
import 'package:abgtools/core/card_Item.dart';
import 'package:abgtools/model/article_model.dart';
import 'package:abgtools/utils/service/artical_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ArticleInfoCardItem extends CardItem<ArticleModel> {
  ArticleInfoCardItem({required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Superficie 15%",
              style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
            ),
            Text(
              "${item.surface + (item.surface * 0.15)} mm²",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Frais de scolarité",
              style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
            ),
            Text(
              "${formatCurrency.format(prixvent)}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 150,
              child: TextFormField(
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
                controller: prixVentController,
                style: const TextStyle(fontSize: 13),
                keyboardType: TextInputType.number,
                autocorrect: false,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {
                changePrixVent();
              },
              child: Text(
                'modification',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.resolveWith(getPrimarColors),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 15))),
            ),
          ],
        )
      ],
    );
  }

  TextEditingController prixVentController = TextEditingController();
  late double prixvent;
  @override
  Future loadData() async {
    prixvent = ((item.surface + (item.surface * 0.15)) * item.cout) +
        item.electricite +
        item.faconnage +
        item.lavage +
        item.tremp +
        item.service +
        (item.trou * item.prixTrou) +
        item.serigraphie;
    prixVentController.text = item.prixVent.toString();
  }

  changePrixVent() async {
  
    item.prixVent = double.parse(prixVentController.text);
    await putArticleApi(item);
    loadData();
  }
}
