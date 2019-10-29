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

}