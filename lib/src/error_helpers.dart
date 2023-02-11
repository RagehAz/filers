part of filers;

@immutable
class HttpException implements Exception {
  /// --------------------------------------------------------------------------
  const HttpException(this.message);
  /// --------------------------------------------------------------------------
  final String message;
  /// --------------------------------------------------------------------------
  @override
  String toString() {
    return message;
    // return super.toString(); // instance of HttpException
  }
  /// --------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------

/// TRY AND CATCH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> tryAndCatch({
  @required Function functions,
  String invoker,
  ValueChanged<String> onError,
}) async {

  try {
    await functions();
  }

  on Exception catch (error) {

    blog('$invoker : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    // throw(error);
  }

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<bool> tryCatchAndReturnBool({
  @required Function functions,
  ValueChanged<String> onError,
  String invoker = 'tryCatchAndReturnBool',
}) async {
  /// IF FUNCTIONS SUCCEED RETURN TRUE, IF ERROR CAUGHT RETURNS FALSE
  bool _success = true;

  /// TRY FUNCTIONS
  try {
    await functions();
  }

  /// CATCH EXCEPTION ERROR
  on Exception catch (error) {

    blog('$invoker : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    _success = false;
  }

  return _success;
}
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
void blogFlutterErrorDetails(FlutterErrorDetails details){

  if (details != null){

    blog('details.exception.toString() :  ${details.exception}');
    blog('details.stack.toString() :      ${details.stack}');
    blog('details.library :               ${details.library}');
    blog('details.context.name :          ${details.context.name}');
    blog('details.context.style :         ${details.context.style}');
    blog('details.context.showName :      ${details.context.showName}');
    blog('details.context.showSeparator : ${details.context.showSeparator}');
    blog('details.context.linePrefix :    ${details.context.linePrefix}');
    blog('details.stackFilter :           ${details.stackFilter}');
    blog('details.informationCollector :  ${details.informationCollector}');
    blog('details.silent :                ${details.silent}');

  }

}
// -----------------------------------------------------------------------------
