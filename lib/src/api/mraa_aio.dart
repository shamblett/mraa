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

/// Dart Function typedefs
typedef MraaAioContextType = ffi.Pointer<MraaAioContext> Function(int);

/// The AIO MRAA API
class _MraaAio {
  _MraaAio(this._lib) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>
      _initPointer;

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_aio_init
  /// Initialise an Analog input device, connected to the specified pin.
  /// Aio pins are always 0 indexed reguardless of their position.
  /// Check your board mapping for details.
  /// An arduino style layout will have A0 as pin14 but AIO0.
  ffi.Pointer<MraaAioContext> initialise(int pin) => _initFunc(pin);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaAioContextIntParameterFunc>>(
            'mraa_aio_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaAioContextType>();
  }
}
