/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef _returnMraaI2cContextIntParameterFunc = Pointer<MraaI2cContext>
    Function(Int32);
typedef _returnIntMraaI2CContextIntParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Int32);
typedef _returnIntMraaI2CContextUint8ArrayIntParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, Int32);
typedef _returnIntMraaI2CContextParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>);
typedef _returnIntMraaI2CContextUint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint8);
typedef _returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc = Int32
    Function(Pointer<MraaI2cContext>, Uint8, Pointer<Uint8>, Int32);
typedef _returnIntMraaI2CContext2Uint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint8, Uint8);
typedef _returnIntMraaI2CContextUint16Uint8ParameterFunc = Int32 Function(
    Pointer<MraaI2cContext>, Uint16, Uint8);

/// Dart Function typedefs
typedef _MraaI2cInitialiseType = Pointer<MraaI2cContext> Function(int);
typedef _MraaI2cInitialiseRawType = Pointer<MraaI2cContext> Function(int);
typedef _MraaI2cFrequencyType = int Function(Pointer<MraaI2cContext>, int);
typedef _MraaI2cReadType = int Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, int);
typedef _MraaI2cReadByteType = int Function(Pointer<MraaI2cContext>);
typedef _MraaI2cReadByteDataType = int Function(Pointer<MraaI2cContext>, int);
typedef _MraaI2cReadWordDataType = int Function(Pointer<MraaI2cContext>, int);
typedef _MraaI2cReadBytesDataType = int Function(
    Pointer<MraaI2cContext>, int, Pointer<Uint8>, int);
typedef _MraaI2cWriteType = int Function(
    Pointer<MraaI2cContext>, Pointer<Uint8>, int);
typedef _MraaI2cWriteByteType = int Function(Pointer<MraaI2cContext>, int);
typedef _MraaI2cWriteByteDataType = int Function(
    Pointer<MraaI2cContext>, int, int);
typedef _MraaI2cWriteWordDataType = int Function(
    Pointer<MraaI2cContext>, int, int);
typedef _MraaI2cAddressType = int Function(Pointer<MraaI2cContext>, int);
typedef _MraaI2cStopType = int Function(Pointer<MraaI2cContext>);

/// The I2C MRAA API
///
/// An I2C context represents a master on an iI2C bus and that context
/// can communicate to multiple I2C slaves by configuring the address.
/// It is considered best practice to make sure the address is correct
/// before doing any calls on I2C, in case another application changed the
/// address on that bus. Multiple instances of the same bus can exist.
class MraaI2c {
  /// Construction
  MraaI2c(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// C Pointers
  Pointer<NativeFunction<_returnMraaI2cContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<_returnMraaI2cContextIntParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextIntParameterFunc>>
      _frequencyPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ArrayIntParameterFunc>>
      _readPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextParameterFunc>>
      _readBytePointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>
      _readByteDataPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>
      _readWordDataPointer;
  Pointer<
          NativeFunction<
              _returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>
      _readBytesDataPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ArrayIntParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>
      _writeBytePointer;
  Pointer<NativeFunction<_returnIntMraaI2CContext2Uint8ParameterFunc>>
      _writeByteDataPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint16Uint8ParameterFunc>>
      _writeWordDataPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>
      _addressPointer;
  Pointer<NativeFunction<_returnIntMraaI2CContextParameterFunc>> _stopPointer;

  /// Dart Functions
  _MraaI2cInitialiseType _initFunc;
  _MraaI2cInitialiseRawType _initRawFunc;
  _MraaI2cFrequencyType _frequencyFunc;
  _MraaI2cReadType _readFunc;
  _MraaI2cReadByteType _readByteFunc;
  _MraaI2cReadByteDataType _readByteDataFunc;
  _MraaI2cReadWordDataType _readWordDataFunc;
  _MraaI2cReadBytesDataType _readBytesDataFunc;
  _MraaI2cWriteType _writeFunc;
  _MraaI2cWriteByteType _writeByteFunc;
  _MraaI2cWriteByteDataType _writeByteDataFunc;
  _MraaI2cWriteWordDataType _writeWordDataFunc;
  _MraaI2cAddressType _addressFunc;
  _MraaI2cStopType _stopFunc;

  /// Initialise - mraa_i2c_init
  ///
  /// Initialise an [MraaI2cContext], using board definitions
  /// Returns the initialised [MraaI2cContext] or NULL
  Pointer<MraaI2cContext> initialise(int bus) => _initFunc(bus);

  /// Initialise raw - mraa_i2c_init_raw
  ///
  /// Initialise an [MraaI2cContext], using I2C bus to use
  /// i.e. /dev/i2c-2 would be "2"
  /// Returns the initialised [MraaI2cContext] or NULL
  Pointer<MraaI2cContext> initialiseRaw(int bus) => _initRawFunc(bus);

  /// Frequency - mraa_i2c_frequency
  ///
  /// Sets the frequency of the I2C context.
  /// Most platforms do not support this.
  MraaReturnCode frequency(Pointer<MraaI2cContext> context, MraaI2cMode mode) =>
      returnCode.fromInt(_frequencyFunc(context, i2cMode.asInt(mode)));

  /// Read - mraa_i2c_read
  ///
  /// Simple bulk read from an I2C context up to length bytes
  /// Returns the length read or [Mraa.generalError]
  int read(Pointer<MraaI2cContext> context, Pointer<Uint8> data, int length) =>
      _readFunc(context, data, length);

  /// Read byte = mraa_i2C_read_byte
  ///
  /// Simple read for a single byte from an i2c context
  /// Returns [Mraa.generalError] on failure
  int readByte(Pointer<MraaI2cContext> context) => _readByteFunc(context);

  /// Read byte data - mraa_i2c_read_byte_data
  ///
  /// Read a single byte from an I2C context, from the designated register
  /// Returns [Mraa.generalError] on failure
  int readByteData(Pointer<MraaI2cContext> context, int register) =>
      _readByteDataFunc(context, register);

  /// Read word data - mraa_i2c_read_word_data
  ///
  /// Read a single word from an I2C context, from designated register
  /// Returns [Mraa.generalError] on failure
  int readWordData(Pointer<MraaI2cContext> context, int register) =>
      _readWordDataFunc(context, register);

  /// Read bytes data - mraa_i2c_read_bytes_data
  ///
  /// Bulk read from an I2C context, starting from the designated register
  /// Returns the length in bytes passed to the function or [Mraa.generalError]
  int readBytesData(Pointer<MraaI2cContext> context, int command,
          Pointer<Uint8> data, int length) =>
      _readBytesDataFunc(context, command, data, length);

  /// Write - mraa_i2c_write
  ///
  /// Write length bytes to the bus, the first byte in the array is the command/register to write.
  MraaReturnCode write(
          Pointer<MraaI2cContext> context, Pointer<Uint8> data, int length) =>
      returnCode.fromInt(_writeFunc(context, data, length));

  /// Write byte - mraa_i2c_write_byte
  ///
  /// Write a single byte to an I2C context
  MraaReturnCode writeByte(Pointer<MraaI2cContext> context, int data) =>
      returnCode.fromInt(_writeByteFunc(context, data));

  /// Write byte data - mraa_write_byte_data
  ///
  /// Write a single byte to an i2c context
  MraaReturnCode writeByteData(
          Pointer<MraaI2cContext> context, int data, int command) =>
      returnCode.fromInt(_writeByteDataFunc(context, data, command));

  /// Write word data - mraa_write_byte_data
  ///
  /// Write a single word to an I2C context
  MraaReturnCode writeWordData(
          Pointer<MraaI2cContext> context, int data, int command) =>
      returnCode.fromInt(_writeWordDataFunc(context, data, command));

  /// Address - mraa_i2c_address
  ///
  /// Sets the I2C slave address.
  MraaReturnCode address(Pointer<MraaI2cContext> context, int address) =>
      returnCode.fromInt(_addressFunc(context, address));

  /// Stop - mraa_i2c_stop
  ///
  /// De-inits an [MraaI2cContext]
  MraaReturnCode stop(Pointer<MraaI2cContext> context) =>
      returnCode.fromInt(_stopFunc(context));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<_returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<_returnMraaI2cContextIntParameterFunc>>(
            'mraa_i2c_init_raw');
    _frequencyPointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextIntParameterFunc>>(
            'mraa_i2c_frequency');
    _readPointer = _lib.lookup<
            NativeFunction<_returnIntMraaI2CContextUint8ArrayIntParameterFunc>>(
        'mraa_i2c_read');
    _readBytePointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextParameterFunc>>(
            'mraa_i2c_read_byte');
    _readByteDataPointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_byte_data');
    _readWordDataPointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_read_word_data');
    _readBytesDataPointer = _lib.lookup<
            NativeFunction<
                _returnIntMraaI2CContextUint8Uint8ArrayIntParameterFunc>>(
        'mraa_i2c_read_bytes_data');
    _writePointer = _lib.lookup<
            NativeFunction<_returnIntMraaI2CContextUint8ArrayIntParameterFunc>>(
        'mraa_i2c_write');
    _writeBytePointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_write_byte');
    _writeByteDataPointer = _lib
        .lookup<NativeFunction<_returnIntMraaI2CContext2Uint8ParameterFunc>>(
            'mraa_i2c_write_byte_data');
    _writeWordDataPointer = _lib.lookup<
            NativeFunction<_returnIntMraaI2CContextUint16Uint8ParameterFunc>>(
        'mraa_i2c_write_word_data');
    _addressPointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextUint8ParameterFunc>>(
            'mraa_i2c_address');
    _stopPointer =
        _lib.lookup<NativeFunction<_returnIntMraaI2CContextParameterFunc>>(
            'mraa_i2c_stop');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaI2cInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<_MraaI2cInitialiseType>();
    _frequencyFunc = _frequencyPointer.asFunction<_MraaI2cFrequencyType>();
    _readFunc = _readPointer.asFunction<_MraaI2cReadType>();
    _readByteFunc = _readBytePointer.asFunction<_MraaI2cReadByteType>();
    _readByteDataFunc =
        _readByteDataPointer.asFunction<_MraaI2cReadByteDataType>();
    _readWordDataFunc =
        _readWordDataPointer.asFunction<_MraaI2cReadWordDataType>();
    _readBytesDataFunc =
        _readBytesDataPointer.asFunction<_MraaI2cReadBytesDataType>();
    _writeFunc = _writePointer.asFunction<_MraaI2cWriteType>();
    _writeByteFunc = _writeBytePointer.asFunction<_MraaI2cWriteByteType>();
    _writeByteDataFunc =
        _writeByteDataPointer.asFunction<_MraaI2cWriteByteDataType>();
    _writeWordDataFunc =
        _writeWordDataPointer.asFunction<_MraaI2cWriteWordDataType>();
    _addressFunc = _addressPointer.asFunction<_MraaI2cAddressType>();
    _stopFunc = _stopPointer.asFunction<_MraaI2cStopType>();
  }
}
