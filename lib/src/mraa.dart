/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// Function type typedefs
typedef returnStringNoParametersFunc = ffi.Pointer<Utf8> Function();
typedef returnIntNoParametersFunc = ffi.Int32 Function();

/// Dart typedefs
typedef initType = int Function();

/// The main MRAA class
class Mraa {
  /// Default uses the platform library
  Mraa() {
    lib = ffi.DynamicLibrary.open('libmraa');
    _setUpPointers();
  }

  /// Specify the library and path
  Mraa.fromLib(String libPath) {
    lib = ffi.DynamicLibrary.open(libPath);
    _setUpPointers();
  }

  /// The MRAA library
  ffi.DynamicLibrary lib;

  /// Pointers
  ffi.Pointer<ffi.NativeFunction<returnStringNoParametersFunc>> _versionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _initialisePointer;

  /// Version
  String version() {
    final dynamic version =
        _versionPointer.asFunction<returnStringNoParametersFunc>();
    final dynamic versionCharString = version();
    return Utf8.fromUtf8(versionCharString);
  }

  /// Initialise
  MraaReturnCodes initialise() {
    final dynamic init = _initialisePointer.asFunction<initType>();
    return MraaReturnCode.fromInt(init());
  }

  void _setUpPointers() {
    _versionPointer =
        lib.lookup<ffi.NativeFunction<returnStringNoParametersFunc>>(
            'mraa_get_version');
    _initialisePointer =
        lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>('mraa_init');
  }
}
