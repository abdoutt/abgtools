class FilterOption {
  int value;
  String name;
  bool isSelected = false;
  FilterOption({required this.name, required this.value, required this.isSelected});
}

class FilterDisplayItem {
  String group;
  String option;
  FilterDisplayItem({required this.group, required this.option});
}

class FilterGroup {
  String name;
  int? flags() {
    if (options.isEmpty) {
      return null;
    }
    var selected_options = options
        .where((element) => element.isSelected)
        .map((item) => item.value)
        .toList();
    return selected_options.isEmpty
        ? null
        : selected_options.reduce((value, current) => value + current);
  }

  List<FilterOption> options;
  FilterGroup({required this.name, required this.options});
}

class FilterArgs {
  String name;
  int? flags;
  FilterArgs({required this.name, required this.flags});
}
