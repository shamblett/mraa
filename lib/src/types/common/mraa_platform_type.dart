/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// Mraa platform types
enum MraaPlatformType {
  /// The Generation 1 Galileo platform (RevD)
  intelGalileoGen1,

  /// The Generation 2 Galileo platform (RevG/H)
  intelGalileoGen2,

  /// The Intel Edison (FAB C)
  intelEdisonFabC,

  /// The Intel DE3815 Baytrail NUC
  intelDe3815,

  /// The Intel Minnow Board Max
  intelMinnowboardMax,

  /// The different Raspberry PI Models -like A,B,A+,B+
  raspberryPi,

  /// The different BeagleBone Black Modes B/C
  beaglebone,

  /// Allwinner A20 based Banana Pi and Banana Pro
  banana,

  /// The Intel 5th generations Broadwell NUCs
  intelNuc5,

  /// Linaro 96boards
  a96boards,

  /// The Intel SoFIA 3GR
  intelSofia3gr,

  /// The Intel Braswell Cherryhills
  intelCherryhills,

  /// The UP Board
  up,

  /// The Intel Joule Expansion Board
  intelJouleExpansion,

  /// The phyBOARD-Wega
  phyboardWega,

  /// Terasic DE-Nano-SoC Board
  deNanoSoc,

  /// The UP^2 Board
  up2,

  /// Mediatek MT7688 based Linkit boards
  mtkLinkit,

  /// MT7688 based Onion Omega2 board
  mtkOmega2,

  /// IEI Tank System
  ieiTank,

  /// RockPI4
  rockPi4,

  /// FTDI FT4222 USB to i2c bridge
  ftdiFt4222,

  /// GrovePi shield i2c bridge
  grovepi,

  /// Firmata uart platform/bridge
  genericFirmata,

  /// Android Things peripheral manager platform
  androidPeripheralmanager,

  /// Mock platform, which requires no real hardware
  mockPlatform,

  /// User initialised platform from json
  jsonPlatform,

  /// Platform with no capabilities that hosts a sub platform
  nullPlatform,

  /// An unknown platform type, typically will load INTEL_GALILEO_GEN1
  unknownPlatform
}

/// Platform type support
const Map<int, MraaPlatformType> _platformTypeValues = <int, MraaPlatformType>{
  0: MraaPlatformType.intelGalileoGen1,
  1: MraaPlatformType.intelGalileoGen2,
  2: MraaPlatformType.intelEdisonFabC,
  3: MraaPlatformType.intelDe3815,
  4: MraaPlatformType.intelMinnowboardMax,
  5: MraaPlatformType.raspberryPi,
  6: MraaPlatformType.beaglebone,
  7: MraaPlatformType.banana,
  8: MraaPlatformType.intelNuc5,
  9: MraaPlatformType.a96boards,
  10: MraaPlatformType.intelSofia3gr,
  11: MraaPlatformType.intelCherryhills,
  12: MraaPlatformType.up,
  13: MraaPlatformType.intelJouleExpansion,
  14: MraaPlatformType.phyboardWega,
  15: MraaPlatformType.deNanoSoc,
  16: MraaPlatformType.up2,
  17: MraaPlatformType.mtkLinkit,
  18: MraaPlatformType.mtkOmega2,
  19: MraaPlatformType.ieiTank,
  20: MraaPlatformType.rockPi4,
  256: MraaPlatformType.ftdiFt4222,
  1024: MraaPlatformType.grovepi,
  1280: MraaPlatformType.genericFirmata,
  95: MraaPlatformType.androidPeripheralmanager,
  96: MraaPlatformType.mockPlatform,
  97: MraaPlatformType.jsonPlatform,
  98: MraaPlatformType.nullPlatform,
  99: MraaPlatformType.unknownPlatform
};

/// Platform types helper
MraaEnumHelper<MraaPlatformType> platformTypes =
    MraaEnumHelper<MraaPlatformType>(_platformTypeValues);

/// Get sub platform and main platform from a platform combined type function call
class MraaCombinedTypeDecode {
  /// Main platform type
  MraaPlatformType mainPlatform;

  /// Sub platform type
  MraaPlatformType subPlatform;
}

/// Combined type function decoder
MraaCombinedTypeDecode decodeCombinedType(int value) {
  final MraaCombinedTypeDecode ret = MraaCombinedTypeDecode();
  ret.mainPlatform = platformTypes.fromInt(value & 0xFF);
  ret.subPlatform = platformTypes.fromInt(value & (0xFF00 << 8));
  return ret;
}
