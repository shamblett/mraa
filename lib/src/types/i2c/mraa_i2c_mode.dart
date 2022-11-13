/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// I2C speeds/modes.
enum MraaI2cMode {
  /// Standard
  std(mraaimpl.mraa_i2c_mode_t.MRAA_I2C_STD),

  /// Fast
  fast(mraaimpl.mraa_i2c_mode_t.MRAA_I2C_FAST),

  /// High speed
  high(mraaimpl.mraa_i2c_mode_t.MRAA_I2C_HIGH),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaI2cMode> byCode = {};

  static MraaI2cMode i2cMode(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaI2cMode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret = byCode.containsKey(mode) ? byCode[mode] : MraaI2cMode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaI2cMode(this.code);
}
