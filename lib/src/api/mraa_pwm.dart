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
  MraaPwm(this._lib, this._noJsonLoading, this._useGrovePi) {
    _setUpPointers();
    _setUpFunctions();
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  final bool _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  /// C Pointers
  late Pointer<NativeFunction<_returnMraaPwmContextIntParameterFunc>>
      _initPointer;
  late Pointer<NativeFunction<_returnMraaPwmContextIntIntParameterFunc>>
      _initRawPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _writePointer;
  late Pointer<NativeFunction<_returnDoubleMraaPwmContextParameterFunc>>
      _readPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _periodPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _periodMsPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _periodUsPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextFloatParameterFunc>>
      _pulseWidthPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthMsPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _pulseWidthUsPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _enablePointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextIntParameterFunc>>
      _ownerPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>>
      _closePointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>>
      _maxPeriodPointer;
  late Pointer<NativeFunction<_returnIntMraaPwmContextParameterFunc>>
      _minPeriodPointer;

  /// Dart Functions
  late _MraaPwmInitialiseType _initFunc;
  late _MraaPwmInitialiseRawType _initRawFunc;
  late _MraaPwmWriteType _writeFunc;
  late _MraaPwmReadType _readFunc;
  late _MraaPwmPeriodType _periodFunc;
  late _MraaPwmPeriodMsType _periodMsFunc;
  late _MraaPwmPeriodUsType _periodUsFunc;
  late _MraaPwmPulseWidthType _pulseWidthFunc;
  late _MraaPwmPulseWidthMsType _pulseWidthMsFunc;
  late _MraaPwmPulseWidthUsType _pulseWidthUsFunc;
  late _MraaPwmEnableType _enableFunc;
  late _MraaPwmOwnerType _ownerFunc;
  late _MraaPwmCloseType _closeFunc;
  late _MraaPwmMaxPeriodType _maxPeriodFunc;
  late _MraaPwmMinPeriodType _minPeriodFunc;

  /// Initialise - mraa_pwm_init
  ///
  /// Initialise an [MraaPwmContext] uses board mapping
  /// Returns pwm context or NULL.
  Pointer<MraaPwmContext> initialise(int pin) =>
      _initFunc(pin + _grovePiPinOffset);

  /// Initialise raw - mraa_pwm_init_raw
  ///
  /// Initialise an [MraaPwmContext], raw mode, uses the
  /// chip in which the PWM is under in SYSFS.
  Pointer<MraaPwmContext> initialiseRaw(int chipId, int pin) =>
      _initRawFunc(chipId, pin + _grovePiPinOffset);

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
