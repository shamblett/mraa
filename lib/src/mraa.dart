/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// Function type typedefs
typedef returnStringNoParametersFunc = ffi.Pointer<Utf8> Function();

/// The main MRAA class
class Mraa {
  /// Construction
  Mraa() {
    lib = ffi.DynamicLibrary.open('libmraa');
    _setUpPointers();
  }

  /// The MRAA library
  ffi.DynamicLibrary lib;

  /// Version pointer
  ffi.Pointer<ffi.NativeFunction<returnStringNoParametersFunc>> versionPointer;

  /// Version
  String version() {
    final dynamic version =
        versionPointer.asFunction<returnStringNoParametersFunc>();
    final dynamic versionCharString = version();
    return Utf8.fromUtf8(versionCharString);
  }

  void _setUpPointers() {
    versionPointer =
        lib.lookup<ffi.NativeFunction<returnStringNoParametersFunc>>(
            'mraa_get_version');
  }
}
