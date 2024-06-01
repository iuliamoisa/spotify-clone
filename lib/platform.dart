import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

extension PlatformInfo on Object {
  bool isAndroid() {
    return Platform.isAndroid;
  }

  bool isWeb() {
    return kIsWeb;
  }
}
