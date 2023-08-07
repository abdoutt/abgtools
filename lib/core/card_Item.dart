
import 'package:abgtools/core/iidentity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constant.dart';

abstract class CardItem<T extends IIdentity> extends GetxController {
  late CardItemView<T> view;
  CardItem({
    required this.title,
  }) {
    view = CardItemView(
      cardItem: this,
    );
  }

  String title;
  late T item;
  RxBool isBusy = true.obs;
  Widget buildContent(BuildContext context);

  void loadCard(T i) async {
    try {
      beforeLoad();
      isBusy.value = true;
      item = i;
      await loadData();
      afterLoad();
    } catch (e) {
    } finally {
      isBusy.value = false;
    }
  }

  Future loadData();
  void beforeLoad() {}
  void afterLoad() {}
  bool validateFilter(String filter) {
    return title.contains(filter);
  }
}

class CardItemView<T extends IIdentity> extends StatelessWidget {
  CardItem<T> cardItem;
  CardItemView({super.key, required this.cardItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(
            color: secondColor7,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
          color: secondColor3),
      child: Column(
        children: [
          cardItem.title.isEmpty
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 5.0),
                      child: Text(
                        cardItem.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: secondColor,
                            fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
          Obx(() => cardItem.isBusy.value
              ? const SpinKitCircle(
                  color: Colors.amber,
                  size: 30.0,
                )
              : Container(
                  child: cardItem.buildContent(context),
                )),
        ],
      ),
    );
  }
}
