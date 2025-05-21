/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// GPIO output driver modes.
enum MraaGpioOutputDriverMode {
  /// Open Drain Configuration
  openDrain(mraaimpl.mraa_gpio_out_driver_mode_t.MRAA_GPIO_OPEN_DRAIN),

  /// Push Pull Configuration
  pushPull(mraaimpl.mraa_gpio_out_driver_mode_t.MRAA_GPIO_PUSH_PULL),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaGpioOutputDriverMode> byCode = {};

  static MraaGpioOutputDriverMode gpioOutputDriverModes(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaGpioOutputDriverMode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret =
        byCode.containsKey(mode)
            ? byCode[mode]
            : MraaGpioOutputDriverMode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaGpioOutputDriverMode(this.code);
}
