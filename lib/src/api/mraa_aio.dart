/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaAioContextIntParameterFunc = Pointer<MraaAioContext> Function(
    Int32);
typedef returnIntMraaAioContextParameterFunc = Int32 Function(
    Pointer<MraaAioContext>);
typedef returnDoubleMraaAioContextParameterFunc = Double Function(
    Pointer<MraaAioContext>);
typedef returnIntMraaAioContextIntParameterFunc = Int32 Function(
    Pointer<MraaAioContext>, Int32);

/// Dart Function typedefs
typedef MraaAioInitialiseType = Pointer<MraaAioContext> Function(int);
typedef MraaAioReadType = int Function(Pointer<MraaAioContext>);
typedef MraaAioReadDoubleType = double Function(Pointer<MraaAioContext>);
typedef MraaAioCloseType = int Function(Pointer<MraaAioContext>);
typedef MraaAioSetBitType = int Function(Pointer<MraaAioContext>, int);
typedef MraaAioGetBitType = int Function(Pointer<MraaAioContext>);

/// The AIO MRAA API
/// AIO is the analogue input & output interface to libmraa.
/// It is used to read or set the voltage applied to an AIO pin.
class _MraaAio {
  _MraaAio(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaAioContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnIntMraaAioContextParameterFunc>> _readPointer;
  Pointer<NativeFunction<returnDoubleMraaAioContextParameterFunc>>
      _readDoublePointer;
  Pointer<NativeFunction<returnIntMraaAioContextParameterFunc>> _closePointer;
  Pointer<NativeFunction<returnIntMraaAioContextIntParameterFunc>>
      _setBitPointer;
  Pointer<NativeFunction<returnIntMraaAioContextParameterFunc>> _getBitPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _readFunc;
  dynamic _readDoubleFunc;
  dynamic _closeFunc;
  dynamic _setBitFunc;
  dynamic _getBitFunc;

  /// Initialise - mraa_aio_init
  /// Initialise an Analog input device, connected to the specified pin.
  /// Aio pins are always 0 indexed reguardless of their position.
  /// Check your board mapping for details.
  /// An arduino style layout will have A0 as pin14 but AIO0.
  Pointer<MraaAioContext> initialise(int pin) => _initFunc(pin);

  /// Read - mraa_aio_read_float
  /// Read the input voltage and return it as a normalized float (0.0f-1.0f).
  /// Returns The current input voltage or -1.0 for error
  double readDouble(Pointer<MraaAioContext> dev) => _readDoubleFunc(dev);

  /// Read - mraa_aio_read
  /// Read the input voltage. By default mraa will shift the raw value
  /// up or down to a 10 bit value.
  /// Returns The current input voltage or -1 for error
  int read(Pointer<MraaAioContext> dev) => _readFunc(dev);

  /// Close - mraa_aio_close
  /// Close the analog input context, this will free the memory for the context.
  /// MRAA_SUCCESS indicates correct closure
  MraaReturnCode close(Pointer<MraaAioContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Set bit - mraa_aio_set_bit
  /// Set the bit value which mraa will shift the raw reading from the ADC to. I.e. 10bits
  MraaReturnCode setBit(Pointer<MraaAioContext> dev, int bits) =>
      returnCode.fromInt(_setBitFunc(dev, bits));

  /// Set bit - mraa_aio_get_bit
  /// Gets the bit value mraa is shifting the analog read to.
  int getBit(Pointer<MraaAioContext> dev) => _getBitFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaAioContextIntParameterFunc>>(
            'mraa_aio_init');
    _readPointer =
        _lib.lookup<NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_read');
    _readDoublePointer =
        _lib.lookup<NativeFunction<returnDoubleMraaAioContextParameterFunc>>(
            'mraa_aio_read_float');
    _closePointer =
        _lib.lookup<NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_close');
    _setBitPointer =
        _lib.lookup<NativeFunction<returnIntMraaAioContextIntParameterFunc>>(
            'mraa_aio_set_bit');
    _getBitPointer =
        _lib.lookup<NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_get_bit');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaAioInitialiseType>();
    _readFunc = _readPointer.asFunction<MraaAioReadType>();
    _readDoubleFunc = _readDoublePointer.asFunction<MraaAioReadDoubleType>();
    _closeFunc = _closePointer.asFunction<MraaAioCloseType>();
    _setBitFunc = _setBitPointer.asFunction<MraaAioSetBitType>();
    _getBitFunc = _getBitPointer.asFunction<MraaAioGetBitType>();
  }
}
