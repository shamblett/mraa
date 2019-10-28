/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaPwmContextIntParameterFunc = Pointer<MraaPwmContext> Function(
    Int32);
typedef returnMraaPwmContextIntIntParameterFunc = Pointer<MraaPwmContext>
    Function(Int32, Int32);
typedef returnIntMraaPwmContextFloatParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>, Double);
typedef returnDoubleMraaPwmContextParameterFunc = Double Function(
    Pointer<MraaPwmContext>);
typedef returnIntMraaPwmContextIntParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>, Int32);
typedef returnIntMraaPwmContextParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>);

/// Dart Function typedefs
typedef MraaPwmInitialiseType = Pointer<MraaPwmContext> Function(int);
typedef MraaPwmInitialiseRawType = Pointer<MraaPwmContext> Function(int, int);
typedef MraaPwmWriteType = int Function(Pointer<MraaPwmContext>, double);
typedef MraaPwmReadType = double Function(Pointer<MraaPwmContext>);
typedef MraaPwmPeriodType = int Function(Pointer<MraaPwmContext>, double);
typedef MraaPwmPeriodMsType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmPeriodUsType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmPulseWidthType = int Function(Pointer<MraaPwmContext>, double);
typedef MraaPwmPulseWidthMsType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmPulseWidthUsType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmEnableType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmOwnerType = int Function(Pointer<MraaPwmContext>, int);
typedef MraaPwmCloseType = int Function(Pointer<MraaPwmContext>);
typedef MraaPwmMaxPeriodType = int Function(Pointer<MraaPwmContext>);

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
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaPwmContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaPwmContextIntIntParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<returnDoubleMraaPwmContextParameterFunc>> _readPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _periodPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _periodMsPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _periodUsPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>
      _pulseWidthPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthMsPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthUsPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _enablePointer;
  Pointer<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>
      _ownerPointer;
  Pointer<NativeFunction<returnIntMraaPwmContextParameterFunc>> _closePointer;
  Pointer<NativeFunction<returnIntMraaPwmContextParameterFunc>>
      _maxPeriodPointer;

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
  dynamic _ownerFunc;
  dynamic _closeFunc;
  dynamic _maxPeriodFunc;

  /// Initialise - mraa_pwm_init
  /// Initialise pwm_context, uses board mapping
  /// Returns pwm context or NULL.
  Pointer<MraaPwmContext> initialise(int pin) => _initFunc(pin);

  /// Initialise raw - mraa_pwm_init_raw
  /// Initialise pwm context, raw mode, uses the
  /// chip in which the PWM is under in SYSFS.
  Pointer<MraaPwmContext> initialiseRaw(int chipId, int pin) =>
      _initRawFunc(chipId, pin);

  /// Write - mraa_pwm_write
  /// Set the output duty-cycle percentage, as a double
  /// The percentage value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f
  MraaReturnCode write(Pointer<MraaPwmContext> dev, double percentage) =>
      returnCode.fromInt(_writeFunc(dev, percentage));

  /// Read - mraa_pwm_read
  /// Read the output duty-cycle percentage, as a double
  /// Returns a floating-point value representing percentage of output.
  /// The value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f.
  double read(Pointer<MraaPwmContext> dev) => _readFunc(dev);

  /// Period - mraa_pwm_period
  /// Set the PWM period as seconds represented in a float
  MraaReturnCode period(Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_periodFunc(dev, seconds));

  /// Period milliseconds - mraa_pwm_period_ms
  /// Set the PWM period as milliseconds
  MraaReturnCode periodMs(Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_periodMsFunc(dev, milliseconds));

  /// Period microseconds - mraa_pwm_period_us
  /// Set the PWM period as microseconds
  MraaReturnCode periodUs(Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_periodUsFunc(dev, microseconds));

  /// Pulse width - mraa_pwm_pulsewidth
  /// Set the PWM pulse width as seconds represented in a float
  MraaReturnCode pulseWidth(Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_pulseWidthFunc(dev, seconds));

  /// Pulse width milliseconds - mraa_pwm_pulsewidth_ms
  /// Set the PWM pulsewidth  as milliseconds
  MraaReturnCode pulseWidthMs(Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_pulseWidthMsFunc(dev, milliseconds));

  /// Pulse width microseconds - mraa_pwm_pulsewidth_us
  /// Set the PWM pulse width as microseconds
  MraaReturnCode pulseWidthUs(Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_pulseWidthUsFunc(dev, microseconds));

  /// Enable - mraa_pwm_enable
  /// Set the enable status of the PWM pin.
  /// None zero will assume on with output being driven. and 0 will disable the output.
  MraaReturnCode enable(Pointer<MraaPwmContext> dev, int enable) =>
      returnCode.fromInt(_enableFunc(dev, enable));

  /// Owner - mraa_pwm_owner
  /// Change(take) ownership of context
  /// True indicates take ownership
  MraaReturnCode owner(Pointer<MraaPwmContext> dev, bool owner) {
    final int rawBool = owner ? 1 : 0;
    return returnCode.fromInt(_ownerFunc(dev, rawBool));
  }

  /// Close - mraa_pwm_close
  /// Close and unexport the PWM pin
  MraaReturnCode close(Pointer<MraaPwmContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Maximum period - mraa_pwm_get_max_period
  /// Get the maximum pwm period in us
  int maxPeriod(Pointer<MraaPwmContext> dev) => _maxPeriodFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaPwmContextIntIntParameterFunc>>(
            'mraa_pwm_init_raw');
    _writePointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_write');
    _readPointer =
        _lib.lookup<NativeFunction<returnDoubleMraaPwmContextParameterFunc>>(
            'mraa_pwm_read');
    _periodPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_period');
    _periodMsPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_ms');
    _periodUsPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_us');
    _pulseWidthPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_pulsewidth');
    _pulseWidthMsPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_ms');
    _pulseWidthUsPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_us');
    _enablePointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_enable');
    _ownerPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_owner');
    _closePointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextParameterFunc>>(
            'mraa_pwm_close');
    _maxPeriodPointer =
        _lib.lookup<NativeFunction<returnIntMraaPwmContextParameterFunc>>(
            'mraa_pwm_get_max_period');
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
    _ownerFunc = _ownerPointer.asFunction<MraaPwmOwnerType>();
    _closeFunc = _closePointer.asFunction<MraaPwmCloseType>();
    _maxPeriodFunc = _maxPeriodPointer.asFunction<MraaPwmMaxPeriodType>();
  }
}
