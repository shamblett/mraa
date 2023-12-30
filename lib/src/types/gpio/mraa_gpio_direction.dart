/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// GPIO pin directions.
enum MraaGpioDirection {
  /// Out
  out(mraaimpl.mraa_gpio_dir_t.MRAA_GPIO_OUT),

  /// In
  inn(mraaimpl.mraa_gpio_dir_t.MRAA_GPIO_IN),

  /// Out high
  outHigh(mraaimpl.mraa_gpio_dir_t.MRAA_GPIO_OUT_HIGH),

  /// Out Low
  outLow(mraaimpl.mraa_gpio_dir_t.MRAA_GPIO_OUT_LOW),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaGpioDirection> byCode = {};

  static MraaGpioDirection gpioDirections(int direction) {
    if (byCode.isEmpty) {
      for (final direction in MraaGpioDirection.values) {
        byCode[direction.code] = direction;
      }
    }

    final ret = byCode.containsKey(direction)
        ? byCode[direction]
        : MraaGpioDirection.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaGpioDirection(this.code);
}
