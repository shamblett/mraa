/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The different possible modes for a pin.
enum MraaPinmode {
  /// Pin Valid
  valid(mraaimpl.mraa_pinmodes_t.MRAA_PIN_VALID),

  /// General Purpose IO
  gpio(mraaimpl.mraa_pinmodes_t.MRAA_PIN_GPIO),

  /// Pulse Width Modulation
  pwm(mraaimpl.mraa_pinmodes_t.MRAA_PIN_PWM),

  /// Faster GPIO
  fastGpio(mraaimpl.mraa_pinmodes_t.MRAA_PIN_FAST_GPIO),

  /// SPI
  spi(mraaimpl.mraa_pinmodes_t.MRAA_PIN_SPI),

  /// I2C
  i2c(mraaimpl.mraa_pinmodes_t.MRAA_PIN_I2C),

  /// Analog in
  aio(mraaimpl.mraa_pinmodes_t.MRAA_PIN_AIO),

  /// UART
  uart(mraaimpl.mraa_pinmodes_t.MRAA_PIN_UART),

  /// Unknown pin mode
  unknown(-1);

  static final Map<int, MraaPinmode> byCode = {};

  static MraaPinmode pinmode(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaPinmode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret = byCode.containsKey(mode) ? byCode[mode] : MraaPinmode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaPinmode(this.code);
}
