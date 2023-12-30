/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// GPIO Edge types for interrupts.
enum MraaGpioEdge {
  /// No interrupt on Gpio
  none(mraaimpl.mraa_gpio_edge_t.MRAA_GPIO_EDGE_NONE),

  /// Interrupt on rising & falling
  both(mraaimpl.mraa_gpio_edge_t.MRAA_GPIO_EDGE_BOTH),

  /// Interrupt on rising only
  rising(mraaimpl.mraa_gpio_edge_t.MRAA_GPIO_EDGE_RISING),

  /// Interrupt on falling only
  falling(mraaimpl.mraa_gpio_edge_t.MRAA_GPIO_EDGE_FALLING);

  static final Map<int, MraaGpioEdge> byCode = {};

  static MraaGpioEdge gpioEdge(int edge) {
    if (byCode.isEmpty) {
      for (final edge in MraaGpioEdge.values) {
        byCode[edge.code] = edge;
      }
    }

    final ret = byCode.containsKey(edge) ? byCode[edge] : MraaGpioEdge.none;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaGpioEdge(this.code);
}
