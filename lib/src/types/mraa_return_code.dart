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
  success,

  /// < Feature TODO
  errorFeatureNotImplemented,

  /// < Feature not supported by HW
  errorFeatureNotSupported,

  /// < Verbosity level wrong
  errorInvalidVerbosityLevel,

  /// < Parameter invalid
  errorInvalidParameter,

  /// < Handle invalid
  errorInvalidHandle,

  /// < No resource of that type avail
  errorNoResources,

  /// < Resource invalid
  errorInvalidResource,

  /// < Queue type incorrect
  errorInvalidQueueType,

  /// < No data available
  errorNoDataAvailable,

  /// < Platform not recognised
  errorInvalidPlatform,

  /// < Board information not initialised
  errorPlatformNotInitialised,

  /// < UART OW Short Circuit Detected
  errorUartOwShorted,

  /// < UART OW No devices detected
  errorUartOwNoDevices,

  /// UART OW Data/Bus error detected
  errorUartOwDataError,

  /// Unspecified
  errorUnspecified
}

/// Return codes type support
const Map<int, MraaReturnCode> _returnCodesValues = <int, MraaReturnCode>{
  0: MraaReturnCode.success,
  1: MraaReturnCode.errorFeatureNotImplemented,
  2: MraaReturnCode.errorFeatureNotSupported,
  3: MraaReturnCode.errorInvalidVerbosityLevel,
  4: MraaReturnCode.errorInvalidParameter,
  5: MraaReturnCode.errorInvalidHandle,
  6: MraaReturnCode.errorNoResources,
  7: MraaReturnCode.errorInvalidResource,
  8: MraaReturnCode.errorInvalidQueueType,
  9: MraaReturnCode.errorNoDataAvailable,
  10: MraaReturnCode.errorInvalidPlatform,
  11: MraaReturnCode.errorPlatformNotInitialised,
  12: MraaReturnCode.errorUartOwShorted,
  13: MraaReturnCode.errorUartOwNoDevices,
  14: MraaReturnCode.errorUartOwDataError,
  99: MraaReturnCode.errorUnspecified
};

/// Return codes helper
MraaEnumHelper<MraaReturnCode> returnCode =
    MraaEnumHelper<MraaReturnCode>(_returnCodesValues);
