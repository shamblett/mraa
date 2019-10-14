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
typedef returnIntMraaI2CContextIntParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaI2cContext>, ffi.Int32);

/// Dart Function typedefs
typedef MraaI2cInitialiseType = ffi.Pointer<MraaI2cContext> Function(int);
typedef MraaI2cFrequencyType = int Function(ffi.Pointer<MraaI2cContext>, int);

/// The I2C MRAA API
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
  ffi.Pointer<ffi.NativeFunction<returnMraaI2cContextIntParameterFunc>>
      _initRawPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaI2CContextIntParameterFunc>>
      _frequencyPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _frequencyFunc;

  /// Initialise - mraa_i2c_init
  /// Initialise I2C context, using board defintions
  /// Returns the I2C context or null
  ffi.Pointer<MraaI2cContext> initialise(int bus) => _initFunc(bus);

  /// Initialise raw - mraa_i2c_init_raw
  /// Initialise i2c context, passing in the i2c bus to use
  /// i.e. /dev/i2c-2 would be "2"
  /// Returns the I2C context or null
  ffi.Pointer<MraaI2cContext> initialiseRaw(int bus) => _initRawFunc(bus);

  /// Frequency - mraa_i2c_frequency
  /// Sets the frequency of the i2c context. Most platforms do not support this.
  MraaReturnCode frequency(
          ffi.Pointer<MraaI2cContext> context, MraaI2cMode mode) =>
      returnCode.fromInt(_frequencyFunc(context, i2cMode.asInt(mode)));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init');
    _initRawPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init_raw');
    _frequencyPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaI2CContextIntParameterFunc>>(
            'mraa_i2c_frequency');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaI2cInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaI2cInitialiseType>();
    _frequencyFunc = _frequencyPointer.asFunction<MraaI2cFrequencyType>();
  }
}
