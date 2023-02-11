part of filers;

class Filers {
  // -----------------------------------------------------------------------------

  const Filers();

  // -----------------------------------------------------------------------------

  /// CREATORS - WRITING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> createNewEmptyFile({
    @required String fileName,
    /// APP DIRECTORY
    /// /data/user/0/com.bldrs.net/app_flutter/{fileName}
    /// TEMPORARY DIRECTORY
    /// /data/user/0/com.bldrs.net/cache/{fileName}
    bool useTemporaryDirectory = true,
  }) async {

    final String _filePath = await createNewFilePath(
      fileName: fileName,
      useTemporaryDirectory: useTemporaryDirectory,
    );

    return File(_filePath);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> writeUint8ListOnFile({
    @required File file,
    @required Uint8List uint8list,
  }) async {
    await file.writeAsBytes(uint8list);
    await file.create(recursive: true);
    return file;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> writeBytesOnFile({
    @required File file,
    @required ByteData byteData,
  }) async {
    File _file;

    if (file != null && byteData != null) {
      final Uint8List _uInts = Floaters.getUint8ListFromByteData(byteData);
      _file = await writeUint8ListOnFile(file: file, uint8list: _uInts);
    }

    return _file;
  }
  // --------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */
  // -----------------------------------------------------------------------------

  /// FILE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> createNewFilePath({
    @required String fileName,
    bool useTemporaryDirectory = true,
  }) async {

    final Directory _appDocDir = useTemporaryDirectory ?
    await getTemporaryDirectory()
        :
    await getApplicationDocumentsDirectory();


    return '${_appDocDir.path}/$fileName';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFileNameFromFile({
    @required File file,
    @required bool withExtension,
  }){
    String _fileName;

    if (file != null){
      final String _path = file.path;
      _fileName = TextMod.removeTextBeforeLastSpecialCharacter(_path, '/');


      if (withExtension == false){
        _fileName = TextMod.removeTextAfterLastSpecialCharacter(_fileName, '.');
      }

    }

    return _fileName;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getFilesNamesFromFiles({
    @required List<File> files,
    @required bool withExtension,
  }) async {

    final List<String> _names = <String>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final File _file in files){

        final String _name = getFileNameFromFile(
          file: _file,
          withExtension: withExtension,
        );

        _names.add(_name);

      }

    }

    return _names;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFileExtensionFromFile(File file){

    ///  NOTE 'jpg' - 'png' - 'pdf' ... etc => which does not include the '.'
    String _fileExtension;

    if (file != null){

      /// '.jpg' - '.png' '.pdf'
      final String _dotExtension = extension(file.path);

      /// 'jpg' - 'png' 'pdf'
      _fileExtension = TextMod.removeTextBeforeLastSpecialCharacter(_dotExtension, '.');

    }

    return _fileExtension;
  }
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFileSizeInMb(File file){

    return getFileSizeWithUnit(
      file: file,
      unit: FileSizeUnit.megaByte,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFileSizeWithUnit({
    @required File file,
    @required FileSizeUnit unit,
    int fractionDigits = 1,
  }){
      double _output;

      if (file != null){

        final int _bytes = file.lengthSync();

        _output = calculateSize(_bytes, unit);

        _output = Numeric.roundFractions(_output, fractionDigits);

      }

      return _output;
    }
  // --------------------
  /// TESTED : WORKS PERFECT
    static double calculateSize(int bytes, FileSizeUnit unit){

    double _size;

      if (bytes != null){
        switch (unit){
          case FileSizeUnit.byte:      _size = bytes.toDouble(); break;
          case FileSizeUnit.kiloByte:  _size = bytes / 1024; break;
          case FileSizeUnit.megaByte:  _size = bytes/ (1024 * 1024); break;
          case FileSizeUnit.gigaByte:  _size = bytes/ (1024 * 1024 * 1024); break;
          case FileSizeUnit.teraByte:  _size = bytes/ (1024 * 1024 * 1024 * 1024); break;
          default:                     _size = bytes.toDouble(); break;
        }
      }

      return Numeric.roundFractions(_size, 2);
    }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// LOCAL RASTER ASSET
  // ---------------------

  // --------------------
  /// Uint8List
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromUint8List({
    @required Uint8List uInt8List,
    @required String fileName,
  }) async {

    if (uInt8List != null){
      final File _file = await createNewEmptyFile(
        fileName: fileName,
      );

      final File _result = await writeUint8ListOnFile(
        uint8list: uInt8List,
        file: _file,
      );

      return _result;

    }

    else {
      return null;
    }


  }
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>> getFilesFromUint8Lists({
    @required List<Uint8List> uInt8Lists,
    @required List<String> filesNames,
  }) async {
    final List<File> _output = <File>[];

    if (Mapper.checkCanLoopList(uInt8Lists) == true){

      for (int i = 0; i < uInt8Lists.length; i++){

        final File _file = await getFileFromUint8List(
          uInt8List: uInt8Lists[i],
          fileName: filesNames[i],
        );

        if (_file != null){
          _output.add(_file);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// ImgImage
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromImgImage({
    @required img.Image imgImage,
    @required String fileName,
  }) async {

    File file;

    if (imgImage != null){

      final Uint8List _uIntAgain = Floaters.getUint8ListFromImgImage(imgImage);

      file = await Filers.getFileFromUint8List(
        uInt8List: _uIntAgain,
        fileName: fileName,
      );

    }

    return file;
  }
  // --------------------
  /// URL
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromURL(String url) async {
    File _file;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      /// call http.get method and pass imageUrl into it to get response.
      final http.Response _response = await Rest.get(
        context: null,
        rawLink: url,
        // timeout: 60,
        invoker: 'getFileFromURL',
      );

      if (_response != null && _response.statusCode == 200){

        /// generate random number.
        final Random _rng = Random();
        // blog('getFileFromURL : _rng : $_rng');

        /// get temporary directory of device.
        final Directory _tempDir = await getTemporaryDirectory();
        // blog('getFileFromURL : _tempDir : $_tempDir');

        /// get temporary path from temporary directory.
        final String _tempPath = _tempDir.path;
        // blog('getFileFromURL : _tempPath : $_tempPath');

        /// create a new file in temporary path with random file name.
        _file = File('$_tempPath${_rng.nextInt(100)}'); // .png');
        // blog('getFileFromURL : _file : $_file');


        /// write bodyBytes received in response to file.
        await _file.writeAsBytes(_response.bodyBytes);
        // blog('getFileFromURL : BYTES WRITTEN ON FILE --------- END');

        /// now return the file which is created with random name in
        /// temporary directory and image bytes from response is written to // that file.

      }

    }

    return _file;
  }
  // --------------------
  /// BASE 64
  // ---------------------
  static Future<File> getFileFromBase64(String base64) async {

    final Uint8List _fileAgainAsInt = base64Decode(base64);
    // await null;

    final File _fileAgain = await getFileFromUint8List(
      uInt8List: _fileAgainAsInt,
      fileName: '${Numeric.createUniqueID()}',
    );

    return _fileAgain;
  }
  // --------------------
  /// DYNAMICS
  // ---------------------
  static Future<File> getFileFromDynamics(dynamic pic) async {
    File _file;

    if (pic != null) {
      if (ObjectCheck.objectIsFile(pic) == true) {
        _file = pic;
      }
      // else if (ObjectChecker.objectIsAsset(pic) == true) {
      //   _file = await getFileFromPickerAsset(pic);
      // }
      else if (ObjectCheck.isAbsoluteURL(pic) == true) {
        _file = await getFileFromURL(pic);
      }
      else if (ObjectCheck.objectIsJPGorPNG(pic) == true) {
        // _file = await getFile
      }
    }

    return _file;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFilesAreIdentical({
    @required File file1,
    @required File file2,
    String invoker = 'checkFilesAreIdentical',
  }) {
    bool _identical = false;

    if (file1 == null && file2 == null){
      _identical = true;
    }
    else if (file1 != null && file2 != null){
      if (file1.path == file2.path){
        if (file1.lengthSync() == file2.lengthSync()){
          if (file1.resolveSymbolicLinksSync() == file2.resolveSymbolicLinksSync()){

            final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
                accuracy: TimeAccuracy.microSecond,
                time1: file1.lastModifiedSync(),
                time2: file2.lastModifiedSync()
            );

            if (_lastModifiedAreIdentical == true){
              _identical = true;
            }

          }
        }
      }
    }

    if (_identical == false){
      blogFilesDifferences(
        file1: file1,
        file2: file2,
      );
    }

    return _identical;
  }
  // --------------------
  /*
    static bool checkFileSizeIsBiggerThan({
      @required File file,
      @required double megaBytes,
    }){
      bool _bigger = false;

      if (file != null && megaBytes != null){

        final double fileSize = getFileSize(file);

          _bigger = fileSize > megaBytes;

      }

      return _bigger;
    }
   */
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFile({
    @required File file,
    String invoker = 'BLOG FILE',
  }){

    if (file == null){
      blog('blogFile : file is null');
    }
    else {

      blog('blogFile : $invoker : file.path : ${file.path}');
      blog('blogFile : $invoker : file.absolute : ${file.absolute}');
      blog('blogFile : $invoker : file.fileNameWithExtension : ${file.fileNameWithExtension}');
      blog('blogFile : $invoker : file.runtimeType : ${file.runtimeType}');
      blog('blogFile : $invoker : file.isAbsolute : ${file.isAbsolute}');
      blog('blogFile : $invoker : file.parent : ${file.parent}');
      // blog('blogFile : $invoker : file.resolveSymbolicLinksSync() : ${file.resolveSymbolicLinksSync()}');
      blog('blogFile : $invoker : file.lengthSync() : ${file.lengthSync()}');
      blog('blogFile : $invoker : file.toString() : $file');
      blog('blogFile : $invoker : file.lastAccessedSync() : ${file.lastAccessedSync()}');
      blog('blogFile : $invoker : file.lastModifiedSync() : ${file.lastModifiedSync()}');
      // blog('blogFile : $invoker : file.openSync() : ${file.openSync()}');
      // blog('blogFile : $invoker : file.openWrite() : ${file.openWrite()}');
      // blog('blogFile : $invoker : file.statSync() : ${file.statSync()}');
      blog('blogFile : $invoker : file.existsSync() : ${file.existsSync()}');
      // DynamicLinks.blogURI(
      //   uri: file.uri,
      //   invoker: invoker,
      // );
      blog('blogFile : $invoker : file.hashCode : ${file.hashCode}');

      // blog('blogFile : $invoker : file.readAsLinesSync() : ${file.readAsLinesSync()}'); /// Unhandled Exception: FileSystemException: Failed to decode data using encoding 'utf-8',
      // blog('blogFile : $invoker : file.readAsStringSync() : ${file.readAsStringSync()}'); /// ERROR WITH IMAGE FILES
      // blog('blogFile : $invoker : file.readAsBytesSync() : ${file.readAsBytesSync()}'); /// TOO LONG

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFilesDifferences({
    @required File file1,
    @required File file2,
  }){

    if (file1 == null){
      blog('file1 is null');
    }
    if (file2 == null){
      blog('file2 is null');
    }
    if (file1 != null && file2 != null){

      if (file1.path != file2.path){
        blog('files paths are not Identical');
      }
      if (file1.lengthSync() != file2.lengthSync()){
        blog('files lengthSync()s are not Identical');
      }
      if (file1.resolveSymbolicLinksSync() != file2.resolveSymbolicLinksSync()){
        blog('files resolveSymbolicLinksSync()s are not Identical');
      }
      final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
          accuracy: TimeAccuracy.microSecond,
          time1: file1.lastModifiedSync(),
          time2: file2.lastModifiedSync()
      );
      if (_lastModifiedAreIdentical == true){
        blog('files lastModifiedSync()s are not Identical');
      }

    }

  }
  // -----------------------------------------------------------------------------
}
