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
  mraaErrorUartOwDataError
}
