/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// MRAA function return(result) codes
enum MraaReturnCode {
  /// < Expected response
  success(mraaimpl.mraa_result_t.MRAA_SUCCESS),

  /// < Feature
  errorFeatureNotImplemented(
      mraaimpl.mraa_result_t.MRAA_ERROR_FEATURE_NOT_IMPLEMENTED),

  /// < Feature not supported by HW
  errorFeatureNotSupported(
      mraaimpl.mraa_result_t.MRAA_ERROR_FEATURE_NOT_SUPPORTED),

  /// < Verbosity level wrong
  errorInvalidVerbosityLevel(
      mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_VERBOSITY_LEVEL),

  /// < Parameter invalid
  errorInvalidParameter(mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_PARAMETER),

  /// < Handle invalid
  errorInvalidHandle(mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_HANDLE),

  /// < No resource of that type avail
  errorNoResources(mraaimpl.mraa_result_t.MRAA_ERROR_NO_RESOURCES),

  /// < Resource invalid
  errorInvalidResource(mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_RESOURCE),

  /// < Queue type incorrect
  errorInvalidQueueType(mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_QUEUE_TYPE),

  /// < No data available
  errorNoDataAvailable(mraaimpl.mraa_result_t.MRAA_ERROR_NO_DATA_AVAILABLE),

  /// < Platform not recognised
  errorInvalidPlatform(mraaimpl.mraa_result_t.MRAA_ERROR_INVALID_PLATFORM),

  /// < Board information not initialised
  errorPlatformNotInitialised(
      mraaimpl.mraa_result_t.MRAA_ERROR_PLATFORM_NOT_INITIALISED),

  /// < UART OW Short Circuit Detected
  errorUartOwShorted(mraaimpl.mraa_result_t.MRAA_ERROR_UART_OW_SHORTED),

  /// < UART OW No devices detected
  errorUartOwNoDevices(mraaimpl.mraa_result_t.MRAA_ERROR_UART_OW_NO_DEVICES),

  /// UART OW Data/Bus error detected
  errorUartOwDataError(mraaimpl.mraa_result_t.MRAA_ERROR_UART_OW_DATA_ERROR),

  /// Unspecified
  errorUnspecified(mraaimpl.mraa_result_t.MRAA_ERROR_UNSPECIFIED);

  static final Map<int, MraaReturnCode> byCode = {};

  static MraaReturnCode returnCode(int retCode) {
    if (byCode.isEmpty) {
      for (final retCode in MraaReturnCode.values) {
        byCode[retCode.code] = retCode;
      }
    }

    final ret = byCode.containsKey(retCode)
        ? byCode[retCode]
        : MraaReturnCode.errorUnspecified;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaReturnCode(this.code);
}
