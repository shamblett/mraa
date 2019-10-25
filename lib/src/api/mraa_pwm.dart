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
typedef returnIntMraaPwmContextIntParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaPwmContext>, ffi.Int32);

/// Dart Function typedefs
typedef MraaPwmInitialiseType = ffi.Pointer<MraaPwmContext> Function(int);
typedef MraaPwmInitialiseRawType = ffi.Pointer<MraaPwmContext> Function(
    int, int);
typedef MraaPwmWriteType = int Function(ffi.Pointer<MraaPwmContext>, double);
typedef MraaPwmReadType = double Function(ffi.Pointer<MraaPwmContext>);
typedef MraaPwmPeriodType = int Function(ffi.Pointer<MraaPwmContext>, double);
typedef MraaPwmPeriodMsType = int Function(ffi.Pointer<MraaPwmContext>, int);
typedef MraaPwmPeriodUsType = int Function(ffi.Pointer<MraaPwmContext>, int);
typedef MraaPwmPulseWidthType = int Function(
    ffi.Pointer<MraaPwmContext>, double);
typedef MraaPwmPulseWidthMsType = int Function(
    ffi.Pointer<MraaPwmContext>, int);
typedef MraaPwmPulseWidthUsType = int Function(
    ffi.Pointer<MraaPwmContext>, int);
typedef MraaPwmEnableType = int Function(ffi.Pointer<MraaPwmContext>, int);

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
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _periodMsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _periodUsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _pulseWidthPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthMsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthUsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _enablePointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _writeFunc;
  dynamic _readFunc;
  dynamic _periodFunc;
  dynamic _periodMsFunc;
  dynamic _periodUsFunc;
  dynamic _pulseWidthFunc;
  dynamic _pulseWidthMsFunc;
  dynamic _pulseWidthUsFunc;
  dynamic _enableFunc;

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

  /// Period milliseconds - mraa_pwm_period_ms
  /// Set the PWM period as milliseconds
  MraaReturnCode periodMs(ffi.Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_periodMsFunc(dev, milliseconds));

  /// Period microseconds - mraa_pwm_period_us
  /// Set the PWM period as microseconds
  MraaReturnCode periodUs(ffi.Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_periodUsFunc(dev, microseconds));

  /// Pulse width - mraa_pwm_pulsewidth
  /// Set the PWM pulse width as seconds represented in a float
  MraaReturnCode pulseWidth(ffi.Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_pulseWidthFunc(dev, seconds));

  /// Pulse width milliseconds - mraa_pwm_pulsewidth_ms
  /// Set the PWM pulsewidth  as milliseconds
  MraaReturnCode pulseWidthMs(
          ffi.Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_pulseWidthMsFunc(dev, milliseconds));

  /// Pulse width microseconds - mraa_pwm_pulsewidth_us
  /// Set the PWM pulse width as microseconds
  MraaReturnCode pulseWidthUs(
          ffi.Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_pulseWidthUsFunc(dev, microseconds));

  /// Enable - mraa_pwm_enable
  /// Set the enable status of the PWM pin.
  /// None zero will assume on with output being driven. and 0 will disable the output.
  MraaReturnCode enable(ffi.Pointer<MraaPwmContext> dev, int enable) =>
      returnCode.fromInt(_enableFunc(dev, enable));

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
    _periodMsPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_ms');
    _periodUsPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_us');
    _pulseWidthPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_pulsewidth');
    _pulseWidthMsPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_ms');
    _pulseWidthUsPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_us');
    _enablePointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_enable');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaPwmInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaPwmInitialiseRawType>();
    _writeFunc = _writePointer.asFunction<MraaPwmWriteType>();
    _readFunc = _readPointer.asFunction<MraaPwmReadType>();
    _periodFunc = _periodPointer.asFunction<MraaPwmPeriodType>();
    _periodMsFunc = _periodMsPointer.asFunction<MraaPwmPeriodMsType>();
    _periodUsFunc = _periodUsPointer.asFunction<MraaPwmPeriodUsType>();
    _pulseWidthFunc = _pulseWidthPointer.asFunction<MraaPwmPulseWidthType>();
    _pulseWidthMsFunc =
        _pulseWidthMsPointer.asFunction<MraaPwmPulseWidthMsType>();
    _pulseWidthUsFunc =
        _pulseWidthUsPointer.asFunction<MraaPwmPulseWidthUsType>();
    _enableFunc = _enablePointer.asFunction<MraaPwmEnableType>();
  }
}
