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
typedef returnIntMraaI2CContextUint8ArrayIntParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaI2cContext>, ffi.Pointer<ffi.Uint8>, ffi.Int32);
typedef returnIntMraaI2CContextParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaI2cContext>);
typedef returnIntMraaI2CContextUint8ParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaI2cContext>, ffi.Uint8);
typedef returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc
    = ffi.Int32 Function(ffi.Pointer<MraaI2cContext>, ffi.Uint8,
        ffi.Pointer<ffi.Uint8>, ffi.Int32);

/// Dart Function typedefs
typedef MraaI2cInitialiseType = ffi.Pointer<MraaI2cContext> Function(int);
typedef MraaI2cFrequencyType = int Function(ffi.Pointer<MraaI2cContext>, int);
typedef MraaI2cReadType = int Function(
    ffi.Pointer<MraaI2cContext>, ffi.Pointer<ffi.Uint8>, int);
typedef MraaI2cReadByteType = int Function(ffi.Pointer<MraaI2cContext>);
typedef MraaI2cReadByteDataType = int Function(
    ffi.Pointer<MraaI2cContext>, int);
typedef MraaI2cReadWordDataType = int Function(
    ffi.Pointer<MraaI2cContext>, int);
typedef MraaI2cReadBytesDataType = int Function(
    ffi.Pointer<MraaI2cContext>, int, ffi.Pointer<ffi.Uint8>, int);

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
  ffi.Pointer<
          ffi.NativeFunction<returnIntMraaI2CContextUint8ArrayIntParameterFunc>>
      _readPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaI2CContextParameterFunc>>
      _readBytePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _readByteDataPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _readWordDataPointer;
  ffi.Pointer<
          ffi.NativeFunction<
              returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>
      _readBytesDataPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _frequencyFunc;
  dynamic _readFunc;
  dynamic _readByteFunc;
  dynamic _readByteDataFunc;
  dynamic _readWordDataFunc;
  dynamic _readBytesDataFunc;

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

  /// Read - mraa_i2c_read
  /// Simple bulk read from an i2c context upt length bytes
  /// Returns the length read or MraaGeneralError
  int read(ffi.Pointer<MraaI2cContext> context, ffi.Pointer<ffi.Uint8> data,
          int length) =>
      _readFunc(context, data, length);

  /// Read byte = mraa_i2C_read_byte
  /// Simple read for a single byte from the i2c context
  /// Returns MraaGeneralError if failed
  int readByte(ffi.Pointer<MraaI2cContext> context) => _readByteFunc(context);

  /// Read byte data - mraa_i2c_read_byte_data
  /// Read a single byte from i2c context, from designated register
  /// Returns MraaGeneralError if failed
  int readByteData(ffi.Pointer<MraaI2cContext> context, int register) =>
      _readByteDataFunc(context, register);

  /// Read word data - mraa_i2c_read_word_data
  /// Read a single word from i2c context, from designated register
  /// Returns MraaGeneralError if failed
  int readWordData(ffi.Pointer<MraaI2cContext> context, int register) =>
      _readWordDataFunc(context, register);

  /// Read bytes data - mraa_i2c_read_bytes_data
  /// Bulk read from i2c context, starting from designated register
  /// Returns the length in bytes passed to the function or -1
  int readBytesData(ffi.Pointer<MraaI2cContext> context, int command,
          ffi.Pointer<ffi.Uint8> data, int length) =>
      _readBytesDataFunc(context, command, data, length);

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
    _readPointer = _lib.lookup<
            ffi.NativeFunction<
                returnIntMraaI2CContextUint8ArrayIntParameterFunc>>(
        'mraa_i2c_read');
    _readBytePointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaI2CContextParameterFunc>>(
            'mraa_i2c_read_byte');
    _readByteDataPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_byte_data');
    _readWordDataPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_word_data');
    _readBytesDataPointer = _lib.lookup<
            ffi.NativeFunction<
                returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>(
        'mraa_i2c_read_bytes_data');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaI2cInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaI2cInitialiseType>();
    _frequencyFunc = _frequencyPointer.asFunction<MraaI2cFrequencyType>();
    _readFunc = _readPointer.asFunction<MraaI2cReadType>();
    _readByteFunc = _readBytePointer.asFunction<MraaI2cReadByteType>();
    _readByteDataFunc =
        _readByteDataPointer.asFunction<MraaI2cReadByteDataType>();
    _readWordDataFunc =
        _readWordDataPointer.asFunction<MraaI2cReadWordDataType>();
    _readBytesDataFunc =
        _readBytesDataPointer.asFunction<MraaI2cReadBytesDataType>();
  }
}
