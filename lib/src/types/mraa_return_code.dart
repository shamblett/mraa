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
  mraaSuccess,

  /// < Feature TODO
  mraaErrorFeatureNotImplemented,

  /// < Feature not supported by HW
  mraaErrorFeatureNotSupported,

  /// < Verbosity level wrong
  mraaErrorInvalidVerbosityLevel,

  /// < Parameter invalid
  mraaErrorInvalidParameter,

  /// < Handle invalid
  mraaErrorInvalidHandle,

  /// < No resource of that type avail
  mraaErrorNoResources,

  /// < Resource invalid
  mraaErrorInvalidResource,

  /// < Queue type incorrect
  mraaErrorInvalidQueueType,

  /// < No data available
  mraaErrorNoDataAvailable,

  /// < Platform not recognised
  mraaErrorInvalidPlatform,

  /// < Board information not initialised
  mraaErrorPlatformNotInitialised,

  /// < UART OW Short Circuit Detected
  mraaErrorUartOwShorted,

  /// < UART OW No devices detected
  mraaErrorUartOwNoDevices,

  /// UART OW Data/Bus error detected
  mraaErrorUartOwDataError,

  /// Unspecified
  mraaErrorUnspecified
}

/// Return codes type support
const Map<int, MraaReturnCode> _returnCodesValues = <int, MraaReturnCode>{
  0: MraaReturnCode.mraaSuccess,
  1: MraaReturnCode.mraaErrorFeatureNotImplemented,
  2: MraaReturnCode.mraaErrorFeatureNotSupported,
  3: MraaReturnCode.mraaErrorInvalidVerbosityLevel,
  4: MraaReturnCode.mraaErrorInvalidParameter,
  5: MraaReturnCode.mraaErrorInvalidHandle,
  6: MraaReturnCode.mraaErrorNoResources,
  7: MraaReturnCode.mraaErrorInvalidResource,
  8: MraaReturnCode.mraaErrorInvalidQueueType,
  9: MraaReturnCode.mraaErrorNoDataAvailable,
  10: MraaReturnCode.mraaErrorInvalidPlatform,
  11: MraaReturnCode.mraaErrorPlatformNotInitialised,
  12: MraaReturnCode.mraaErrorUartOwShorted,
  13: MraaReturnCode.mraaErrorUartOwNoDevices,
  14: MraaReturnCode.mraaErrorUartOwDataError,
  99: MraaReturnCode.mraaErrorUnspecified
};

/// Return codes helper
MraaEnumHelper<MraaReturnCode> returnCode =
    MraaEnumHelper<MraaReturnCode>(_returnCodesValues);
