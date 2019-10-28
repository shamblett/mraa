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

/// Dart Function typedefs
typedef MraaUartInitialiseType = Pointer<MraaUartContext> Function(int);

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

  /// Dart Functions
  dynamic _initFunc;

  /// Initialise - mraa_uart_init
  /// Initialise a uart context, uses board mapping when supplied with
  /// the UART index to use
  Pointer<MraaUartContext> initialise(int uart) => _initFunc(uart);

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaUartContextIntParameterFunc>>(
            'mraa_spi_init');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaUartInitialiseType>();
  }
}
