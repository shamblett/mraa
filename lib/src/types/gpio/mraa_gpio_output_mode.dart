/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// GPIO output modes.
enum MraaGpioOutputMode {
  /// Default. Strong high and low
  strong(mraaimpl.mraa_gpio_mode_t.MRAA_GPIO_STRONG),

  /// Resistive High
  pullup(mraaimpl.mraa_gpio_mode_t.MRAA_GPIO_PULLUP),

  /// Resistive Low
  pulldown(mraaimpl.mraa_gpio_mode_t.MRAA_GPIO_PULLDOWN),

  /// High Z State
  hiz(mraaimpl.mraa_gpio_mode_t.MRAA_GPIO_HIZ),
  activeLow(mraaimpl.mraa_gpio_mode_t.MRAA_GPIOD_ACTIVE_LOW),
  openDrain(mraaimpl.mraa_gpio_mode_t.MRAA_GPIOD_OPEN_DRAIN),
  openSource(mraaimpl.mraa_gpio_mode_t.MRAA_GPIOD_OPEN_SOURCE),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaGpioOutputMode> byCode = {};

  static MraaGpioOutputMode gpioOutputModes(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaGpioOutputMode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret =
        byCode.containsKey(mode) ? byCode[mode] : MraaGpioOutputMode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaGpioOutputMode(this.code);
}
