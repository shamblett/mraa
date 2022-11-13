/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The UART MRAA API
///
/// UART is the Universal asynchronous receiver/transmitter interface to MRAA
/// It allows the exposure of UART pins on supported boards
/// with functionality to expand at a later date.
class MraaUart {
  /// Construction
  MraaUart(this._impl, this._noJsonLoading);

  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// Initialise - mraa_uart_init
  ///
  /// Initialise a [MraaUartContext], uses board mapping when supplied with
  /// the UART index to use.
  MraaUartContext initialise(int uart) => _impl.mraa_uart_init(uart);

  /// Initialise raw - mraa_uart_init_raw
  ///
  /// Initialise a raw [MraaUartContext]. when there is board setup e.g. /dev/ttyS0
  MraaUartContext initialiseRaw(String path) =>
      _impl.mraa_uart_init_raw(path.toNativeUtf8().cast<Char>());

  /// Flush - mraa_uart_flush
  ///
  /// Flush the outbound data. Blocks until complete.
  MraaReturnCode flush(MraaUartContext dev) =>
      MraaReturnCode.returnCode(_impl.mraa_uart_flush(dev));

  /// Send break - mraa_uart_sendbreak
  ///
  /// Send a break to the device. Blocks until complete.
  /// If duration is 0, send a break lasting at least 250 milliseconds,
  /// and not more than 500 milliseconds. When non zero, the break duration
  /// is implementation specific.
  MraaReturnCode sendBreak(MraaUartContext dev, int duration) =>
      MraaReturnCode.returnCode(_impl.mraa_uart_sendbreak(dev, duration));

  /// Baud rate - mraa_uart_set_baudrate
  ///
  /// Set the Baud rate. This will attempt to decide what
  /// Baud rate is to be used on the UART hardware.
  MraaReturnCode baudRate(MraaUartContext dev, int baud) =>
      MraaReturnCode.returnCode(_impl.mraa_uart_set_baudrate(dev, baud));

  /// Mode - mraa_uart_set_mode
  ///
  /// Set the transfer mode.
  /// For example setting the mode to 8N1 would be
  /// mode(context, 8,MraaUartParity,none , 1)
  MraaReturnCode mode(MraaUartContext dev, int byteSize, MraaUartParity parity,
          int stopBits) =>
      MraaReturnCode.returnCode(
          _impl.mraa_uart_set_mode(dev, byteSize, parity.code, stopBits));

  /// Flow control - mraa_uart_set_flowcontrol
  ///
  /// Set the flowcontrol
  /// XON/XOFF is software flow control.
  /// RTS/CTS is out of band hardware flow control
  MraaReturnCode flowControl(MraaUartContext dev, bool xonXoff, bool rtsCts) {
    final xon = xonXoff ? 1 : 0;
    final rts = rtsCts ? 1 : 0;
    return MraaReturnCode.returnCode(
        _impl.mraa_uart_set_flowcontrol(dev, xon, rts));
  }

  /// Timeout - mraa_uart_set_timeout
  ///
  /// Set the timeout for read and write operations <= 0 will
  /// disable the timeout.
  MraaReturnCode timeout(
          MraaUartContext dev, int read, int write, int interChar) =>
      MraaReturnCode.returnCode(
          _impl.mraa_uart_set_timeout(dev, read, write, interChar));

  /// Non blocking - mraa_uart_set_non_blocking
  ///
  /// Set the blocking state for write operations
  MraaReturnCode nonBlocking(MraaUartContext dev, bool nonBlock) {
    final block = nonBlock ? 1 : 0;
    return MraaReturnCode.returnCode(
        _impl.mraa_uart_set_non_blocking(dev, block));
  }

  /// Device path - mraa_uart_get_dev_path
  ///
  /// Get the tty device path, for example "/dev/ttyS0"
  String devicePath(MraaUartContext dev) =>
      _impl.mraa_uart_get_dev_path(dev) == nullptr
          ? ''
          : _impl.mraa_uart_get_dev_path(dev).cast<ffi.Utf8>().toDartString();

  /// Device path from index
  /// Given a UART index get the associated device path.
  /// Can return null if the index does not map to a UART device
  String devicePathFromIndex(int index) {
    if (index < 0) {
      return '';
    }
    final ptrDevicePath = ffi.calloc.allocate<Pointer<Char>>(1024);
    final ret = _impl.mraa_uart_settings(index, ptrDevicePath, nullptr, nullptr,
        nullptr, nullptr, nullptr, nullptr, nullptr);

    // If not success return null
    if (MraaReturnCode.returnCode(ret) != MraaReturnCode.success) {
      return '';
    }

    // Set the output parameters
    try {
      return ptrDevicePath.value.cast<ffi.Utf8>().toDartString();
    } on FormatException {
      return '';
    }
  }

  /// Settings - mraa_uart_settings
  ///
  /// Get the current settings of a UART. This is an unintrusive function.
  /// Meaning it intends not to change anything, only read the values.
  /// All but the first index parameter are settable, i.e. they can contain
  /// values on return.
  /// If any parameter is not set it will be set to null.
  /// The device path parameter can be either an in or out parameter.
  /// If a negative index is supplied, the UART is identified using the
  /// supplied device path instead.
  /// This functionality is intended for and needed by for instance USB
  /// serial adapters.
  /// In case of a non-success return value, the out parameters are undefined
  /// and will be set as passed in, see [MraaUartSettings].
  MraaReturnCode settings(int index, MraaUartSettings settings) {
    // Check for either a valid index or a device path
    if (index < 0 && settings.devicePath.isNotEmpty) {
      return MraaReturnCode.errorInvalidParameter;
    }

    // Construct the parameter list
    final ptrDevicePath = ffi.calloc.allocate<Pointer<Char>>(255);
    if (index < 0) {
      ptrDevicePath.value = settings.devicePath.toNativeUtf8().cast<Char>();
    }
    final ptrName = ffi.calloc.allocate<Pointer<Char>>(255);
    final ptrBaudrate = ffi.calloc.allocate<Int>(1);
    final ptrDataBits = ffi.calloc.allocate<Int>(1);
    final ptrStopBits = ffi.calloc.allocate<Int>(1);
    final ptrParity = ffi.calloc.allocate<Int32>(1);
    final ptrRtsCts = ffi.calloc.allocate<UnsignedInt>(1);
    final ptrXonXoff = ffi.calloc.allocate<UnsignedInt>(1);

    // Get the settings
    final ret = _impl.mraa_uart_settings(
        index,
        ptrDevicePath,
        ptrName,
        ptrBaudrate,
        ptrDataBits,
        ptrStopBits,
        ptrParity,
        ptrRtsCts,
        ptrXonXoff);

    // If not success just return the status
    if (MraaReturnCode.returnCode(ret) != MraaReturnCode.success) {
      return MraaReturnCode.returnCode(ret);
    }

    // Set the output parameters
    settings.devicePath = ptrDevicePath.value.cast<ffi.Utf8>().toDartString();
    settings.name = ptrName.value.cast<ffi.Utf8>().toDartString();
    settings.baudRate = ptrBaudrate.value;
    settings.dataBits = ptrDataBits.value;
    settings.stopBits = ptrStopBits.value;
    settings.parity = MraaUartParity.uartParity(ptrParity.value);
    settings.rtsCts = ptrRtsCts.value != 0;
    settings.xonXoff = ptrXonXoff.value != 0;

    // End
    return MraaReturnCode.success;
  }

  /// Stop - mraa_uart_stop
  ///
  /// Destroy a UART context
  MraaReturnCode stop(MraaUartContext dev) =>
      MraaReturnCode.returnCode(_impl.mraa_uart_stop(dev));

  /// Read unsigned bytes - mraa_uart_read
  ///
  /// Read bytes from the device into a buffer
  /// Returns the number of bytes read, or [Mraa.generalError].
  int readBytes(MraaUartContext dev, MraaUartBuffer buffer, int length) {
    if (length <= 0) {
      return Mraa.generalError;
    }
    final ptrBuffer = ffi.calloc.allocate<Char>(length);
    final ret = _impl.mraa_uart_read(dev, ptrBuffer, length);
    if (ret == Mraa.generalError) {
      return ret;
    }
    try {
      buffer.byteData = ptrBuffer.cast<Uint8>().asTypedList(ret);
    } on Exception {
      return Mraa.generalError;
    }
    return ret;
  }

  /// Write bytes - mraa_uart_write
  ///
  /// Write bytes to the device from a buffer.
  /// Returns the number of bytes written, or [Mraa.generalError]
  int writeBytes(MraaUartContext dev, MraaUartBuffer buffer, int length) {
    if (length <= 0) {
      return Mraa.generalError;
    }
    if (buffer.byteData.isEmpty || buffer.byteLength < length) {
      return Mraa.generalError;
    }
    final ptrBuffer = ffi.calloc.allocate<Char>(length);
    final typedBuffer = ptrBuffer.cast<Uint8>().asTypedList(length);
    typedBuffer.setAll(0, buffer.byteData);
    final ret = _impl.mraa_uart_write(dev, ptrBuffer, length);
    ffi.calloc.free(ptrBuffer);
    return ret;
  }

  /// Data available.
  ///
  /// Check to see if data is available on the device for reading.
  /// If [millisecondsToWait] is 0 the method returns immediately.
  /// Returns true if data available, false otherwise.
  bool dataAvailable(MraaUartContext dev, int millisecondsToWait) {
    final ret = _impl.mraa_uart_data_available(dev, millisecondsToWait);
    return ret == 1;
  }
}
