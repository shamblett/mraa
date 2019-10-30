/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaLedContextIntParameterFunc = Pointer<MraaLedContext> Function(
    Int32);
typedef returnMraaLedContextStringParameterFunc = Pointer<MraaLedContext>
    Function(Pointer<ffi.Utf8>);
typedef returnIntMraaLedContextIntParameterFunc = Int32 Function(
    Pointer<MraaLedContext>, Int32);
typedef returnIntMraaLedContextParameterFunc = Int32 Function(
    Pointer<MraaLedContext>);
typedef returnIntMraaLedContextStringParameterFunc = Int32 Function(
    Pointer<MraaLedContext>, Pointer<ffi.Utf8>);

/// Dart Function typedefs
typedef MraaLedInitialiseType = Pointer<MraaLedContext> Function(int);
typedef MraaLedInitialiseRawType = Pointer<MraaLedContext> Function(
    Pointer<ffi.Utf8>);
typedef MraaLedSetBrightnessType = int Function(Pointer<MraaLedContext>, int);
typedef MraaLedReadBrightnessType = int Function(Pointer<MraaLedContext>);
typedef MraaLedReadMaxBrightnessType = int Function(Pointer<MraaLedContext>);
typedef MraaLedSetTriggerType = int Function(
    Pointer<MraaLedContext>, Pointer<ffi.Utf8>);
typedef MraaLedClearTriggerType = int Function(Pointer<MraaLedContext>);
typedef MraaLedCloseType = int Function(Pointer<MraaLedContext>);

/// The LED MRAA API
/// LED is the Light Emitting Diode interface to libmraa.
/// It is used to access the on board LED's via sysfs.
class MraaLed {
  /// Construction
  MraaLed(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaLedContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaLedContextStringParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<returnIntMraaLedContextIntParameterFunc>>
      _setBrightnessPointer;
  Pointer<NativeFunction<returnIntMraaLedContextParameterFunc>>
      _readBrightnessPointer;
  Pointer<NativeFunction<returnIntMraaLedContextParameterFunc>>
      _readMaxBrightnessPointer;
  Pointer<NativeFunction<returnIntMraaLedContextStringParameterFunc>>
      _setTriggerPointer;
  Pointer<NativeFunction<returnIntMraaLedContextParameterFunc>>
      _clearTriggerPointer;
  Pointer<NativeFunction<returnIntMraaLedContextParameterFunc>> _closePointer;

  /// Dart Functions
  MraaLedInitialiseType _initFunc;
  MraaLedInitialiseRawType _initRawFunc;
  MraaLedSetBrightnessType _setBrightnessFunc;
  MraaLedReadBrightnessType _readBrightnessFunc;
  MraaLedReadMaxBrightnessType _readMaxBrightnessFunc;
  MraaLedSetTriggerType _setTriggerFunc;
  MraaLedClearTriggerType _clearTriggerFunc;
  MraaLedCloseType _closeFunc;

  /// Initialise - mraa_led_init
  /// Initialise led context, based on led index.
  /// Returns the led context or null
  Pointer<MraaLedContext> initialise(int led) => _initFunc(led);

  /// Initialise raw - mraa_led_init_raw
  /// Initialise the led context, based on led function name.
  /// The structure of LED entry in sysfs is "devicename:colour:function"
  /// This method expects only one unique LED identifier which would be "function" name most often.
  /// For instance, initialiseRaw("user4")
  Pointer<MraaLedContext> initialiseRaw(String ledDev) =>
      _initRawFunc(ffi.Utf8.toUtf8(ledDev));

  /// Set brightness - mraa_led_set_brightness
  /// Set LED brightness
  MraaReturnCode setBrightness(Pointer<MraaLedContext> dev, int value) =>
      returnCode.fromInt(_setBrightnessFunc(dev, value));

  /// Read brightness - mraa_led_read_brightness
  /// Read LED brightness
  int readBrightness(Pointer<MraaLedContext> dev) => _readBrightnessFunc(dev);

  /// Read brightness - mraa_led_read_max_brightness
  /// Read LED maximum brightness
  int readMaxBrightness(Pointer<MraaLedContext> dev) =>
      _readMaxBrightnessFunc(dev);

  /// Set trigger - mraa_led_set_trigger
  /// Set LED trigger to the trigger name supplied.
  MraaReturnCode setTrigger(Pointer<MraaLedContext> dev, String triggerName) =>
      returnCode.fromInt(_setTriggerFunc(dev, ffi.Utf8.toUtf8(triggerName)));

  /// Clear trigger - mraa_led_clear_trigger
  /// Clear active LED trigger
  MraaReturnCode clearTrigger(Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_clearTriggerFunc(dev));

  /// Close - mraa_led_close
  /// Close LED file descriptors and free the context memory.
  MraaReturnCode close(Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaLedContextIntParameterFunc>>(
            'mraa_led_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaLedContextStringParameterFunc>>(
            'mraa_led_init_raw');
    _setBrightnessPointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextIntParameterFunc>>(
            'mraa_led_set_brightness');
    _readBrightnessPointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_brightness');
    _readMaxBrightnessPointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_max_brightness');
    _setTriggerPointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextStringParameterFunc>>(
            'mraa_led_set_trigger');
    _clearTriggerPointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_clear_trigger');
    _closePointer =
        _lib.lookup<NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_close');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaLedInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaLedInitialiseRawType>();
    _setBrightnessFunc =
        _setBrightnessPointer.asFunction<MraaLedSetBrightnessType>();
    _readBrightnessFunc =
        _readBrightnessPointer.asFunction<MraaLedReadBrightnessType>();
    _readMaxBrightnessFunc =
        _readMaxBrightnessPointer.asFunction<MraaLedReadMaxBrightnessType>();
    _setTriggerFunc = _setTriggerPointer.asFunction<MraaLedSetTriggerType>();
    _clearTriggerFunc =
        _clearTriggerPointer.asFunction<MraaLedClearTriggerType>();
    _closeFunc = _closePointer.asFunction<MraaLedCloseType>();
  }
}
