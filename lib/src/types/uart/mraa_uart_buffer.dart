/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// UART RX/TX buffer.
class MraaUartBuffer {
  /// The TX/RX buffer for UTF8 methods
  String utf8Data;

  /// UTF8 Length
  int get utf8Length => utf8Data == null ? 0 : utf8Data.length;

  /// The TX/RX buffer for byte(Uint8) methods
  Uint8List byteData;

  /// Uint Length
  int get byteLength => byteData == null ? 0 : byteData.length;
}
