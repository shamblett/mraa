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
typedef returnMraaGpioContextIntArrayIntParameterFunc
    = ffi.Pointer<MraaGpioContext> Function(ffi.Pointer<ffi.Int32>, ffi.Int32);

/// Dart Function typedefs
typedef MraaGpioInitialiseType = ffi.Pointer<MraaGpioContext> Function(int);
typedef MraaGpioDirectionType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioReadType = int Function(ffi.Pointer<MraaGpioContext>);
typedef MraaGpioInitialiseMultiType = ffi.Pointer<MraaGpioContext> Function(
    ffi.Pointer<ffi.Int32>, int);

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
      _initialisePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _directionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextParametersFunc>>
      _readPointer;
  ffi.Pointer<ffi.NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>
      _initialiseMultiPointer;

  /// Dart Functions
  dynamic _initialiseFunc;
  dynamic _directionFunc;
  dynamic _readFunc;
  dynamic _initialiseMultiFunc;

  /// Initialise - mraa_gpio_init
  /// Initialise gpio_context, based on board number
  ffi.Pointer<MraaGpioContext> initialise(int pin) => _initialiseFunc(pin);

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

  /// Initialise multi - mraa_gpio_init_multi
  /// Initialise gpio_context, based on board number, for multiple pins (can be one).
  ffi.Pointer<MraaGpioContext> initialiseMulti(List<int> pins, int numPins) {
    final ffi.Pointer<ffi.Int32> mpins =
        ffi.Pointer<ffi.Int32>.allocate(count: numPins);
    final Int32List values = Int32List.fromList(pins);
    final Int32List dataItems = mpins.asExternalTypedData(count: values.length);
    final int length = values.length;
    for (int i = 0; i < length; i++) {
      dataItems[i] = values[i];
    }
    return _initialiseMultiFunc(mpins, numPins);
  }

  void _setUpPointers() {
    _initialisePointer =
        _lib.lookup<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init');
    _directionPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_dir');
    _readPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_read');
    _initialiseMultiPointer = _lib.lookup<
            ffi.NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>(
        'mraa_gpio_init_multi');
  }

  void _setUpFunctions() {
    _initialiseFunc = _initialisePointer.asFunction<MraaGpioInitialiseType>();
    _directionFunc = _directionPointer.asFunction<MraaGpioDirectionType>();
    _readFunc = _readPointer.asFunction<MraaGpioReadType>();
    _initialiseMultiFunc =
        _initialiseMultiPointer.asFunction<MraaGpioInitialiseMultiType>();
  }
}
