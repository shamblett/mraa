/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs
typedef _returnMraaLedContextIntParameterFunc = Pointer<MraaLedContext>
    Function(Int32);
typedef _returnMraaLedContextStringParameterFunc = Pointer<MraaLedContext>
    Function(Pointer<ffi.Utf8>);
typedef _returnIntMraaLedContextIntParameterFunc = Int32 Function(
    Pointer<MraaLedContext>, Int32);
typedef _returnIntMraaLedContextParameterFunc = Int32 Function(
    Pointer<MraaLedContext>);
typedef _returnIntMraaLedContextStringParameterFunc = Int32 Function(
    Pointer<MraaLedContext>, Pointer<ffi.Utf8>);

/// Dart Function typedefs
typedef _MraaLedInitialiseType = Pointer<MraaLedContext> Function(int);
typedef _MraaLedInitialiseRawType = Pointer<MraaLedContext> Function(
    Pointer<ffi.Utf8>);
typedef _MraaLedSetBrightnessType = int Function(Pointer<MraaLedContext>, int);
typedef _MraaLedReadBrightnessType = int Function(Pointer<MraaLedContext>);
typedef _MraaLedReadMaxBrightnessType = int Function(Pointer<MraaLedContext>);
typedef _MraaLedSetTriggerType = int Function(
    Pointer<MraaLedContext>, Pointer<ffi.Utf8>);
typedef _MraaLedClearTriggerType = int Function(Pointer<MraaLedContext>);
typedef _MraaLedCloseType = int Function(Pointer<MraaLedContext>);

/// The LED MRAA API
///
/// LED is the Light Emitting Diode interface to MRAA
/// It is used to access the on board LED's via sysfs.
class MraaLed {
  /// Construction
  MraaLed(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  final DynamicLibrary? _lib;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// C Pointers
  late Pointer<NativeFunction<_returnMraaLedContextIntParameterFunc>>
      _initPointer;
  late Pointer<NativeFunction<_returnMraaLedContextStringParameterFunc>>
      _initRawPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextIntParameterFunc>>
      _setBrightnessPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextParameterFunc>>
      _readBrightnessPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextParameterFunc>>
      _readMaxBrightnessPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextStringParameterFunc>>
      _setTriggerPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextParameterFunc>>
      _clearTriggerPointer;
  late Pointer<NativeFunction<_returnIntMraaLedContextParameterFunc>>
      _closePointer;

  /// Dart Functions
  late _MraaLedInitialiseType _initFunc;
  late _MraaLedInitialiseRawType _initRawFunc;
  late _MraaLedSetBrightnessType _setBrightnessFunc;
  late _MraaLedReadBrightnessType _readBrightnessFunc;
  late _MraaLedReadMaxBrightnessType _readMaxBrightnessFunc;
  late _MraaLedSetTriggerType _setTriggerFunc;
  late _MraaLedClearTriggerType _clearTriggerFunc;
  late _MraaLedCloseType _closeFunc;

  /// Initialise - mraa_led_init
  ///
  /// Initialise a [MraaLedContext], based on LED index.
  /// Returns a a [MraaLedContext] or NULL
  Pointer<MraaLedContext> initialise(int led) => _initFunc(led);

  /// Initialise raw - mraa_led_init_raw
  ///
  /// Initialise a a [MraaLedContext] based on LED function name.
  /// The structure of a LED entry in sysfs is "devicename:colour:function"
  /// This method expects only one unique LED identifier which would be
  /// "function" name most often.
  /// For instance, initialiseRaw("user4")
  Pointer<MraaLedContext> initialiseRaw(String ledDev) =>
      _initRawFunc(ffi.Utf8.toUtf8(ledDev));

  /// Set brightness - mraa_led_set_brightness
  ///
  /// Set LED brightness
  MraaReturnCode? setBrightness(Pointer<MraaLedContext> dev, int value) =>
      returnCode.fromInt(_setBrightnessFunc(dev, value));

  /// Read brightness - mraa_led_read_brightness
  ///
  /// Read LED brightness
  int readBrightness(Pointer<MraaLedContext> dev) => _readBrightnessFunc(dev);

  /// Read brightness - mraa_led_read_max_brightness
  ///
  /// Read LED maximum brightness
  int readMaxBrightness(Pointer<MraaLedContext> dev) =>
      _readMaxBrightnessFunc(dev);

  /// Set trigger - mraa_led_set_trigger
  ///
  /// Set LED trigger to the trigger name supplied.
  MraaReturnCode? setTrigger(Pointer<MraaLedContext> dev, String triggerName) =>
      returnCode.fromInt(_setTriggerFunc(dev, ffi.Utf8.toUtf8(triggerName)));

  /// Clear trigger - mraa_led_clear_trigger
  ///
  /// Clear active LED trigger
  MraaReturnCode? clearTrigger(Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_clearTriggerFunc(dev));

  /// Close - mraa_led_close
  ///
  /// Close LED file descriptors and free the context memory.
  MraaReturnCode? close(Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  void _setUpPointers() {
    _initPointer = _lib!
        .lookup<NativeFunction<_returnMraaLedContextIntParameterFunc>>(
            'mraa_led_init');
    _initRawPointer = _lib!
        .lookup<NativeFunction<_returnMraaLedContextStringParameterFunc>>(
            'mraa_led_init_raw');
    _setBrightnessPointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextIntParameterFunc>>(
            'mraa_led_set_brightness');
    _readBrightnessPointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_brightness');
    _readMaxBrightnessPointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_max_brightness');
    _setTriggerPointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextStringParameterFunc>>(
            'mraa_led_set_trigger');
    _clearTriggerPointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextParameterFunc>>(
            'mraa_led_clear_trigger');
    _closePointer = _lib!
        .lookup<NativeFunction<_returnIntMraaLedContextParameterFunc>>(
            'mraa_led_close');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaLedInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<_MraaLedInitialiseRawType>();
    _setBrightnessFunc =
        _setBrightnessPointer.asFunction<_MraaLedSetBrightnessType>();
    _readBrightnessFunc =
        _readBrightnessPointer.asFunction<_MraaLedReadBrightnessType>();
    _readMaxBrightnessFunc =
        _readMaxBrightnessPointer.asFunction<_MraaLedReadMaxBrightnessType>();
    _setTriggerFunc = _setTriggerPointer.asFunction<_MraaLedSetTriggerType>();
    _clearTriggerFunc =
        _clearTriggerPointer.asFunction<_MraaLedClearTriggerType>();
    _closeFunc = _closePointer.asFunction<_MraaLedCloseType>();
  }
}
