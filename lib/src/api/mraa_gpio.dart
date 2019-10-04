/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function type typedefs

/// Dart Function typedefs

/// The GPIO MRAA Api
class _MraaGpio {
  _MraaGpio(this._lib) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  /// C Pointers

  /// Dart Functions

  void _setUpPointers() {}

  void _setUpFunctions() {}
}
