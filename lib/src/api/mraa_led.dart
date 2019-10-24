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

/// Dart Function typedefs
typedef MraaLedInitialiseType = ffi.Pointer<MraaLedContext> Function(int);
typedef MraaLedInitialiseRawType = ffi.Pointer<MraaLedContext> Function(
    ffi.Pointer<Utf8>);

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

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;

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

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaLedContextIntParameterFunc>>(
            'mraa_led_init');
    _initRawPointer = _lib
        .lookup<ffi.NativeFunction<returnMraaLedContextStringParameterFunc>>(
            'mraa_led_init_raw');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaLedInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaLedInitialiseRawType>();
  }
}
