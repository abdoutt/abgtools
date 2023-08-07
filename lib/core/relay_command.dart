import 'package:flutter/foundation.dart';

class RelayCommand {
  int key;
  String value;
  bool canExecuteValue = true;
  Function canExecute;
  Function execute;
  RelayCommand(this.key, this.value, this.canExecute, this.execute) {
    callCanExecute();
  }

  @protected
  callCanExecute() {
    canExecuteValue = canExecute.call();
  }
}
