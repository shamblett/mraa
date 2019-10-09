/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// MRAA function return codes
enum MraaReturnCodes {
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
const Map<int,MraaReturnCodes> _returnCodesValues = <int,MraaReturnCodes>{
  0: MraaReturnCodes.mraaSuccess,
  1: MraaReturnCodes.mraaErrorFeatureNotImplemented,
  2: MraaReturnCodes.mraaErrorFeatureNotSupported,
  3: MraaReturnCodes.mraaErrorInvalidVerbosityLevel,
  4: MraaReturnCodes.mraaErrorInvalidParameter,
  5: MraaReturnCodes.mraaErrorInvalidHandle,
  6: MraaReturnCodes.mraaErrorNoResources,
  7: MraaReturnCodes.mraaErrorInvalidResource,
  8: MraaReturnCodes.mraaErrorInvalidQueueType,
  9: MraaReturnCodes.mraaErrorNoDataAvailable,
  10: MraaReturnCodes.mraaErrorInvalidPlatform,
  11: MraaReturnCodes.mraaErrorPlatformNotInitialised,
  12: MraaReturnCodes.mraaErrorUartOwShorted,
  13: MraaReturnCodes.mraaErrorUartOwNoDevices,
  14: MraaReturnCodes.mraaErrorUartOwDataError,
  99: MraaReturnCodes.mraaErrorUnspecified
};

/// Return codes helper
MraaEnumHelper<MraaReturnCodes> returnCodes =
    MraaEnumHelper<MraaReturnCodes>(_returnCodesValues);
