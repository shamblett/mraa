/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaUartContextIntParameterFunc = Pointer<MraaUartContext>
    Function(Int32);
typedef returnMraaUartContextStringParameterFunc = Pointer<MraaUartContext>
    Function(Pointer<ffi.Utf8>);

/// Dart Function typedefs
typedef MraaUartInitialiseType = Pointer<MraaUartContext> Function(int);
typedef MraaUartInitialiseRawType = Pointer<MraaUartContext> Function(
    Pointer<ffi.Utf8>);

/// The UART MRAA API
/// UART is the Universal asynchronous receiver/transmitter interface to libmraa.
/// It allows the exposure of UART pins on supported boards.
/// With functionality to expand at a later date.
class _MraaUart {
  _MraaUart(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<returnMraaUartContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<returnMraaUartContextStringParameterFunc>>
      _initRawPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;

  /// Initialise - mraa_uart_init
  /// Initialise a uart context, uses board mapping when supplied with
  /// the UART index to use
  Pointer<MraaUartContext> initialise(int uart) => _initFunc(uart);

  /// Initialise raw - mraa_uart_init_raw
  /// Initialise a raw uart_context. No board setup e.g. /dev/ttyS0
  Pointer<MraaUartContext> initialiseRaw(String path) =>
      _initRawFunc(ffi.Utf8.toUtf8(path));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaUartContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaUartContextStringParameterFunc>>(
            'mraa_uart_init_raw');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaUartInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaUartInitialiseRawType>();
  }
}
