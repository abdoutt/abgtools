
import 'package:abgtools/core/practices_view_model.dart';
import 'package:abgtools/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant.dart';
import '../utils/helpers/reponsiveness.dart' as res;

class PracticesDetailView<P extends PracticesViewModel>
    extends StatelessWidget {
  PracticesDetailView({super.key, required this.practicesViewModel});
  late P practicesViewModel;
  Widget build(BuildContext context) {
    if (!res.ResponsiveWidget.isSmallScreen(context)) {
       Get.back();
    }
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          centerTitle: true,
          leading: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                disabledForegroundColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              icon:  Image.asset(
                      "assets/icons/popup-arow.png",
                      width: 25,
                      height: 25,
                      color: secondColor,
                    ),
                  
              onPressed: () {
                Get.back();
              }),
          title: Text(
            practicesViewModel.Title(),
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: secondColor),
          ),
          iconTheme: const IconThemeData(color: secondColor),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      
        body: Obx(() => Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hoverColor: secondColor7,
                                filled: true,
                                hintText: 'main_serche'.tr,
                                counter: const SizedBox.shrink(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10.0),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: secondColor50,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                  borderSide: BorderSide(
                                    color: secondColor20,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                    borderSide: BorderSide(
                                      color: secondColor7,
                                      width: 2.0,
                                    )),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: IconButtonCustom(
                                    mainColors: Colors.transparent,
                                    activeColors: Colors.transparent,
                                    hoverColors: Colors.transparent,
                                    iconName: "searchbyfilter.png",
                                    height: 30,
                                    width: 30,
                                    onPressed: () {
                                      practicesViewModel
                                          .onFilterDetailChanged();
                                    },
                                    raduiseButton: 4,
                                  ),
                                )),
                            controller: practicesViewModel.filterDetail,
                            onFieldSubmitted: (value) {
                              practicesViewModel.onFilterDetailChanged();
                            },
                            onChanged: (val) =>
                                practicesViewModel.onFilterDetailChanged(),
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: practicesViewModel.displayCards.length,
                          itemBuilder: ((context, index) {
                            return practicesViewModel.displayCards[index].view;
                          })),
                    ),
                  ],
                ),
              ),
            )));
  }
}
