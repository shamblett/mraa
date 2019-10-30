/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// UART settings as read back from the platform.
///
/// The device path can be set when passed to the settings function
/// in which case this will be used rather than the UART device index.
/// Any setting can be null on return from the settings function call.
class MraaUartSettings {
  /// The device path of the UART, eg: /dev/ttyS0
  String devicePath;

  /// The name of the UART
  String name;

  /// The current Baud rate (0–4M)
  int baudRate;

  /// The number of data bits (5–8)
  int dataBits;

  /// The number of stop bits (1-2)
  int stopBits;

  /// The current parity mode
  MraaUartParity parity;

  /// True if CTS/RTS flow control is enabled, zero otherwise
  bool rtsCts;

  /// True if xon/xoff flow control is enabled
  bool xonXoff;

  @override
  String toString() {
    final StringBuffer sb = StringBuffer();
    devicePath == null
        ? sb.writeln('Device Path: not set')
        : sb.writeln('Device Path: $devicePath');
    name == null ? sb.writeln('Name: not set') : sb.writeln('Name: $name');
    baudRate == null
        ? sb.writeln('Baud Rate: not set')
        : sb.writeln('Baud Rate: $baudRate');
    dataBits == null
        ? sb.writeln('Data Bits: not set')
        : sb.writeln('Data Bits: $dataBits');
    stopBits == null
        ? sb.writeln('Stop Bits: not set')
        : sb.writeln('Stop Bits: $stopBits');
    parity == null
        ? sb.writeln('Parity: not set')
        : sb.writeln('Parity: ${uartParity.asString(parity)}');
    rtsCts == null
        ? sb.writeln('RTS/CTS: not set')
        : sb.writeln('RTS/CTS: $rtsCts - true is RTS');
    xonXoff == null
        ? sb.writeln('XON/XOFF: not set')
        : sb.writeln('XON/XOFF: $xonXoff - true is enabled');
    sb.writeln();
    return sb.toString();
  }
}
