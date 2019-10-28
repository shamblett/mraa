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
typedef returnIntMraaSpiContextIntParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Int32);
typedef returnIntMraaSpiContextUint8ParameterFunc = Int32 Function(
    Pointer<MraaSpiContext>, Uint8);

/// Dart Function typedefs
typedef MraaSpiInitialiseType = Pointer<MraaSpiContext> Function(int);
typedef MraaSpiInitialiseRawType = Pointer<MraaSpiContext> Function(int, int);
typedef MraaSpiModeType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiFrequencyType = int Function(Pointer<MraaSpiContext>, int);
typedef MraaSpiWriteType = int Function(Pointer<MraaSpiContext>, int);

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
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>> _modePointer;
  Pointer<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>
      _frequencyPointer;
  Pointer<NativeFunction<returnIntMraaSpiContextUint8ParameterFunc>>
      _writePointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _modeFunc;
  dynamic _frequencyFunc;
  dynamic _writeFunc;

  /// Initialise - mraa_spi_init
  /// Initialise SPI_context, uses board mapping. Sets the muxes
  Pointer<MraaSpiContext> initialise(int busId) => _initFunc(busId);

  /// Initialise raw- mraa_spi_init_raw
  /// Initialise SPI_context without any board configuration, selects a bus and a mux.
  Pointer<MraaSpiContext> initialiseRaw(int busId, int cs) =>
      _initRawFunc(busId, cs);

  /// Mode - mraa_spi_mode
  /// Set the SPI device mode. see spidev 0-3.
  MraaReturnCode mode(Pointer<MraaSpiContext> dev, MraaSpiMode mode) =>
      returnCode.fromInt(_modeFunc(dev, spiMode.asInt(mode)));

  /// Frequency - mraa_spi_frequency
  /// Set the SPI device operating clock frequency in Hz
  MraaReturnCode frequency(Pointer<MraaSpiContext> dev, int hz) =>
      returnCode.fromInt(_frequencyFunc(dev, hz));

  /// Write - mraa_spi_write
  /// Write Single Byte to the SPI device.
  /// Returns data received on the miso line or -1 in case of error
  int write(Pointer<MraaSpiContext> dev, int data) => _writeFunc(dev, data);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaSpiContextIntIntParameterFunc>>(
            'mraa_spi_init_raw');
    _modePointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_mode');
    _frequencyPointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextIntParameterFunc>>(
            'mraa_spi_frequency');
    _writePointer =
        _lib.lookup<NativeFunction<returnIntMraaSpiContextUint8ParameterFunc>>(
            'mraa_spi_write');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaSpiInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaSpiInitialiseRawType>();
    _modeFunc = _modePointer.asFunction<MraaSpiModeType>();
    _frequencyFunc = _frequencyPointer.asFunction<MraaSpiFrequencyType>();
    _writeFunc = _writePointer.asFunction<MraaSpiWriteType>();
  }
}
