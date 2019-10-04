/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef returnStringNoParametersFunc = ffi.Pointer<Utf8> Function();
typedef returnIntNoParametersFunc = ffi.Int32 Function();

/// Dart Function typedefs
typedef initType = int Function();

/// The Common MRAA Api
class _MraaCommon {
  _MraaCommon(this._lib) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnStringNoParametersFunc>> _versionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _initialisePointer;

  /// Dart Functions
  dynamic _versionFunc;
  dynamic _initFunc;

  /// Version
  String version() {
    final dynamic versionCharString = _versionFunc();
    return Utf8.fromUtf8(versionCharString);
  }

  /// Initialise
  MraaReturnCodes initialise() => returnCodes.fromInt(_initFunc());

  void _setUpPointers() {
    _versionPointer =
        _lib.lookup<ffi.NativeFunction<returnStringNoParametersFunc>>(
            'mraa_get_version');
    _initialisePointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>('mraa_init');
  }

  void _setUpFunctions() {
    _versionFunc = _versionPointer.asFunction<returnStringNoParametersFunc>();
    _initFunc = _initialisePointer.asFunction<initType>();
  }
}
