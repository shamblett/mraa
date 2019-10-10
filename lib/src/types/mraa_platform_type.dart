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
  mraaIntelGalileoGen1,

  /// The Generation 2 Galileo platform (RevG/H)
  mraaIntelGalileoGen2,

  /// The Intel Edison (FAB C)
  mraaIntelEdisonFabC,

  /// The Intel DE3815 Baytrail NUC
  mraaIntelDe3815,

  /// The Intel Minnow Board Max
  mraaIntelMinnowboardMax,

  /// The different Raspberry PI Models -like A,B,A+,B+
  mraaRaspberryPi,

  /// The different BeagleBone Black Modes B/C
  mraaBeaglebone,

  /// Allwinner A20 based Banana Pi and Banana Pro
  mraaBanana,

  /// The Intel 5th generations Broadwell NUCs
  mraaIntelNuc5,

  /// Linaro 96boards
  mraa96boards,

  /// The Intel SoFIA 3GR
  mraaIntelSofia3gr,

  /// The Intel Braswell Cherryhills
  mraaIntelCherryhills,

  /// The UP Board
  mraaUp,

  /// The Intel Joule Expansion Board
  mraaIntelJouleExpansion,

  /// The phyBOARD-Wega
  mraaPhyboardWega,

  /// Terasic DE-Nano-SoC Board
  mraaDeNanoSoc,

  /// The UP^2 Board
  mraaUp2,

  /// Mediatek MT7688 based Linkit boards
  mraaMtkLinkit,

  /// MT7688 based Onion Omega2 board
  mraaMtkOmega2,

  /// IEI Tank System
  mraaIeiTank,

  /// RockPI4
  mraaRockPi4,

  /// FTDI FT4222 USB to i2c bridge
  mraaFtdiFt4222,

  /// GrovePi shield i2c bridge
  mraaGrovepi,

  /// Firmata uart platform/bridge
  mraaGenericFirmata,

  /// Android Things peripheral manager platform
  mraaAndroidPeripheralmanager,

  /// Mock platform, which requires no real hardware
  mraaMockPlatform,

  /// User initialised platform from json
  mraaJsonPlatform,

  /// Platform with no capabilities that hosts a sub platform
  mraaNullPlatform,

  /// An unknown platform type, typically will load INTEL_GALILEO_GEN1
  mraaUnknownPlatform
}

/// Platform type support
const Map<int, MraaPlatformType> _platformTypeValues = <int, MraaPlatformType>{
  0: MraaPlatformType.mraaIntelGalileoGen1,
  1: MraaPlatformType.mraaIntelGalileoGen2,
  2: MraaPlatformType.mraaIntelEdisonFabC,
  3: MraaPlatformType.mraaIntelDe3815,
  4: MraaPlatformType.mraaIntelMinnowboardMax,
  5: MraaPlatformType.mraaRaspberryPi,
  6: MraaPlatformType.mraaBeaglebone,
  7: MraaPlatformType.mraaBanana,
  8: MraaPlatformType.mraaIntelNuc5,
  9: MraaPlatformType.mraa96boards,
  10: MraaPlatformType.mraaIntelSofia3gr,
  11: MraaPlatformType.mraaIntelCherryhills,
  12: MraaPlatformType.mraaUp,
  13: MraaPlatformType.mraaIntelJouleExpansion,
  14: MraaPlatformType.mraaPhyboardWega,
  15: MraaPlatformType.mraaDeNanoSoc,
  16: MraaPlatformType.mraaUp2,
  17: MraaPlatformType.mraaMtkLinkit,
  18: MraaPlatformType.mraaMtkOmega2,
  19: MraaPlatformType.mraaIeiTank,
  20: MraaPlatformType.mraaRockPi4,
  256: MraaPlatformType.mraaFtdiFt4222,
  1024: MraaPlatformType.mraaGrovepi,
  1280: MraaPlatformType.mraaGenericFirmata,
  95: MraaPlatformType.mraaAndroidPeripheralmanager,
  96: MraaPlatformType.mraaMockPlatform,
  97: MraaPlatformType.mraaJsonPlatform,
  98: MraaPlatformType.mraaNullPlatform,
  99: MraaPlatformType.mraaUnknownPlatform
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
