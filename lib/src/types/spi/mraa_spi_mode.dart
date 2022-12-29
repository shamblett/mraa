/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// SPI modes.
enum MraaSpiMode {
  /// CPOL = 0, CPHA = 0, Clock idle low, data is clocked in on rising edge,
  /// output data (change) on falling edge
  mode0(mraaimpl.mraa_spi_mode_t.MRAA_SPI_MODE0),

  /// CPOL = 0, CPHA = 1, Clock idle low, data is clocked in on falling edge,
  /// output data (change) on rising edge
  mode1(mraaimpl.mraa_spi_mode_t.MRAA_SPI_MODE1),

  /// CPOL = 1, CPHA = 0, Clock idle low, data is clocked in on falling edge,
  /// output data (change) on rising edge
  mode2(mraaimpl.mraa_spi_mode_t.MRAA_SPI_MODE2),

  /// CPOL = 1, CPHA = 1, Clock idle low, data is clocked in on rising, edge
  /// output data (change) on falling edge
  mode3(mraaimpl.mraa_spi_mode_t.MRAA_SPI_MODE3),

  /// Unknown
  unknown(-1);

  static final Map<int, MraaSpiMode> byCode = {};

  static MraaSpiMode spiMode(int mode) {
    if (byCode.isEmpty) {
      for (final mode in MraaSpiMode.values) {
        byCode[mode.code] = mode;
      }
    }

    final ret = byCode.containsKey(mode) ? byCode[mode] : MraaSpiMode.unknown;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaSpiMode(this.code);
}
