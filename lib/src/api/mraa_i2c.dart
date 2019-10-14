/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaI2cContextIntParameterFunc = ffi.Pointer<MraaI2cContext>
    Function(ffi.Int32);

/// Dart Function typedefs
typedef MraaI2cInitialiseType = ffi.Pointer<MraaI2cContext> Function(int);

/// The GPIO MRAA Api
class _MraaI2c {
  _MraaI2c(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaI2cContextIntParameterFunc>>
      _initPointer;

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_i2c_init
  /// Initialise I2C context, using board defintions
  /// Returns the I2C context or null
  ffi.Pointer<MraaI2cContext> initialise(int bus) => _initFunc(bus);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaI2cInitialiseType>();
  }
}
