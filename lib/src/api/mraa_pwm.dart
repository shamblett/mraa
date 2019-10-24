/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaPwmContextIntParameterFunc = ffi.Pointer<MraaPwmContext>
    Function(ffi.Int32);
typedef returnMraaPwmContextIntIntParameterFunc = ffi.Pointer<MraaPwmContext>
    Function(ffi.Int32, ffi.Int32);
typedef returnIntMraaPwmContextFloatParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaPwmContext>, ffi.Double);
typedef returnDoubleMraaPwmContextParameterFunc = ffi.Double Function(
    ffi.Pointer<MraaPwmContext>);

/// Dart Function typedefs
typedef MraaPwmInitialiseType = ffi.Pointer<MraaPwmContext> Function(int);
typedef MraaPwmInitialiseRawType = ffi.Pointer<MraaPwmContext> Function(
    int, int);
typedef MraaPwmWriteType = int Function(ffi.Pointer<MraaPwmContext>, double);
typedef MraaPwmReadType = double Function(ffi.Pointer<MraaPwmContext>);
typedef MraaPwmPeriodType = int Function(ffi.Pointer<MraaPwmContext>, double);

/// The PWM MRAA API
/// PWM is the Pulse Width Modulation interface to libmraa.
/// It allows the generation of a signal on a pin. Some boards may have higher or
/// lower levels of resolution so make sure you check the board & pin you
/// are using before hand.
class _MraaPwm {
  _MraaPwm(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaPwmContextIntParameterFunc>>
      _initPointer;
  ffi.Pointer<ffi.NativeFunction<returnMraaPwmContextIntIntParameterFunc>>
      _initRawPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _writePointer;
  ffi.Pointer<ffi.NativeFunction<returnDoubleMraaPwmContextParameterFunc>>
      _readPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _periodPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _writeFunc;
  dynamic _readFunc;
  dynamic _periodFunc;

  /// Initialise - mraa_pwm_init
  /// Initialise pwm_context, uses board mapping
  /// Returns pwm context or NULL.
  ffi.Pointer<MraaPwmContext> initialise(int pin) => _initFunc(pin);

  /// Initialise raw - mraa_pwm_init_raw
  /// Initialise pwm context, raw mode, uses the
  /// chip in which the PWM is under in SYSFS.
  ffi.Pointer<MraaPwmContext> initialiseRaw(int chipId, int pin) =>
      _initRawFunc(chipId, pin);

  /// Write - mraa_pwm_write
  /// Set the output duty-cycle percentage, as a double
  /// The percentage value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f
  MraaReturnCode write(ffi.Pointer<MraaPwmContext> dev, double percentage) =>
      returnCode.fromInt(_writeFunc(dev, percentage));

  /// Read - mraa_pwm_read
  /// Read the output duty-cycle percentage, as a double
  /// Returns a floating-point value representing percentage of output.
  /// The value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f.
  double read(ffi.Pointer<MraaPwmContext> dev) => _readFunc(dev);

  /// Period - mraa_pwm_period
  /// Set the PWM period as seconds represented in a float
  MraaReturnCode period(ffi.Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_periodFunc(dev, seconds));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_init');
    _initRawPointer = _lib
        .lookup<ffi.NativeFunction<returnMraaPwmContextIntIntParameterFunc>>(
            'mraa_pwm_init_raw');
    _writePointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_write');
    _readPointer = _lib
        .lookup<ffi.NativeFunction<returnDoubleMraaPwmContextParameterFunc>>(
            'mraa_pwm_read');
    _periodPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_period');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaPwmInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaPwmInitialiseRawType>();
    _writeFunc = _writePointer.asFunction<MraaPwmWriteType>();
    _readFunc = _readPointer.asFunction<MraaPwmReadType>();
    _periodFunc = _periodPointer.asFunction<MraaPwmPeriodType>();
  }
}
