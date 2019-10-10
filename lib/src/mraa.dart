/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The main MRAA class
class Mraa {
  /// Default uses the platform library
  Mraa() {
    _lib = ffi.DynamicLibrary.open('libmraa.so');
  }

  /// Specify the library and path
  Mraa.fromLib(String libPath) {
    _lib = ffi.DynamicLibrary.open(libPath);
  }

  /// AIO read error
  static const int mraaAioReadError = -1;

  /// AIO read double error
  static const double mraaAioReadDoubleError = -1.0;

  /// General common function error
  static const int mraaGeneralError = -1;

  /// Do not use JSON platform loading, some versions of MRAA do not
  /// support this, must be set for MRAA API 1.0.0 usage. Set this before
  /// initialising.
  bool noJsonLoading = false;

  /// Initialise the package, note this does NOT do an MRAA initialise
  /// if you need this call it separately. You MUST call this before usage.
  void initialise() {
    _setupAPI();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// The common API
  _MraaCommon common;

  /// The GPIO API
  _MraaGpio gpio;

  /// The AIO API
  _MraaAio aio;

  void _setupAPI() {
    common = _MraaCommon(_lib, noJsonLoading);
    gpio = _MraaGpio(_lib, noJsonLoading);
    aio = _MraaAio(_lib, noJsonLoading);
  }
}
