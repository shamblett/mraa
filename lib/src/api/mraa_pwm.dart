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

/// Dart Function typedefs
typedef MraaPwmInitialiseType = ffi.Pointer<MraaPwmContext> Function(int);

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

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_pwm_init
  /// Initialise pwm_context, uses board mapping
  /// Returns pwm context or NULL.
  ffi.Pointer<MraaPwmContext> initialise(int pin) => _initFunc(pin);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaPwmContextIntParameterFunc>>(
            'mraa_pwm_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaPwmInitialiseType>();
  }
}
