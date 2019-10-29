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
typedef returnIntMraaUartContextParameterFunc = Int32 Function(
    Pointer<MraaUartContext>);
typedef returnIntMraaUartContextParameterIntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32);
typedef returnIntMraaUartContextParameterUintFunc = Int32 Function(
    Pointer<MraaUartContext>, Uint32);
typedef returnIntMraaUartContextParameter3IntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32, Int32, Int32);
typedef returnIntMraaUartContextParameter2IntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32, Int32);

/// Dart Function typedefs
typedef MraaUartInitialiseType = Pointer<MraaUartContext> Function(int);
typedef MraaUartInitialiseRawType = Pointer<MraaUartContext> Function(
    Pointer<ffi.Utf8>);
typedef MraaUartFlushType = int Function(Pointer<MraaUartContext>);
typedef MraaUartSendBreakType = int Function(Pointer<MraaUartContext>, int);
typedef MraaUartBaudRateType = int Function(Pointer<MraaUartContext>, int);
typedef MraaUartModeType = int Function(
    Pointer<MraaUartContext>, int, int, int);
typedef MraaUartFlowControlType = int Function(
    Pointer<MraaUartContext>, int, int);
typedef MraaUartTimeoutType = int Function(
    Pointer<MraaUartContext>, int, int, int);

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
  Pointer<NativeFunction<returnIntMraaUartContextParameterFunc>> _flushPointer;
  Pointer<NativeFunction<returnIntMraaUartContextParameterIntFunc>>
      _sendBreakPointer;
  Pointer<NativeFunction<returnIntMraaUartContextParameterUintFunc>>
      _baudRatePointer;
  Pointer<NativeFunction<returnIntMraaUartContextParameter3IntFunc>>
      _modePointer;
  Pointer<NativeFunction<returnIntMraaUartContextParameter2IntFunc>>
      _flowControlPointer;
  Pointer<NativeFunction<returnIntMraaUartContextParameter3IntFunc>>
      _timeoutPointer;

  /// Dart Functions
  dynamic _initFunc;
  dynamic _initRawFunc;
  dynamic _flushFunc;
  dynamic _sendBreakFunc;
  dynamic _baudRateFunc;
  dynamic _modeFunc;
  dynamic _flowControlFunc;
  dynamic _timeoutFunc;

  /// Initialise - mraa_uart_init
  /// Initialise a uart context, uses board mapping when supplied with
  /// the UART index to use
  Pointer<MraaUartContext> initialise(int uart) => _initFunc(uart);

  /// Initialise raw - mraa_uart_init_raw
  /// Initialise a raw uart_context. No board setup e.g. /dev/ttyS0
  Pointer<MraaUartContext> initialiseRaw(String path) =>
      _initRawFunc(ffi.Utf8.toUtf8(path));

  /// Flush - mraa_uart_flush
  /// Flush the outbound data. Blocks until complete.
  MraaReturnCode flush(Pointer<MraaUartContext> dev) =>
      returnCode.fromInt(_flushFunc(dev));

  /// Send break - mraa_uart_sendbreak
  /// Send a break to the device. Blocks until complete.
  /// If duration is 0, send a break lasting at least 250 milliseconds,
  /// and not more than 500 milliseconds. When non zero, the break duration
  /// is implementation specific.
  MraaReturnCode sendBreak(Pointer<MraaUartContext> dev, int duration) =>
      returnCode.fromInt(_sendBreakFunc(dev, duration));

  /// Baud rate - mraa_uart_baudrate
  /// Set the baudrate. Takes an int and will attempt to decide what
  /// baudrate is to be used on the UART hardware.
  MraaReturnCode baudRate(Pointer<MraaUartContext> dev, int baud) =>
      returnCode.fromInt(_baudRateFunc(dev, baud));

  /// Mode - mraa_uart_set_mode
  /// Set the transfer mode.
  /// For example setting the mode to 8N1 would be
  /// mode(context, 8,MraaUartParity,none , 1)
  MraaReturnCode mode(Pointer<MraaUartContext> dev, int byteSize,
          MraaUartParity parity, int stopBits) =>
      returnCode.fromInt(
          _modeFunc(dev, byteSize, uartParity.asInt(parity), stopBits));

  /// Flow control - mraa_uart_set_flowcontrol
  /// Set the flowcontrol
  /// XON/XOFF is software flow control.
  /// RTS/CTS is out of band hardware flow control
  MraaReturnCode flowControl(
      Pointer<MraaUartContext> dev, bool xonXoff, bool rtsCts) {
    final int xon = xonXoff ? 1 : 0;
    final int rts = rtsCts ? 1 : 0;
    return returnCode.fromInt(_flowControlFunc(dev, xon, rts));
  }

  /// Timeout - mraa_uart_set_timeout
  /// Set the timeout for read and write operations <= 0 will disable that timeout.
  MraaReturnCode timeout(
          Pointer<MraaUartContext> dev, int read, int write, int interChar) =>
      returnCode.fromInt(_timeoutFunc(dev, read, write, interChar));

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<returnMraaUartContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<returnMraaUartContextStringParameterFunc>>(
            'mraa_uart_init_raw');
    _flushPointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameterFunc>>(
            'mraa_uart_flush');
    _sendBreakPointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameterIntFunc>>(
            'mraa_uart_sendbreak');
    _baudRatePointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameterUintFunc>>(
            'mraa_uart_set_baudrate');
    _modePointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameter3IntFunc>>(
            'mraa_uart_set_mode');
    _flowControlPointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameter2IntFunc>>(
            'mraa_uart_set_flowcontrol');
    _timeoutPointer =
        _lib.lookup<NativeFunction<returnIntMraaUartContextParameter3IntFunc>>(
            'mraa_uart_set_timeout');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<MraaUartInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<MraaUartInitialiseRawType>();
    _flushFunc = _flushPointer.asFunction<MraaUartFlushType>();
    _sendBreakFunc = _sendBreakPointer.asFunction<MraaUartSendBreakType>();
    _baudRateFunc = _baudRatePointer.asFunction<MraaUartBaudRateType>();
    _modeFunc = _modePointer.asFunction<MraaUartModeType>();
    _flowControlFunc =
        _flowControlPointer.asFunction<MraaUartFlowControlType>();
    _timeoutFunc = _timeoutPointer.asFunction<MraaUartTimeoutType>();
  }
}
