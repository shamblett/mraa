/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaLedContextIntParameterFunc = ffi.Pointer<MraaLedContext>
    Function(ffi.Int32);
typedef returnMraaLedContextStringParameterFunc = ffi.Pointer<MraaLedContext>
    Function(ffi.Pointer<Utf8>);
typedef returnIntMraaLedContextIntParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaLedContext>, ffi.Int32);
typedef returnIntMraaLedContextParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaLedContext>);
typedef returnIntMraaLedContextStringParameterFunc = ffi.Int32 Function(
    ffi.Pointer<MraaLedContext>, ffi.Pointer<Utf8>);

/// Dart Function typedefs
typedef MraaLedInitialiseType = ffi.Pointer<MraaLedContext> Function(int);
typedef MraaLedInitialiseRawType = ffi.Pointer<MraaLedContext> Function(
    ffi.Pointer<Utf8>);
typedef MraaLedSetBrightnessType = int Function(
    ffi.Pointer<MraaLedContext>, int);
typedef MraaLedReadBrightnessType = int Function(ffi.Pointer<MraaLedContext>);
typedef MraaLedReadMaxBrightnessType = int Function(
    ffi.Pointer<MraaLedContext>);
typedef MraaLedSetTriggerType = int Function(
    ffi.Pointer<MraaLedContext>, ffi.Pointer<Utf8>);
typedef MraaLedClearTriggerType = int Function(ffi.Pointer<MraaLedContext>);
typedef MraaLedCloseType = int Function(ffi.Pointer<MraaLedContext>);

/// The LED MRAA API
/// LED is the Light Emitting Diode interface to libmraa.
/// It is used to access the on board LED's via sysfs.
class _MraaLed {
  _MraaLed(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaLedContextIntParameterFunc>>
      _initPointer;
  ffi.Pointer<ffi.NativeFunction<returnMraaLedContextStringParameterFunc>>
      _initRawPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextIntParameterFunc>>
      _setBrightnessPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>
      _readBrightnessPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>
      _readMaxBrightnessPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextStringParameterFunc>>
      _setTriggerPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>
      _clearTriggerPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>
      _closePointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _setBrightnessFunc;
  dynamic _readBrightnessFunc;
  dynamic _readMaxBrightnessFunc;
  dynamic _setTriggerFunc;
  dynamic _clearTriggerFunc;
  dynamic _closeFunc;

  /// Initialise - mraa_led_init
  /// Initialise led context, based on led index.
  /// Returns the led context or null
  ffi.Pointer<MraaLedContext> initialise(int led) => _initFunc(led);

  /// Initialise raw - mraa_led_init_raw
  /// Initialise the led context, based on led function name.
  /// The structure of LED entry in sysfs is "devicename:colour:function"
  /// This method expects only one unique LED identifier which would be "function" name most often.
  /// For instance, initialiseRaw("user4")
  ffi.Pointer<MraaLedContext> initialiseRaw(String ledDev) =>
      _initRawFunc(Utf8.toUtf8(ledDev));

  /// Set brightness - mraa_led_set_brightness
  /// Set LED brightness
  MraaReturnCode setBrightness(ffi.Pointer<MraaLedContext> dev, int value) =>
      returnCode.fromInt(_setBrightnessFunc(dev, value));

  /// Read brightness - mraa_led_read_brightness
  /// Read LED brightness
  int readBrightness(ffi.Pointer<MraaLedContext> dev) =>
      _readBrightnessFunc(dev);

  /// Read brightness - mraa_led_read_max_brightness
  /// Read LED maximum brightness
  int readMaxBrightness(ffi.Pointer<MraaLedContext> dev) =>
      _readMaxBrightnessFunc(dev);

  /// Set trigger - mraa_led_set_trigger
  /// Set LED trigger to the trigger name supplied.
  MraaReturnCode setTrigger(
          ffi.Pointer<MraaLedContext> dev, String triggerName) =>
      returnCode.fromInt(_setTriggerFunc(dev, Utf8.toUtf8(triggerName)));

  /// Clear trigger - mraa_led_clear_trigger
  /// Clear active LED trigger
  MraaReturnCode clearTrigger(ffi.Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_clearTriggerFunc(dev));

  /// Close - mraa_led_close
  /// Close LED file descriptors and free the context memory.
  MraaReturnCode close(ffi.Pointer<MraaLedContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaLedContextIntParameterFunc>>(
            'mraa_led_init');
    _initRawPointer = _lib
        .lookup<ffi.NativeFunction<returnMraaLedContextStringParameterFunc>>(
            'mraa_led_init_raw');
    _setBrightnessPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaLedContextIntParameterFunc>>(
            'mraa_led_set_brightness');
    _readBrightnessPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_brightness');
    _readMaxBrightnessPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_read_max_brightness');
    _setTriggerPointer = _lib
        .lookup<ffi.NativeFunction<returnIntMraaLedContextStringParameterFunc>>(
            'mraa_led_set_trigger');
    _clearTriggerPointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>(
            'mraa_led_clear_trigger');
    _closePointer =
        _lib.lookup<ffi.NativeFunction<returnIntMraaLedContextParameterFunc>>(
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
