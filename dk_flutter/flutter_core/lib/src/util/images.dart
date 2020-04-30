import 'dart:typed_data';

import 'package:flutter/services.dart';

class DkImages {
   /// Load image as ByteData from assest.
   /// To handle with result, you maybe need some convertion to list of byte (uint8) like:
   /// `List<int> bytes = Uint8List.view(byteData.buffer);`
   Future<ByteData> loadAssets(String filePath) {
      return rootBundle.load(filePath);
   }
}
