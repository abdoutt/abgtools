
import 'package:abgtools/core/base_getx_controller.dart';
import 'package:abgtools/core/card_Item.dart';
import 'package:abgtools/core/filter_liste.dart';
import 'package:abgtools/core/filter_option.dart';
import 'package:abgtools/core/iidentity.dart';
import 'package:abgtools/core/practices_data_grid_source.dart';
import 'package:abgtools/core/practices_detail_view.dart';
import 'package:abgtools/core/relay_command.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../utils/helpers/reponsiveness.dart' as res;
abstract class PracticesViewModel<T extends IIdentity>
    extends BaseGetxController {
  final filter = TextEditingController();
  final filterDetail = TextEditingController();

  List<T> source = [];
  int pageSize = 50;
  late int pageSizeGride;
  late int currentPage;
  late RxInt totalPages = 0.obs;
  late int totalItems;
  late RxList actionsCommands = [].obs;
  late RxList printCommands = [].obs;
  late List filters;
  late List<FilterList> activeFilter;
  RxBool sideView = false.obs;
  RxBool selected = false.obs;
  T? selectedCard;
  late PracticesDataGridSource<T> dataGridSource;
  RxBool loading = false.obs;
  RxBool listDisplay = false.obs;
  RxBool refreshFilterManger = false.obs;
  bool cardIsInitialized = false;
  late List<int> pages;
  RxList<T> selectedItems = <T>[].obs;
  int xs = 12;
  int sm = 12;
  int? md = 6;
  int? lg = 4;
  int? xl = 2;

  late String _TitleKey;
  late String _DescriptionKey;
  //PracticesInfo info;
  late BuildContext context;
  List<CardItem<T>> cards = [];
  RxList<FilterGroup> filterManger = <FilterGroup>[].obs;
  RxList displayCards = [].obs;
  PracticesViewModel({
    required String titleKey,
  }) {
    _TitleKey = titleKey;
    _DescriptionKey = "${titleKey}_description";
    dataGridSource = PracticesDataGridSource<T>(parent: this);
    currentPage = 1;
    totalPages.value = 1;
    pageSizeGride = 0;
    totalItems = 0;
    isBusy.value = false;
    loading.value = false;
    refreshFilterManger.value = false;
    listDisplay.value = true;
    //filters = getFilterList();
    activeFilter = [];
    initializeFilter();
    initialize();
  }
  @override
  void onInit() {
    super.onInit();
  }
//permission == ''
  addActionCommand(RelayCommand command, [String? permission = ""]) {
    if (permission == null ) {// || !hasPermission(permission)
      return;
    }
    actionsCommands.add(command);
  }

  addPrintCommand(RelayCommand command, [String? permission = ""]) {
    if (permission == null ) { // || !hasPermission(permission)
      return;
    }
    printCommands.add(command);
  }

  String Title() {
    return _TitleKey.tr;
  }

  String Description() {
    return _DescriptionKey.tr;
  }

  openDetail(T item) {
    if (cards.isEmpty && !cardIsInitialized) {
      initializeCards();
      cardIsInitialized = true;
    }
    if (cards.isNotEmpty) {
      for (var card in cards) {
        card.loadCard(item);
      }
    }
    displayCards.value = cards
        .where((element) => element.validateFilter(filterDetail.text))
        .toList();

    if (!res.ResponsiveWidget.isSmallScreen(context)) {
      sideView.value = true;
    } else {
      Get.to(PracticesDetailView(practicesViewModel: this));
    }
  }

  closeDetail() {
    sideView.value = false;
  }

  onSelectedChanged(List<dynamic> added, List<dynamic> removed) {
    //remove existing items
    if (removed != null && removed.length > 0) {
      for (var i = 0; i < removed.length; i++) {
        if (selectedItems.contains(removed[i])) {
          selectedItems.remove(removed[i]);
        }
      }
    }

    //add the new items
    if (added.length > 0) {
      for (var i = 0; i < added.length; i++) {
        if (!selectedItems.contains(added[i])) {
          selectedItems.add(added[i]);
        }
      }
    }

    //raise all actions and print commands for change enable execute
    var tempActions = actionsCommands.value;
    tempActions.forEach((element) {
      element.callCanExecute();
    });
    actionsCommands.value = [];
    actionsCommands.value = tempActions;

    var tempPrints = printCommands.value;
    tempPrints.forEach((element) {
      element.callCanExecute();
    });
    printCommands.value = [];
    printCommands.value = tempPrints;
  }

  onItemSaved(T item) {
    initialize();
  }

  removeFilterPart(String group) {
    filterManger
        .where((p0) => p0.name == group)
        .first
        .options
        .forEach((element) {
      element.isSelected = false;
    });
    initialize();
  }

  Future initialize() async {
    loading.value = true;
    //? reinitialize actions
    selectedItems.value = [];
    var tempActions = actionsCommands.value;
    tempActions.forEach((element) {
      element.callCanExecute();
    });
    actionsCommands.value = [];
    actionsCommands.value = tempActions;

    //? reinitialize printer
    var tempPrints = printCommands.value;
    tempPrints.forEach((element) {
      element.callCanExecute();
    });
    printCommands.value = [];
    printCommands.value = tempPrints;

    var temp = filterManger.value;
    filterManger.value = <FilterGroup>[].obs;
    filterManger.value = temp;

    totalItems = await getCount(
        filter.text,
        filterManger.isEmpty
            ? []
            : filterManger
                .map((e) => FilterArgs(name: e.name, flags: e.flags()))
                .toList());
    loading.value = false;

    load();
  }

  addNewFillter(int j, int) {}

  load() async {
    APIInvoke(() async {
      if (totalItems > 0) {
        totalPages.value = (totalItems / pageSize).ceil().toInt();
        source = await getPage(
            filter.text,
            filterManger.isEmpty
                ? []
                : filterManger
                    .map((e) => FilterArgs(name: e.name, flags: e.flags()))
                    .toList(),
            currentPage,
            pageSize);
      } else {
        source = [];
      }
      dataGridSource = PracticesDataGridSource<T>(parent: this);
    });
  }

  void initializeCards();
  void initializeFilter();

  bool getLengthFilterActive(List<FilterOption> item) {
    int count = 0;
    for (var i = 0; i < item.length; i++) {
      if (item[i].isSelected) {
        count = count + 1;
      }
    }
    if (count != 0) {
      return true;
    } else {
      return false;
    }
  }

  onFilterDetailChanged() {
    displayCards.value = cards
        .where((element) => element.validateFilter(filterDetail.text))
        .toList();
  }

  changeFilter(int j, bool value) {
    for (var i = 0; i < filters.length; i++) {
      filters[i].active = false;
    }
    filters[j].active = value;
  }

  changeView(bool activeListe) {
    if (activeListe != listDisplay.value) {
      listDisplay.value = !listDisplay.value;
    }
  }

  changerPerPage(int itemsPerPage) {
    pageSize = itemsPerPage;
    currentPage = 1;
    load();
  }

  clearFilter() {
    filter.text = '';
  }

  Future<int> getCount(String q, List<FilterArgs> filterArgs);

  Future<List<T>> getPage(String filter, List<FilterArgs> filterArgs,
      int currentPage, int pageSize);
  List<Widget> buildRow(DataGridRow row);
}
