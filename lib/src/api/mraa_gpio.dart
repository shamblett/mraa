/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaGpioContextIntParameterFunc = ffi.Pointer<MraaGpioContext>
    Function(ffi.Int32);
typedef returnIntGpioContextIntParametersFunc = ffi.Int32 Function(
    ffi.Pointer<MraaGpioContext>, ffi.Int32);
typedef returnIntGpioContextParametersFunc = ffi.Int32 Function(
    ffi.Pointer<MraaGpioContext>);

/// Dart Function typedefs
typedef MraaGpioInitialiseType = ffi.Pointer<MraaGpioContext> Function(int);
typedef MraaGpioDirectionType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioReadType = int Function(ffi.Pointer<MraaGpioContext>);

/// The GPIO MRAA API
class _MraaGpio {
  _MraaGpio(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>
      _initPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _directionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextParametersFunc>>
      _readPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _directionFunc;
  dynamic _readFunc;
  dynamic _initMultiFunc;

  /// Initialise - mraa_gpio_init
  /// Initialise gpio_context, based on board number
  ffi.Pointer<MraaGpioContext> initialise(int pin) => _initFunc(pin);

  /// GPIO direction - mraa_gpio_dir
  /// Set Gpio(s) direction
  MraaReturnCode direction(
          ffi.Pointer<MraaGpioContext> context, MraaGpioDirection direction) =>
      returnCode
          .fromInt(_directionFunc(context, gpioDirections.asInt(direction)));

  /// Read - mraa_gpio_read
  /// Read the Gpio value. This can be 0 or 1.
  /// A response of -1 means that there was a fatal error.
  int read(ffi.Pointer<MraaGpioContext> context) => _readFunc(context);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init');
    _directionPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_dir');
    _readPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_read');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaGpioInitialiseType>();
    _directionFunc = _directionPointer.asFunction<MraaGpioDirectionType>();
    _readFunc = _readPointer.asFunction<MraaGpioReadType>();
  }
}
