
import 'package:blessmate/language/ar.dart';
import 'package:blessmate/language/en.dart';
import 'package:get/get.dart';

class Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar,
  };

}