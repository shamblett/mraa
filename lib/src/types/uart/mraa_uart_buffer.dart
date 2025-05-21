/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// UART RX/TX buffer.
class MraaUartBuffer {
  /// The TX/RX buffer for UTF8 methods
  String utf8Data = '';

  /// The TX/RX buffer for byte(Uint8) methods
  Uint8List byteData = Uint8List(1);

  /// UTF8 Length
  int get utf8Length => utf8Data.length;

  /// Uint Length
  int get byteLength => byteData.length;
}
