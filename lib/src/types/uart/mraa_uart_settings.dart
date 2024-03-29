/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// UART settings as read back from the platform.
///
/// The device path can be set when passed to the settings function
/// in which case this will be used rather than the UART device index,
/// which itself must be set to -1.
/// Any setting can be null on return from the settings function call.
class MraaUartSettings {
  /// The device path of the UART, eg: /dev/ttyS0
  String devicePath = '';

  /// The name of the UART, not set by the settings API call
  /// the user must name the device themselves.
  String name = '';

  /// The current Baud rate (0–4M)
  int baudRate = 0;

  /// The number of data bits (5–8)
  int dataBits = 8;

  /// The number of stop bits (1-2)
  int stopBits = 1;

  /// The current parity mode
  MraaUartParity parity = MraaUartParity.none;

  /// True if CTS/RTS flow control is enabled, zero otherwise
  bool rtsCts = false;

  /// True if xon/xoff flow control is enabled
  bool xonXoff = false;

  @override
  String toString() {
    final sb = StringBuffer();
    sb.writeln('Device Path: $devicePath');
    sb.writeln('Name: $name');
    sb.writeln('Baud Rate: $baudRate');
    sb.writeln('Data Bits: $dataBits');
    sb.writeln('Stop Bits: $stopBits');
    sb.writeln('Parity: $parity)');
    sb.writeln('RTS/CTS: $rtsCts - true is RTS');
    sb.writeln('XON/XOFF: $xonXoff - true is enabled');
    sb.writeln();
    return sb.toString();
  }
}
