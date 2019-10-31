/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: avoid_private_typedef_functions

part of mraa;

/// C Function type typedefs
typedef _returnMraaUartContextIntParameterFunc = Pointer<MraaUartContext>
    Function(Int32);
typedef _returnMraaUartContextStringParameterFunc = Pointer<MraaUartContext>
    Function(Pointer<ffi.Utf8>);
typedef _returnIntMraaUartContextParameterFunc = Int32 Function(
    Pointer<MraaUartContext>);
typedef _returnIntMraaUartContextParameterIntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32);
typedef _returnIntMraaUartContextParameterUintFunc = Int32 Function(
    Pointer<MraaUartContext>, Uint32);
typedef _returnIntMraaUartContextParameter3IntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32, Int32, Int32);
typedef _returnIntMraaUartContextParameter2IntFunc = Int32 Function(
    Pointer<MraaUartContext>, Int32, Int32);
typedef _returnStringMraaUartContextParameterFunc = Pointer<ffi.Utf8> Function(
    Pointer<MraaUartContext>);
typedef _returnIntInt2String4Int2UIntParameterFunc = Int32 Function(
    Int32,
    Pointer<ffi.Utf8>,
    Pointer<ffi.Utf8>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Uint32>,
    Pointer<Uint32>);
typedef _returnIntMraaUartContextStringIntParameterFunc = Int32 Function(
    Pointer<MraaUartContext>, Pointer<ffi.Utf8>, Int32);

/// Dart Function typedefs
typedef _MraaUartInitialiseType = Pointer<MraaUartContext> Function(int);
typedef _MraaUartInitialiseRawType = Pointer<MraaUartContext> Function(
    Pointer<ffi.Utf8>);
typedef _MraaUartFlushType = int Function(Pointer<MraaUartContext>);
typedef _MraaUartSendBreakType = int Function(Pointer<MraaUartContext>, int);
typedef _MraaUartBaudRateType = int Function(Pointer<MraaUartContext>, int);
typedef _MraaUartModeType = int Function(
    Pointer<MraaUartContext>, int, int, int);
typedef _MraaUartFlowControlType = int Function(
    Pointer<MraaUartContext>, int, int);
typedef _MraaUartTimeoutType = int Function(
    Pointer<MraaUartContext>, int, int, int);
typedef _MraaUartNonBlockingType = int Function(Pointer<MraaUartContext>, int);
typedef _MraaUartDevicePathType = Pointer<ffi.Utf8> Function(
    Pointer<MraaUartContext>);
typedef _MraaUartSettingsType = int Function(
    int,
    Pointer<ffi.Utf8>,
    Pointer<ffi.Utf8>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Int32>,
    Pointer<Uint32>,
    Pointer<Uint32>);
typedef _MraaUartStopType = int Function(Pointer<MraaUartContext>);
typedef _MraaUartReadType = int Function(
    Pointer<MraaUartContext>, Pointer<ffi.Utf8>, int);
typedef _MraaUartWriteType = int Function(
    Pointer<MraaUartContext>, Pointer<ffi.Utf8>, int);

/// The UART MRAA API
///
/// UART is the Universal asynchronous receiver/transmitter interface to MRAA
/// It allows the exposure of UART pins on supported boards
/// with functionality to expand at a later date.
class MraaUart {
  /// Construction
  MraaUart(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<_returnMraaUartContextIntParameterFunc>> _initPointer;
  Pointer<NativeFunction<_returnMraaUartContextStringParameterFunc>>
      _initRawPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameterFunc>> _flushPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameterIntFunc>>
      _sendBreakPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameterUintFunc>>
      _baudRatePointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameter3IntFunc>>
      _modePointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameter2IntFunc>>
      _flowControlPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameter3IntFunc>>
      _timeoutPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameterIntFunc>>
      _nonBlockingPointer;
  Pointer<NativeFunction<_returnStringMraaUartContextParameterFunc>>
      _devicePathPointer;
  Pointer<NativeFunction<_returnIntInt2String4Int2UIntParameterFunc>>
      _settingsPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextParameterFunc>> _stopPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextStringIntParameterFunc>>
      _readPointer;
  Pointer<NativeFunction<_returnIntMraaUartContextStringIntParameterFunc>>
      _writePointer;

  /// Dart Functions
  _MraaUartInitialiseType _initFunc;
  _MraaUartInitialiseRawType _initRawFunc;
  _MraaUartFlushType _flushFunc;
  _MraaUartSendBreakType _sendBreakFunc;
  _MraaUartBaudRateType _baudRateFunc;
  _MraaUartModeType _modeFunc;
  _MraaUartFlowControlType _flowControlFunc;
  _MraaUartTimeoutType _timeoutFunc;
  _MraaUartNonBlockingType _nonBlockingFunc;
  _MraaUartDevicePathType _devicePathFunc;
  _MraaUartSettingsType _settingsFunc;
  _MraaUartStopType _stopFunc;
  _MraaUartReadType _readFunc;
  _MraaUartWriteType _writeFunc;

  /// Initialise - mraa_uart_init
  ///
  /// Initialise a [MraaUartContext], uses board mapping when supplied with
  /// the UART index to use.
  Pointer<MraaUartContext> initialise(int uart) => _initFunc(uart);

  /// Initialise raw - mraa_uart_init_raw
  ///
  /// Initialise a raw [MraaUartContext]. when there is board setup e.g. /dev/ttyS0
  Pointer<MraaUartContext> initialiseRaw(String path) =>
      _initRawFunc(ffi.Utf8.toUtf8(path));

  /// Flush - mraa_uart_flush
  ///
  /// Flush the outbound data. Blocks until complete.
  MraaReturnCode flush(Pointer<MraaUartContext> dev) =>
      returnCode.fromInt(_flushFunc(dev));

  /// Send break - mraa_uart_sendbreak
  ///
  /// Send a break to the device. Blocks until complete.
  /// If duration is 0, send a break lasting at least 250 milliseconds,
  /// and not more than 500 milliseconds. When non zero, the break duration
  /// is implementation specific.
  MraaReturnCode sendBreak(Pointer<MraaUartContext> dev, int duration) =>
      returnCode.fromInt(_sendBreakFunc(dev, duration));

  /// Baud rate - mraa_uart_baudrate
  ///
  /// Set the Baud rate. This will attempt to decide what
  /// Baud rate is to be used on the UART hardware.
  MraaReturnCode baudRate(Pointer<MraaUartContext> dev, int baud) =>
      returnCode.fromInt(_baudRateFunc(dev, baud));

  /// Mode - mraa_uart_set_mode
  ///
  /// Set the transfer mode.
  /// For example setting the mode to 8N1 would be
  /// mode(context, 8,MraaUartParity,none , 1)
  MraaReturnCode mode(Pointer<MraaUartContext> dev, int byteSize,
          MraaUartParity parity, int stopBits) =>
      returnCode.fromInt(
          _modeFunc(dev, byteSize, uartParity.asInt(parity), stopBits));

  /// Flow control - mraa_uart_set_flowcontrol
  ///
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
  ///
  /// Set the timeout for read and write operations <= 0 will disable the timeout.
  MraaReturnCode timeout(
          Pointer<MraaUartContext> dev, int read, int write, int interChar) =>
      returnCode.fromInt(_timeoutFunc(dev, read, write, interChar));

  /// Non blocking - mraa_uart_set_nonblocking
  ///
  /// Set the blocking state for write operations
  MraaReturnCode nonBlocking(Pointer<MraaUartContext> dev, bool nonBlock) {
    final int block = nonBlock ? 1 : 0;
    return returnCode.fromInt(_nonBlockingFunc(dev, block));
  }

  /// Device path - mraa_uart_get_dev_path
  ///
  /// Get the tty device path, for example "/dev/ttyS0"
  String devicePath(Pointer<MraaUartContext> dev) =>
      ffi.Utf8.fromUtf8(_devicePathFunc(dev));

  /// Settings - mraa_uart_settings
  ///
  /// Get the current settings of a UART. This is an unintrusive function.
  /// Meaning it intends not to change anything, only read the values.
  /// All but the first index parameter are settable, i.e. they can contain values on return.
  /// If any parameter is not set it will be set to null.
  /// The device path parameter can be either an in or out parameter.
  /// If a negative index is supplied, the UART is identified using the supplied device path instead.
  /// This functionality is intended for and needed by for instance USB serial adapters.
  /// In case of a non-success return value, the out parameters are undefined and will be
  /// set as passed in, see [MraaUartSettings].
  MraaReturnCode settings(int index, MraaUartSettings settings) {
    // Check for either a valid index or a device path
    if (index < 0 && settings.devicePath == null) {
      return MraaReturnCode.errorInvalidParameter;
    }

    // Construct the parameter list
    Pointer<ffi.Utf8> ptrDevicePath;
    if (settings.devicePath == null) {
      ptrDevicePath = nullptr;
    } else {
      ptrDevicePath = ffi.Utf8.toUtf8(settings.devicePath);
    }
    final Pointer<ffi.Utf8> ptrName = nullptr;
    final Pointer<Int32> ptrBaudrate = ffi.allocate<Int32>(count: 1);
    final Pointer<Int32> ptrDataBits = ffi.allocate<Int32>(count: 1);
    final Pointer<Int32> ptrStopBits = ffi.allocate<Int32>(count: 1);
    final Pointer<Int32> ptrParity = ffi.allocate<Int32>(count: 1);
    final Pointer<Uint32> ptrRtsCts = ffi.allocate<Uint32>(count: 1);
    final Pointer<Uint32> ptrXonXoff = ffi.allocate<Uint32>(count: 1);

    // Get the settings
    final int ret = _settingsFunc(index, ptrDevicePath, ptrName, ptrBaudrate,
        ptrDataBits, ptrStopBits, ptrParity, ptrRtsCts, ptrXonXoff);

    // If not success just return the status
    if (returnCode.fromInt(ret) != MraaReturnCode.success) {
      return returnCode.fromInt(ret);
    }

    // Set the output parameters
    settings.devicePath = ffi.Utf8.fromUtf8(ptrDevicePath);
    settings.name = ffi.Utf8.fromUtf8(ptrName);
    settings.baudRate = ptrBaudrate.value;
    settings.dataBits = ptrDataBits.value;
    settings.stopBits = ptrStopBits.value;
    settings.parity = uartParity.fromInt(ptrParity.value);
    settings.rtsCts = ptrRtsCts.value != 0;
    settings.xonXoff = ptrXonXoff.value != 0;

    // End
    return MraaReturnCode.success;
  }

  /// Stop - mraa_uart_stop
  ///
  /// Destroy a UART context
  MraaReturnCode stop(Pointer<MraaUartContext> dev) =>
      returnCode.fromInt(_stopFunc(dev));

  /// Read - mraa_uart_read
  ///
  /// Read bytes from the device into a buffer
  /// Returns the number of bytes read, or [Mraa.generalError].
  int read(Pointer<MraaUartContext> dev, MraaUartBuffer buffer, int length) {
    if (length <= 0) {
      return Mraa.generalError;
    }
    final Pointer<ffi.Utf8> ptrBuffer = ffi.allocate<ffi.Utf8>(count: length);
    final int ret = _readFunc(dev, ptrBuffer, length);
    if (ret == Mraa.generalError) {
      return ret;
    }
    try {
      buffer.data = ffi.Utf8.fromUtf8(ptrBuffer);
    } on FormatException {
      return Mraa.generalError;
    }
    return ret;
  }

  /// Write - mraa_uart_write
  ///
  /// Write bytes to the device from a buffer
  /// Returns the number of bytes written, or [Mraa.generalError]
  int write(Pointer<MraaUartContext> dev, MraaUartBuffer buffer, int length) {
    if (length <= 0) {
      return Mraa.generalError;
    }
    final Pointer<ffi.Utf8> ptrBuffer = ffi.allocate<ffi.Utf8>(count: length);
    final int ret = _writeFunc(dev, ptrBuffer, length);
    ffi.free(ptrBuffer);
    return ret;
  }

  void _setUpPointers() {
    _initPointer =
        _lib.lookup<NativeFunction<_returnMraaUartContextIntParameterFunc>>(
            'mraa_spi_init');
    _initRawPointer =
        _lib.lookup<NativeFunction<_returnMraaUartContextStringParameterFunc>>(
            'mraa_uart_init_raw');
    _flushPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameterFunc>>(
            'mraa_uart_flush');
    _sendBreakPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameterIntFunc>>(
            'mraa_uart_sendbreak');
    _baudRatePointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameterUintFunc>>(
            'mraa_uart_set_baudrate');
    _modePointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameter3IntFunc>>(
            'mraa_uart_set_mode');
    _flowControlPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameter2IntFunc>>(
            'mraa_uart_set_flowcontrol');
    _timeoutPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameter3IntFunc>>(
            'mraa_uart_set_timeout');
    _nonBlockingPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameterIntFunc>>(
            'mraa_uart_set_non_blocking');
    _devicePathPointer =
        _lib.lookup<NativeFunction<_returnStringMraaUartContextParameterFunc>>(
            'mraa_uart_get_dev_path');
    _settingsPointer =
        _lib.lookup<NativeFunction<_returnIntInt2String4Int2UIntParameterFunc>>(
            'mraa_uart_settings');
    _stopPointer =
        _lib.lookup<NativeFunction<_returnIntMraaUartContextParameterFunc>>(
            'mraa_uart_stop');
    _readPointer = _lib.lookup<
            NativeFunction<_returnIntMraaUartContextStringIntParameterFunc>>(
        'mraa_uart_read');
    _writePointer = _lib.lookup<
            NativeFunction<_returnIntMraaUartContextStringIntParameterFunc>>(
        'mraa_uart_write');
  }

  void _setUpFunctions() {
    _initFunc = _initPointer.asFunction<_MraaUartInitialiseType>();
    _initRawFunc = _initRawPointer.asFunction<_MraaUartInitialiseRawType>();
    _flushFunc = _flushPointer.asFunction<_MraaUartFlushType>();
    _sendBreakFunc = _sendBreakPointer.asFunction<_MraaUartSendBreakType>();
    _baudRateFunc = _baudRatePointer.asFunction<_MraaUartBaudRateType>();
    _modeFunc = _modePointer.asFunction<_MraaUartModeType>();
    _flowControlFunc =
        _flowControlPointer.asFunction<_MraaUartFlowControlType>();
    _timeoutFunc = _timeoutPointer.asFunction<_MraaUartTimeoutType>();
    _nonBlockingFunc =
        _nonBlockingPointer.asFunction<_MraaUartNonBlockingType>();
    _devicePathFunc = _devicePathPointer.asFunction<_MraaUartDevicePathType>();
    _settingsFunc = _settingsPointer.asFunction<_MraaUartSettingsType>();
    _stopFunc = _stopPointer.asFunction<_MraaUartStopType>();
    _readFunc = _readPointer.asFunction<_MraaUartReadType>();
    _writeFunc = _writePointer.asFunction<_MraaUartWriteType>();
  }
}
