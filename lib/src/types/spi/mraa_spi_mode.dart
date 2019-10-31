/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// SPI modes.
enum MraaSpiMode {
  /// CPOL = 0, CPHA = 0, Clock idle low, data is clocked in on rising edge, output data (change) on falling edge
  mode0,

  /// CPOL = 0, CPHA = 1, Clock idle low, data is clocked in on falling edge, output data (change) on rising edge
  mode1,

  /// CPOL = 1, CPHA = 0, Clock idle low, data is clocked in on falling edge, output data (change) on rising edge
  mode2,

  /// CPOL = 1, CPHA = 1, Clock idle low, data is clocked in on rising, edge output data (change) on falling edge
  mode3
}

/// SPI mode type support
const Map<int, MraaSpiMode> _spiModeValues = <int, MraaSpiMode>{
  0: MraaSpiMode.mode0,
  1: MraaSpiMode.mode1,
  2: MraaSpiMode.mode2,
  3: MraaSpiMode.mode3
};

/// SPI mode types helper
MraaEnumHelper<MraaSpiMode> spiMode =
    MraaEnumHelper<MraaSpiMode>(_spiModeValues);
