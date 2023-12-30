/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// GPIO input modes
enum MraaGpioInputMode {
  /// Resistive High
  activeHigh(mraaimpl.mraa_gpio_input_mode_t.MRAA_GPIO_ACTIVE_HIGH),

  /// Resistive Low
  activeLow(mraaimpl.mraa_gpio_input_mode_t.MRAA_GPIO_ACTIVE_LOW),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaGpioInputMode> byCode = {};

  static MraaGpioInputMode gpioInputModes(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaGpioInputMode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret =
        byCode.containsKey(mode) ? byCode[mode] : MraaGpioInputMode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaGpioInputMode(this.code);
}
