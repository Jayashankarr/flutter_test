import 'package:flutter/foundation.dart';

class SubmitRecipePageModel with ChangeNotifier {
  SubmitRecipePageModel();

  /// Title
  String _title;
  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }
}
