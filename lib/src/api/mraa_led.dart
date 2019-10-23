/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs

/// Dart Function typedefs
///

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

  /// Dart Functions

  void _setUpPointers() {}

  void _setUpFunctions() {}
}
