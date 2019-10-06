/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef returnMraaAioContextIntParameterFunc = ffi.Pointer<MraaAioContext>
    Function(ffi.Int32);
typedef returnIntMraaAioContextParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaAioContext>);

/// Dart Function typedefs
typedef MraaAioInitialiseType = ffi.Pointer<MraaAioContext> Function(int);
typedef MraaAioReadType = int Function(ffi.Pointer<MraaAioContext>);

/// The AIO MRAA API
class _MraaAio {
  _MraaAio(this._lib) {
    _setUpPointers();
    _setUpFunctions();
  }

  static const int mraaAioReadError = -1;

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>
      _initPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>
      _readPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _readFunc;

  /// Initialise - mraa_aio_init
  /// Initialise an Analog input device, connected to the specified pin.
  /// Aio pins are always 0 indexed reguardless of their position.
  /// Check your board mapping for details.
  /// An arduino style layout will have A0 as pin14 but AIO0.
  ffi.Pointer<MraaAioContext> initialise(int pin) => _initFunc(pin);

  /// Read - mraa_aio_read
  /// Read the input voltage. By default mraa will shift the raw value
  /// up or down to a 10 bit value.
  /// Returns The current input voltage or -1 for error
  int read(ffi.Pointer<MraaAioContext> dev) => _readFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>(
            'mraa_aio_init');
    _readPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaAioContextParameterFunc>>(
            'mraa_aio_read');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaAioInitialiseType>();
    _readFunc = _readPointer.asFunction<MraaAioReadType>();
  }
}
