part of filers;

extension FileExtention on FileSystemEntity {
  String get fileNameWithExtension {
    return this?.path?.split('/')?.last;
  }

  // -----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split('.')?.last;
  }
}

class ObjectCheck {
  // -----------------------------------------------------------------------------

  const ObjectCheck();

  // -----------------------------------------------------------------------------

  /// EXTENSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String fileExtensionOf(dynamic file) {

    if (file == null){
      return null;
    }
    else if (file is String){
      return File(file).fileExtension;
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isAbsoluteURL(dynamic object) {
    bool _isValidURL = false;

    if (object != null && object is String) {
      final String _url = object.trim();

      tryAndCatch(
        functions: () {
          final parsedUri = Uri.parse(_url);
          _isValidURL = parsedUri.isAbsolute;
        },
      );
    }

    return _isValidURL;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool isURLFormat(dynamic object) {

    bool _isURLFormat = false;

    if (object != null && object is String) {

      final RegExp regExp = RegExp(TextCheck.urlPattern);
      _isURLFormat = regExp.hasMatch(object);

    }

    return _isURLFormat;
  }
  // -----------------------------------------------------------------------------

  /// BYTES HOLDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isBase64(dynamic value) {

    if (value is String == true) {

      final RegExp rx = RegExp(
          r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$',
          multiLine: true,
          unicode: true);

      final bool isBase64Valid = rx.hasMatch(value);

      if (isBase64Valid == true) {
        return true;
      }

      else {
        return false;
      }

    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsFile(dynamic file) {
    bool _isFile = false;

    if (file != null) {

      final bool isFileA = file is File;
      final bool isFileB = file.runtimeType.toString() == '_File';

      if (isFileA == true || isFileB == true) {
        _isFile = true;
      }

    }

    else {
      blog('objectIsFile : isFile : null');
    }

    return _isFile;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUint8List(dynamic object) {
    bool _isUint8List = false;

    if (object != null) {
      if (
          object is Uint8List
          ||
          object.runtimeType.toString() == '_Uint8ArrayView'
          ||
          object.runtimeType.toString() == 'Uint8List'
      ) {
        _isUint8List = true;
      }
    }

    return _isUint8List;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsSVG(dynamic object) {
    bool _isSVG = false;

    if (fileExtensionOf(object) == 'svg') {
      _isSVG = true;
    }

    else {
      _isSVG = false;
    }

    return _isSVG;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsJPGorPNG(dynamic object) {
    bool _objectIsJPGorPNG = false;

    if (object != null){
      if (
          fileExtensionOf(object) == 'jpeg'
          ||
          fileExtensionOf(object) == 'jpg'
          ||
          fileExtensionOf(object) == 'png'
      ) {
        _objectIsJPGorPNG = true;
      }

      else {
        _objectIsJPGorPNG = false;
      }

    }

    return _objectIsJPGorPNG;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUiImage(dynamic object){
    bool _isUiImage = false;

    if (object != null){

      if (object is ui.Image){
        _isUiImage = true;
      }

    }

    return _isUiImage;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsImgImage(dynamic object){
    bool _isImgImage = false;

    if (object != null){

      if (object is img.Image){
        _isImgImage = true;
      }

    }

    return _isImgImage;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsPicPath(dynamic object){
    bool _isPicPath = false;

    if (object != null && object is String){

      final bool isURL = ObjectCheck.isAbsoluteURL(object);
      final bool isRaster = ObjectCheck.objectIsJPGorPNG(object);
      final bool isSVG = ObjectCheck.objectIsSVG(object);
      final bool isBase64 = ObjectCheck.isBase64(object);

      if (isURL == true || isRaster == true || isSVG == true || isBase64 == true){
        _isPicPath = false;
      }

      else {
        _isPicPath = true;
      }

    }

    return _isPicPath;
  }
  // -----------------------------------------------------------------------------

  /// NUMERALS - STRINGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> objectIsIntInString(BuildContext context, dynamic string) async {
    bool _objectIsIntInString = false;
    int _int;

    if (string != null) {
      _int = int.tryParse(string.trim());
    }

    if (_int == null) {
      _objectIsIntInString = false;
    }

    else {
      _objectIsIntInString = true;
    }

    return _objectIsIntInString;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsDoubleInString(dynamic string) {
    bool _objectIsDoubleInString = false;
    double _double;

    if (string != null) {
      _double = double.tryParse(string.trim());
    }

    if (_double == null) {
      _objectIsDoubleInString = false;
    }

    else {
      _objectIsDoubleInString = true;
    }

    return _objectIsDoubleInString;
  }
  // -----------------------------------------------------------------------------

  /// NUMERALS - STRINGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsDateTime(dynamic object) {
    return object?.runtimeType == DateTime;
  }
  // -----------------------------------------------------------------------------
}
