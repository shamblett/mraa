/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

// ignore_for_file: public_member_api_docs

/// UART parities.
enum MraaUartParity { none, even, odd, mark, space }

/// SPI mode type support
const Map<int, MraaUartParity> _uartParityValues = <int, MraaUartParity>{
  0: MraaUartParity.none,
  1: MraaUartParity.even,
  2: MraaUartParity.odd,
  3: MraaUartParity.mark,
  4: MraaUartParity.space
};

/// SPI mode types helper
MraaEnumHelper<MraaUartParity> uartParity =
    MraaEnumHelper<MraaUartParity>(_uartParityValues);
