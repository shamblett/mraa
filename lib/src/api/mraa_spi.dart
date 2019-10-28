/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaSpiContextIntParameterFunc = Pointer<MraaSpiContext> Function(
    Int32);
typedef returnMraaSpiContextIntIntParameterFunc = Pointer<MraaSpiContext>
    Function(Int32, Int32);

/// Dart Function typedefs
typedef MraaSpiInitialiseType = Pointer<MraaSpiContext> Function(int);
typedef MraaSpiInitialiseRawType = Pointer<MraaSpiContext> Function(int, int);

/// The SPI MRAA API
/// An SPI object in libmraa represents a spidev device. Linux spidev devices
/// are created per spi bus and every chip select available on that bus has another
/// spidev 'file'.
class _MraaSpi {
  _MraaSpi(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaSpiContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaSpiContextIntIntParameterFunc>>
      _initRawPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;

  /// Initialise - mraa_spi_init
  /// Initialise SPI_context, uses board mapping. Sets the muxes
  Pointer<MraaSpiContext> initialise(int busId) => _initFunc(busId);

  /// Initialise raw- mraa_spi_init_raw
  /// Initialise SPI_context without any board configuration, selects a bus and a mux.
  Pointer<MraaSpiContext> initialiseRaw(int busId, int cs) =>
      _initRawFunc(busId, cs);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntIntParameterFunc>>(
            'mraa_spi_init_raw');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaSpiInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaSpiInitialiseRawType>();
  }
}
