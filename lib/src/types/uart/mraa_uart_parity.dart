/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// UART parities.
enum MraaUartParity {
  none(mraaimpl.mraa_uart_parity_t.MRAA_UART_PARITY_NONE),

  even(mraaimpl.mraa_uart_parity_t.MRAA_UART_PARITY_EVEN),

  odd(mraaimpl.mraa_uart_parity_t.MRAA_UART_PARITY_ODD),

  mark(mraaimpl.mraa_uart_parity_t.MRAA_UART_PARITY_MARK),

  space(mraaimpl.mraa_uart_parity_t.MRAA_UART_PARITY_SPACE),

  unknown(-1);

  static final Map<int, MraaUartParity> byCode = {};

  static MraaUartParity uartParity(int parity) {
    if (byCode.isEmpty) {
      for (final parity in MraaUartParity.values) {
        byCode[parity.code] = parity;
      }
    }

    final ret =
        byCode.containsKey(parity) ? byCode[parity] : MraaUartParity.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaUartParity(this.code);
}
