/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef _returnMraaPwmContextIntParameterFunc = Pointer<MraaPwmContext>
    Function(Int32);
typedef _returnMraaPwmContextIntIntParameterFunc = Pointer<MraaPwmContext>
    Function(Int32, Int32);
typedef _returnIntMraaPwmContextFloatParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>, Double);
typedef _returnDoubleMraaPwmContextParameterFunc = Double Function(
    Pointer<MraaPwmContext>);
typedef _returnIntMraaPwmContextIntParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>, Int32);
typedef _returnIntMraaPwmContextParameterFunc = Int32 Function(
    Pointer<MraaPwmContext>);

/// Dart Function typedefs
typedef _MraaPwmInitialiseType = Pointer<MraaPwmContext> Function(int);
typedef _MraaPwmInitialiseRawType = Pointer<MraaPwmContext> Function(int, int);
typedef _MraaPwmWriteType = int Function(Pointer<MraaPwmContext>, double);
typedef _MraaPwmReadType = double Function(Pointer<MraaPwmContext>);
typedef _MraaPwmPeriodType = int Function(Pointer<MraaPwmContext>, double);
typedef _MraaPwmPeriodMsType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmPeriodUsType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmPulseWidthType = int Function(Pointer<MraaPwmContext>, double);
typedef _MraaPwmPulseWidthMsType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmPulseWidthUsType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmEnableType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmOwnerType = int Function(Pointer<MraaPwmContext>, int);
typedef _MraaPwmCloseType = int Function(Pointer<MraaPwmContext>);
typedef _MraaPwmMaxPeriodType = int Function(Pointer<MraaPwmContext>);
typedef _MraaPwmMinPeriodType = int Function(Pointer<MraaPwmContext>);

/// The PWM MRAA API
///
/// PWM is the Pulse Width Modulation interface to MRAA.
/// It allows the generation of a signal on a pin. Some boards may
/// have higher or lower levels of resolution so make sure you
/// check the board & pin you are using before hand.
class MraaPwm {
  /// Construction
  MraaPwm(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// C Pointers
  Pointer<NativeFunction<_returnMraaPwmContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<_returnMraaPwmContextIntIntParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _writePointer;
  Pointer<NativeFunction<_returnDoubleMraaPwmContextParameterFunc>>
      _readPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _periodPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _periodMsPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _periodUsPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _pulseWidthPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthMsPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthUsPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _enablePointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _ownerPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>> _closePointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>>
      _maxPeriodPointer;
  Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>>
      _minPeriodPointer;

  /// Dart Functions
  _MraaPwmInitialiseType _initFunc;
  _MraaPwmInitialiseRawType _initRawFunc;
  _MraaPwmWriteType _writeFunc;
  _MraaPwmReadType _readFunc;
  _MraaPwmPeriodType _periodFunc;
  _MraaPwmPeriodMsType _periodMsFunc;
  _MraaPwmPeriodUsType _periodUsFunc;
  _MraaPwmPulseWidthType _pulseWidthFunc;
  _MraaPwmPulseWidthMsType _pulseWidthMsFunc;
  _MraaPwmPulseWidthUsType _pulseWidthUsFunc;
  _MraaPwmEnableType _enableFunc;
  _MraaPwmOwnerType _ownerFunc;
  _MraaPwmCloseType _closeFunc;
  _MraaPwmMaxPeriodType _maxPeriodFunc;
  _MraaPwmMinPeriodType _minPeriodFunc;

  /// Initialise - mraa_pwm_init
  ///
  /// Initialise an [MraaPwmContext] uses board mapping
  /// Returns pwm context or NULL.
  Pointer<MraaPwmContext> initialise(int pin) => _initFunc(pin);

  /// Initialise raw - mraa_pwm_init_raw
  ///
  /// Initialise an [MraaPwmContext], raw mode, uses the
  /// chip in which the PWM is under in SYSFS.
  Pointer<MraaPwmContext> initialiseRaw(int chipId, int pin) =>
      _initRawFunc(chipId, pin);

  /// Write - mraa_pwm_write
  ///
  /// Set the output duty-cycle percentage, as a double.
  /// The percentage value should lie between 0.0f
  /// (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f
  MraaReturnCode write(Pointer<MraaPwmContext> dev, double percentage) =>
      returnCode.fromInt(_writeFunc(dev, percentage));

  /// Read - mraa_pwm_read
  ///
  /// Read the output duty-cycle percentage, as a double
  /// Returns a floating-point value representing percentage of output.
  /// The value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f.
  double read(Pointer<MraaPwmContext> dev) => _readFunc(dev);

  /// Period - mraa_pwm_period
  ///
  /// Set the PWM period as seconds represented in a double
  MraaReturnCode period(Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_periodFunc(dev, seconds));

  /// Period milliseconds - mraa_pwm_period_ms
  ///
  /// Set the PWM period in milliseconds
  MraaReturnCode periodMs(Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_periodMsFunc(dev, milliseconds));

  /// Period microseconds - mraa_pwm_period_us
  ///
  /// Set the PWM periodin microseconds
  MraaReturnCode periodUs(Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_periodUsFunc(dev, microseconds));

  /// Pulse width - mraa_pwm_pulsewidth
  ///
  /// Set the PWM pulse width as seconds represented in a double
  MraaReturnCode pulseWidth(Pointer<MraaPwmContext> dev, double seconds) =>
      returnCode.fromInt(_pulseWidthFunc(dev, seconds));

  /// Pulse width milliseconds - mraa_pwm_pulsewidth_ms
  ///
  /// Set the PWM pulse width  in milliseconds
  MraaReturnCode pulseWidthMs(Pointer<MraaPwmContext> dev, int milliseconds) =>
      returnCode.fromInt(_pulseWidthMsFunc(dev, milliseconds));

  /// Pulse width microseconds - mraa_pwm_pulsewidth_us
  ///
  /// Set the PWM pulse width in microseconds
  MraaReturnCode pulseWidthUs(Pointer<MraaPwmContext> dev, int microseconds) =>
      returnCode.fromInt(_pulseWidthUsFunc(dev, microseconds));

  /// Enable - mraa_pwm_enable
  ///
  /// Set the enable status of the PWM pin.
  /// None zero will assume on with output being driven. and 0 will
  /// disable the output.
  MraaReturnCode enable(Pointer<MraaPwmContext> dev, int enable) =>
      returnCode.fromInt(_enableFunc(dev, enable));

  /// Owner - mraa_pwm_owner
  ///
  /// Change(take) ownership of context
  /// Owner set to true indicates a take ownership
  MraaReturnCode owner(Pointer<MraaPwmContext> dev, bool owner) {
    final rawBool = owner ? 1 : 0;
    return returnCode.fromInt(_ownerFunc(dev, rawBool));
  }

  /// Close - mraa_pwm_close
  ///
  /// Close and unexport the PWM pin
  MraaReturnCode close(Pointer<MraaPwmContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Maximum period - mraa_pwm_get_max_period
  ///
  /// The maximum PWM period in us
  int maxPeriod(Pointer<MraaPwmContext> dev) => _maxPeriodFunc(dev);

  /// Minimum period - mraa_pwm_get_min_period
  ///
  /// The minimum PWM period in us
  int minPeriod(Pointer<MraaPwmContext> dev) => _minPeriodFunc(dev);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<_returnMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<_returnMraaPwmContextIntIntParameterFunc>>(
            'mraa_pwm_init_raw');
    _writePointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_write');
    _readPointer =
        _lib.lookup<NativeFunction<_returnDoubleMraaPwmContextParameterFunc>>(
            'mraa_pwm_read');
    _periodPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_period');
    _periodMsPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_ms');
    _periodUsPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_period_us');
    _pulseWidthPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>(
            'mraa_pwm_pulsewidth');
    _pulseWidthMsPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_ms');
    _pulseWidthUsPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_pulsewidth_us');
    _enablePointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_enable');
    _ownerPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_owner');
    _closePointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextParameterFunc>>(
            'mraa_pwm_close');
    _maxPeriodPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextParameterFunc>>(
            'mraa_pwm_get_max_period');
    _minPeriodPointer =
        _lib.lookup<NativeFunction<_returnIntMraaPwmContextParameterFunc>>(
            'mraa_pwm_get_min_period');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaPwmInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<_MraaPwmInitialiseRawType>();
    _writeFunc = _writePointer.asFunction<_MraaPwmWriteType>();
    _readFunc = _readPointer.asFunction<_MraaPwmReadType>();
    _periodFunc = _periodPointer.asFunction<_MraaPwmPeriodType>();
    _periodMsFunc = _periodMsPointer.asFunction<_MraaPwmPeriodMsType>();
    _periodUsFunc = _periodUsPointer.asFunction<_MraaPwmPeriodUsType>();
    _pulseWidthFunc = _pulseWidthPointer.asFunction<_MraaPwmPulseWidthType>();
    _pulseWidthMsFunc =
        _pulseWidthMsPointer.asFunction<_MraaPwmPulseWidthMsType>();
    _pulseWidthUsFunc =
        _pulseWidthUsPointer.asFunction<_MraaPwmPulseWidthUsType>();
    _enableFunc = _enablePointer.asFunction<_MraaPwmEnableType>();
    _ownerFunc = _ownerPointer.asFunction<_MraaPwmOwnerType>();
    _closeFunc = _closePointer.asFunction<_MraaPwmCloseType>();
    _maxPeriodFunc = _maxPeriodPointer.asFunction<_MraaPwmMaxPeriodType>();
    _minPeriodFunc = _minPeriodPointer.asFunction<_MraaPwmMinPeriodType>();
  }
}
