/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaI2cContextIntParameterFunc = Pointer<MraaI2cContext> Function(
    Int32);
typedef returnIntMraaI2CContextIntParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Int32);
typedef returnIntMraaI2CContextUint8ArrayIntParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, Int32);
typedef returnIntMraaI2CContextParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>);
typedef returnIntMraaI2CContextUint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint8);
typedef returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint8, Pointer<Uint8>, Int32);
typedef returnIntMraaI2CContextUint8Uint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint8, Uint8);
typedef returnIntMraaI2CContextUint16Uint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint16, Uint8);

/// Dart Function typedefs
typedef MraaI2cInitialiseType = Pointer<MraaI2cContext> Function(int);
typedef MraaI2cInitialiseRawType = Pointer<MraaI2cContext> Function(int);
typedef MraaI2cFrequencyType = int Function(Pointer<MraaI2cContext>, int);
typedef MraaI2cReadType = int Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, int);
typedef MraaI2cReadByteType = int Function(Pointer<MraaI2cContext>);
typedef MraaI2cReadByteDataType = int Function(Pointer<MraaI2cContext>, int);
typedef MraaI2cReadWordDataType = int Function(Pointer<MraaI2cContext>, int);
typedef MraaI2cReadBytesDataType = int Function(
    Pointer<MraaI2cContext>, int, Pointer<Uint8>, int);
typedef MraaI2cWriteType = int Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, int);
typedef MraaI2cWriteByteType = int Function(Pointer<MraaI2cContext>, int);
typedef MraaI2cWriteByteDataType = int Function(
    Pointer<MraaI2cContext>, int, int);
typedef MraaI2cWriteWordDataType = int Function(
    Pointer<MraaI2cContext>, int, int);
typedef MraaI2cAddressType = int Function(Pointer<MraaI2cContext>, int);
typedef MraaI2cStopType = int Function(Pointer<MraaI2cContext>);

/// The I2C MRAA API
/// An i2c context represents a master on an i2c bus and that context can communicate
/// to multiple i2c slaves by configuring the address. It is considered best practice to
/// make sure the address is correct before doing any calls on i2c, in case another
/// application or even thread changed the address on that bus. Multiple instances
/// of the same bus can exist.
class MraaI2c {
  /// Construction
  MraaI2c(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaI2cContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaI2cContextIntParameterFunc>> _initRawPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextIntParameterFunc>>
      _frequencyPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ArrayIntParameterFunc>>
      _readPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextParameterFunc>>
      _readBytePointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _readByteDataPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _readWordDataPointer;
  Pointer<
          NativeFunction<
              returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>
      _readBytesDataPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ArrayIntParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _writeBytePointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8Uint8ParameterFunc>>
      _writeByteDataPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint16Uint8ParameterFunc>>
      _writeWordDataPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>
      _addressPointer;
  Pointer<NativeFunction<returnIntMraaI2CContextParameterFunc>> _stopPointer;

  /// Dart Functions
  MraaI2cInitialiseType _initFunc;
  MraaI2cInitialiseRawType _initRawFunc;
  MraaI2cFrequencyType _frequencyFunc;
  MraaI2cReadType _readFunc;
  MraaI2cReadByteType _readByteFunc;
  MraaI2cReadByteDataType _readByteDataFunc;
  MraaI2cReadWordDataType _readWordDataFunc;
  MraaI2cReadBytesDataType _readBytesDataFunc;
  MraaI2cWriteType _writeFunc;
  MraaI2cWriteByteType _writeByteFunc;
  MraaI2cWriteByteDataType _writeByteDataFunc;
  MraaI2cWriteWordDataType _writeWordDataFunc;
  MraaI2cAddressType _addressFunc;
  MraaI2cStopType _stopFunc;

  /// Initialise - mraa_i2c_init
  /// Initialise I2C context, using board defintions
  /// Returns the I2C context or null
  Pointer<MraaI2cContext> initialise(int bus) => _initFunc(bus);

  /// Initialise raw - mraa_i2c_init_raw
  /// Initialise i2c context, passing in the i2c bus to use
  /// i.e. /dev/i2c-2 would be "2"
  /// Returns the I2C context or null
  Pointer<MraaI2cContext> initialiseRaw(int bus) => _initRawFunc(bus);

  /// Frequency - mraa_i2c_frequency
  /// Sets the frequency of the i2c context. Most platforms do not support this.
  MraaReturnCode frequency(Pointer<MraaI2cContext> context, MraaI2cMode mode) =>
      returnCode.fromInt(_frequencyFunc(context, i2cMode.asInt(mode)));

  /// Read - mraa_i2c_read
  /// Simple bulk read from an i2c context upt length bytes
  /// Returns the length read or MraaGeneralError
  int read(Pointer<MraaI2cContext> context, Pointer<Uint8> data, int length) =>
      _readFunc(context, data, length);

  /// Read byte = mraa_i2C_read_byte
  /// Simple read for a single byte from the i2c context
  /// Returns MraaGeneralError if failed
  int readByte(Pointer<MraaI2cContext> context) => _readByteFunc(context);

  /// Read byte data - mraa_i2c_read_byte_data
  /// Read a single byte from i2c context, from designated register
  /// Returns MraaGeneralError if failed
  int readByteData(Pointer<MraaI2cContext> context, int register) =>
      _readByteDataFunc(context, register);

  /// Read word data - mraa_i2c_read_word_data
  /// Read a single word from i2c context, from designated register
  /// Returns MraaGeneralError if failed
  int readWordData(Pointer<MraaI2cContext> context, int register) =>
      _readWordDataFunc(context, register);

  /// Read bytes data - mraa_i2c_read_bytes_data
  /// Bulk read from i2c context, starting from designated register
  /// Returns the length in bytes passed to the function or -1
  int readBytesData(Pointer<MraaI2cContext> context, int command,
          Pointer<Uint8> data, int length) =>
      _readBytesDataFunc(context, command, data, length);

  /// Write - mraa_i2c_write
  /// Write length bytes to the bus, the first byte in the array is the command/register to write.
  MraaReturnCode write(
          Pointer<MraaI2cContext> context, Pointer<Uint8> data, int length) =>
      returnCode.fromInt(_writeFunc(context, data, length));

  /// Write byte - mraa_i2c_write_byte
  /// Write a single byte to an i2c context
  MraaReturnCode writeByte(Pointer<MraaI2cContext> context, int data) =>
      returnCode.fromInt(_writeByteFunc(context, data));

  /// Write byte data - mraa_write_byte_data
  /// Write a single byte to an i2c context
  MraaReturnCode writeByteData(
          Pointer<MraaI2cContext> context, int data, int command) =>
      returnCode.fromInt(_writeByteDataFunc(context, data, command));

  /// Write word data - mraa_write_byte_data
  /// Write a single word to an i2c context
  MraaReturnCode writeWordData(
          Pointer<MraaI2cContext> context, int data, int command) =>
      returnCode.fromInt(_writeWordDataFunc(context, data, command));

  /// Address - mraa_i2c_address
  /// Sets the i2c slave address.
  MraaReturnCode address(Pointer<MraaI2cContext> context, int address) =>
      returnCode.fromInt(_addressFunc(context, address));

  /// Stop - mraa_i2c_stop
  /// De-inits an mraa_i2c_context device
  MraaReturnCode stop(Pointer<MraaI2cContext> context) =>
      returnCode.fromInt(_stopFunc(context));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init_raw');
    _frequencyPointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextIntParameterFunc>>(
            'mraa_i2c_frequency');
    _readPointer = _lib.lookup<
            NativeFunction<returnIntMraaI2CContextUint8ArrayIntParameterFunc>>(
        'mraa_i2c_read');
    _readBytePointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextParameterFunc>>(
            'mraa_i2c_read_byte');
    _readByteDataPointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_byte_data');
    _readWordDataPointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_word_data');
    _readBytesDataPointer = _lib.lookup<
            NativeFunction<
                returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>(
        'mraa_i2c_read_bytes_data');
    _writePointer = _lib.lookup<
            NativeFunction<returnIntMraaI2CContextUint8ArrayIntParameterFunc>>(
        'mraa_i2c_write');
    _writeBytePointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_write_byte');
    _writeByteDataPointer = _lib
        .lookup<NativeFunction<returnIntMraaI2CContextUint8Uint8ParameterFunc>>(
            'mraa_i2c_write_byte_data');
    _writeWordDataPointer = _lib.lookup<
            NativeFunction<returnIntMraaI2CContextUint16Uint8ParameterFunc>>(
        'mraa_i2c_write_word_data');
    _addressPointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_address');
    _stopPointer =
        _lib.lookup<NativeFunction<returnIntMraaI2CContextParameterFunc>>(
            'mraa_i2c_stop');
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
    _writeFunc = _writePointer.asFunction<MraaI2cWriteType>();
    _writeByteFunc = _writeBytePointer.asFunction<MraaI2cWriteByteType>();
    _writeByteDataFunc =
        _writeByteDataPointer.asFunction<MraaI2cWriteByteDataType>();
    _writeWordDataFunc =
        _writeWordDataPointer.asFunction<MraaI2cWriteWordDataType>();
    _addressFunc = _addressPointer.asFunction<MraaI2cAddressType>();
    _stopFunc = _stopPointer.asFunction<MraaI2cStopType>();
  }
}
