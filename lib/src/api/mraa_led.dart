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

/// Dart Function typedefs
typedef MraaLedInitialiseType = ffi.Pointer<MraaLedContext> Function(int);

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

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_led_init
  /// Initialise led context, based on led index.
  /// Returns the led context or null
  ffi.Pointer<MraaLedContext> initialise(int led) => _initFunc(led);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaLedContextIntParameterFunc>>(
            'mraa_led_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaLedInitialiseType>();
  }
}
