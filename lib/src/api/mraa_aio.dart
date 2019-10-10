/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaAioContextIntParameterFunc = ffi.Pointer<MraaAioContext>
    Function(ffi.Int32);
typedef returnIntMraaAioContextParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaAioContext>);
typedef returnDoubleMraaAioContextParameterFunc = ffi.Double Function(
    ffi.Pointer<MraaAioContext>);
typedef returnIntMraaAioContextIntParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaAioContext>, ffi.Int32);

/// Dart Function typedefs
typedef MraaAioInitialiseType = ffi.Pointer<MraaAioContext> Function(int);
typedef MraaAioReadType = int Function(ffi.Pointer<MraaAioContext>);
typedef MraaAioReadDoubleType = double Function(ffi.Pointer<MraaAioContext>);
typedef MraaAioCloseType = int Function(ffi.Pointer<MraaAioContext>);
typedef MraaAioSetBitType = int Function(ffi.Pointer<MraaAioContext>, int);
typedef MraaAioGetBitType = int Function(ffi.Pointer<MraaAioContext>);

/// The AIO MRAA API
class _MraaAio {
  _MraaAio(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>
      _initPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>
      _readPointer;
  ffi.Pointer<ffi.NativeFunction<returnDoubleMraaAioContextParameterFunc>>
      _readDoublePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>
      _closePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaAioContextIntParameterFunc>>
      _setBitPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>
      _getBitPointer;

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
  ffi.Pointer<MraaAioContext> initialise(int pin) => _initFunc(pin);

  /// Read - mraa_aio_read_float
  /// Read the input voltage and return it as a normalized float (0.0f-1.0f).
  /// Returns The current input voltage or -1.0 for error
  double readDouble(ffi.Pointer<MraaAioContext> dev) => _readDoubleFunc(dev);

  /// Read - mraa_aio_read
  /// Read the input voltage. By default mraa will shift the raw value
  /// up or down to a 10 bit value.
  /// Returns The current input voltage or -1 for error
  int read(ffi.Pointer<MraaAioContext> dev) => _readFunc(dev);

  /// Close - mraa_aio_close
  /// Close the analog input context, this will free the memory for the context.
  /// MRAA_SUCCESS indicates correct closure
  MraaReturnCodes close(ffi.Pointer<MraaAioContext> dev) =>
      returnCodes.fromInt(_closeFunc(dev));

  /// Set bit - mraa_aio_set_bit
  /// Set the bit value which mraa will shift the raw reading from the ADC to. I.e. 10bits
  MraaReturnCodes setBit(ffi.Pointer<MraaAioContext> dev, int bits) =>
      returnCodes.fromInt(_setBitFunc(dev, bits));

  /// Set bit - mraa_aio_get_bit
  /// Gets the bit value mraa is shifting the analog read to.
  int getBit(ffi.Pointer<MraaAioContext> dev) => _getBitFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>(
            'mraa_aio_init');
    _readPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_read');
    _readDoublePointer = _lib
        .lookup<ffi.NativeFunction<returnDoubleMraaAioContextParameterFunc>>(
            'mraa_aio_read_float');
    _closePointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_close');
    _setBitPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaAioContextIntParameterFunc>>(
            'mraa_aio_set_bit');
    _getBitPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>(
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
