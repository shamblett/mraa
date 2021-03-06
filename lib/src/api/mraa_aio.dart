/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function signature typedefs
typedef _returnMraaAioContextIntParameterFunc = Pointer<MraaAioContext>
    Function(Int32);
typedef _returnIntMraaAioContextParameterFunc = Int32 Function(
    Pointer<MraaAioContext>);
typedef _returnFloatMraaAioContextParameterFunc = Float Function(
    Pointer<MraaAioContext>);
typedef _returnIntMraaAioContextIntParameterFunc = Int32 Function(
    Pointer<MraaAioContext>, Int32);

/// Dart Function typedefs
typedef _MraaAioInitialiseType = Pointer<MraaAioContext> Function(int);
typedef _MraaAioReadType = int Function(Pointer<MraaAioContext>);
typedef _MraaAioReadDoubleType = double Function(Pointer<MraaAioContext>);
typedef _MraaAioCloseType = int Function(Pointer<MraaAioContext>);
typedef _MraaAioSetBitType = int Function(Pointer<MraaAioContext>, int);
typedef _MraaAioGetBitType = int Function(Pointer<MraaAioContext>);

/// The AIO MRAA API
///
/// AIO is the analogue input & output interface to MRAA
/// It is used to read or set the voltage applied to an AIO pin.
class MraaAio {
  /// Construction
  MraaAio(this._lib, this._noJsonLoading, this._useGrovePi) {
    _setUpPointers();
    _setUpFunctions();
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  final _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  /// C Pointers
  late Pointer<NativeFunction<_returnMraaAioContextIntParameterFunc>>
      _initPointer;
  late Pointer<NativeFunction<_returnIntMraaAioContextParameterFunc>>
      _readPointer;
  late Pointer<NativeFunction<_returnFloatMraaAioContextParameterFunc>>
      _readDoublePointer;
  late Pointer<NativeFunction<_returnIntMraaAioContextParameterFunc>>
      _closePointer;
  late Pointer<NativeFunction<_returnIntMraaAioContextIntParameterFunc>>
      _setBitPointer;
  late Pointer<NativeFunction<_returnIntMraaAioContextParameterFunc>>
      _getBitPointer;

  /// Dart Functions
  late _MraaAioInitialiseType _initFunc;
  late _MraaAioReadType _readFunc;
  late _MraaAioReadDoubleType _readDoubleFunc;
  late _MraaAioCloseType _closeFunc;
  late _MraaAioSetBitType _setBitFunc;
  late _MraaAioGetBitType _getBitFunc;

  /// Initialise - mraa_aio_init
  ///
  /// Initialise an analogue input device connected to the specified pin.
  /// AIO pins are always 0 indexed regardless of their position.
  /// Check your board mapping for details.
  Pointer<MraaAioContext> initialise(int pin) =>
      _initFunc(pin + _grovePiPinOffset);

  /// Read - mraa_aio_read_float
  ///
  /// Read the input voltage and return it as a normalized double (0.0 - 1.0).
  /// Returns The current input voltage or [Mraa.aioReadDoubleError] on error.
  double readDouble(Pointer<MraaAioContext> dev) => _readDoubleFunc(dev);

  /// Read - mraa_aio_read
  ///
  /// Read the input voltage. By default MRAA will shift the raw value
  /// up or down to a 10 bit value.
  /// Returns the current input voltage or [Mraa.aioReadError] for error
  int read(Pointer<MraaAioContext> dev) => _readFunc(dev);

  /// Close - mraa_aio_close
  ///
  /// Close the analogue input context, this will free the
  /// memory for the context.
  MraaReturnCode close(Pointer<MraaAioContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Set bit - mraa_aio_set_bit
  ///
  /// Set the bit value which MRAA will shift the raw reading
  /// from the ADC to, i.e. 10bits
  MraaReturnCode setBit(Pointer<MraaAioContext> dev, int bits) =>
      returnCode.fromInt(_setBitFunc(dev, bits));

  /// Set bit - mraa_aio_get_bit
  ///
  /// Gets the bit value mraa is shifting the analogue read to.
  int getBit(Pointer<MraaAioContext> dev) => _getBitFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<_returnMraaAioContextIntParameterFunc>>(
            'mraa_aio_init');
    _readPointer =
        _lib.lookup<NativeFunction<_returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_read');
    _readDoublePointer =
        _lib.lookup<NativeFunction<_returnFloatMraaAioContextParameterFunc>>(
            'mraa_aio_read_float');
    _closePointer =
        _lib.lookup<NativeFunction<_returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_close');
    _setBitPointer =
        _lib.lookup<NativeFunction<_returnIntMraaAioContextIntParameterFunc>>(
            'mraa_aio_set_bit');
    _getBitPointer =
        _lib.lookup<NativeFunction<_returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_get_bit');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaAioInitialiseType>();
    _readFunc = _readPointer.asFunction<_MraaAioReadType>();
    _readDoubleFunc = _readDoublePointer.asFunction<_MraaAioReadDoubleType>();
    _closeFunc = _closePointer.asFunction<_MraaAioCloseType>();
    _setBitFunc = _setBitPointer.asFunction<_MraaAioSetBitType>();
    _getBitFunc = _getBitPointer.asFunction<_MraaAioGetBitType>();
  }
}
