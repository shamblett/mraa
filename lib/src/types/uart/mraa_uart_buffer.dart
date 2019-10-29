/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// UART RX/TX buffer class
class MraaUartBuffer {
  /// The TX/RX buffer
  String data;

  /// Length
  int get length => data == null ? 0 : data.length;
}
