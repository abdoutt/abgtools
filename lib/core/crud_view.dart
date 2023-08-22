
import 'package:abgtools/constant.dart';
import 'package:abgtools/core/crud_view_model.dart';
import 'package:abgtools/utils/helpers/reponsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class CRUDView<T extends CRUDViewModel> extends StatelessWidget {
  CRUDView({super.key});
  late T crudViewModel;
  Widget buildContent(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.all(0)
          : EdgeInsets.all(8.0),
      constraints: const BoxConstraints(minWidth: 450, minHeight: 250),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      crudViewModel.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Theme(
                      data: ThemeData(
                        useMaterial3: true,
                         fontFamily: 'NotoKufiArabic',
                      ),
                      child: IconButton(
                        onPressed: () {
                          crudViewModel.close();
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          disabledForegroundColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        icon: Image.asset("assets/images/close.png",
                            width: 25, height: 25),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: MediaQuery.of(context).size.height / 1.7),
                  child: SingleChildScrollView(child: buildContent(context)),
                ),
              ],
            ),
            Flex(
              direction: ResponsiveWidget.isSmallScreen(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Obx(() => Expanded(
                      flex: ResponsiveWidget.isSmallScreen(context) ? 0 : 1,
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: primaryColor,
                            value: crudViewModel.closeAfterSave.value,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            onChanged: (value) {
                              crudViewModel.closeAfterSave.value = value!;
                            },
                          ),
                          Text(
                            "Fermer après avoir enregistré",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13.0),
                          )
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          crudViewModel.cancel();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(secondColor3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Annulation",
                            style: TextStyle(
                                color: secondColor75,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                        onPressed: () {
                          crudViewModel.internalCreateNew();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(primaryColor10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Créer un nouveau",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                      onPressed: () {
                        crudViewModel.internalSave();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(primaryColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Enregistrer",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
