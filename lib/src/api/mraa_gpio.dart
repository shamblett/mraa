/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef returnMraaContextIntParameterFunc = ffi.Pointer<MraaGpioContext>
    Function(ffi.Int32);

/// Dart Function typedefs
typedef MraaContextType = ffi.Pointer<MraaGpioContext> Function(int);

/// The GPIO MRAA Api
class _MraaGpio {
  _MraaGpio(this._lib) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaContextIntParameterFunc>>
      _initPointer;

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_gpio_init
  /// Initialise gpio_context, based on board number
  ffi.Pointer<MraaGpioContext> initialise(int pin) => _initFunc(pin);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaContextIntParameterFunc>>(
            'mraa_gpio_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaContextType>();
  }
}
