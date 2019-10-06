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
    lib = ffi.DynamicLibrary.open('libmraa.so');
    _setupAPI();
  }

  /// Specify the library and path
  Mraa.fromLib(String libPath) {
    lib = ffi.DynamicLibrary.open(libPath);
    _setupAPI();
  }

  /// The MRAA library
  ffi.DynamicLibrary lib;

  /// The common API
  _MraaCommon common;

  /// The GPIO API
  _MraaGpio gpio;

  /// The AIO API
  _MraaAio aio;

  void _setupAPI() {
    common = _MraaCommon(lib);
    gpio = _MraaGpio(lib);
    aio = _MraaAio(lib);
  }
}
