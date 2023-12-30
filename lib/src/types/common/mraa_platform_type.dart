/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../../mraa.dart';

/// MRAA platform types
enum MraaPlatformType {
  /// The Generation 1 Galileo platform (RevD)
  intelGalileoGen1(mraaimpl.mraa_platform_t.MRAA_INTEL_GALILEO_GEN1),

  /// The Generation 2 Galileo platform (RevG/H)
  intelGalileoGen2(mraaimpl.mraa_platform_t.MRAA_INTEL_GALILEO_GEN2),

  /// The Intel Edison (FAB C)
  intelEdisonFabC(mraaimpl.mraa_platform_t.MRAA_INTEL_EDISON_FAB_C),

  /// The Intel DE3815 Baytrail NUC
  intelDe3815(mraaimpl.mraa_platform_t.MRAA_INTEL_DE3815),

  /// The Intel Minnow Board Max
  intelMinnowboardMax(mraaimpl.mraa_platform_t.MRAA_INTEL_MINNOWBOARD_MAX),

  /// The different Raspberry PI Models -like A,B,A+,B+
  raspberryPi(mraaimpl.mraa_platform_t.MRAA_RASPBERRY_PI),

  /// The different BeagleBone Black Modes B/C
  beaglebone(mraaimpl.mraa_platform_t.MRAA_BEAGLEBONE),

  /// Allwinner A20 based Banana Pi and Banana Pro
  banana(mraaimpl.mraa_platform_t.MRAA_BANANA),

  /// The Intel 5th generations Broadwell NUCs
  intelNuc5(mraaimpl.mraa_platform_t.MRAA_INTEL_NUC5),

  /// Linaro 96boards
  a96boards(mraaimpl.mraa_platform_t.MRAA_96BOARDS),

  /// The Intel SoFIA 3GR
  intelSofia3gr(mraaimpl.mraa_platform_t.MRAA_INTEL_SOFIA_3GR),

  /// The Intel Braswell Cherryhills
  intelCherryhills(mraaimpl.mraa_platform_t.MRAA_INTEL_CHERRYHILLS),

  /// The UP Board
  up(mraaimpl.mraa_platform_t.MRAA_UP),

  /// The Intel Joule Expansion Board
  intelJouleExpansion(mraaimpl.mraa_platform_t.MRAA_INTEL_JOULE_EXPANSION),

  /// The phyBOARD-Wega
  phyboardWega(mraaimpl.mraa_platform_t.MRAA_PHYBOARD_WEGA),

  /// Terasic DE-Nano-SoC Board
  deNanoSoc(mraaimpl.mraa_platform_t.MRAA_DE_NANO_SOC),

  /// The UP^2 Board
  up2(mraaimpl.mraa_platform_t.MRAA_UP2),

  /// Mediatek MT7688 based Linkit boards
  mtkLinkit(mraaimpl.mraa_platform_t.MRAA_MTK_LINKIT),

  /// MT7688 based Onion Omega2 board
  mtkOmega2(mraaimpl.mraa_platform_t.MRAA_MTK_OMEGA2),

  /// IEI Tank System
  ieiTank(mraaimpl.mraa_platform_t.MRAA_IEI_TANK),

  /// RockPI4
  rockPi4(mraaimpl.mraa_platform_t.MRAA_ROCKPI4),

  /// FTDI FT4222 USB to i2c bridge
  ftdiFt4222(mraaimpl.mraa_platform_t.MRAA_FTDI_FT4222),

  /// GrovePi shield i2c bridge
  grovepi(mraaimpl.mraa_platform_t.MRAA_GROVEPI),

  /// Firmata uart platform/bridge
  genericFirmata(mraaimpl.mraa_platform_t.MRAA_GENERIC_FIRMATA),

  /// Android Things peripheral manager platform
  androidPeripheralmanager(
      mraaimpl.mraa_platform_t.MRAA_ANDROID_PERIPHERALMANAGER),

  /// Mock platform, which requires no real hardware
  mockPlatform(mraaimpl.mraa_platform_t.MRAA_MOCK_PLATFORM),

  /// User initialised platform from json
  jsonPlatform(mraaimpl.mraa_platform_t.MRAA_JSON_PLATFORM),

  /// Platform with no capabilities that hosts a sub platform
  nullPlatform(mraaimpl.mraa_platform_t.MRAA_NULL_PLATFORM),

  /// An unknown platform type, typically will load INTEL_GALILEO_GEN1
  unknownPlatform(mraaimpl.mraa_platform_t.MRAA_UNKNOWN_PLATFORM);

  static final Map<int, MraaPlatformType> byCode = {};

  static MraaPlatformType platformTypes(int type) {
    if (byCode.isEmpty) {
      for (final type in MraaPlatformType.values) {
        byCode[type.code] = type;
      }
    }

    final ret = byCode.containsKey(type)
        ? byCode[type]
        : MraaPlatformType.unknownPlatform;
    return ret!;
  }

  @override
  String toString() {
    return "$name($code)";
  }

  final int code;

  const MraaPlatformType(this.code);
}

/// Get sub platform and main platform from a platform combined
/// type function call.
class MraaCombinedTypeDecode {
  /// Main platform type
  MraaPlatformType mainPlatform = MraaPlatformType.mockPlatform;

  /// Sub platform type
  MraaPlatformType subPlatform = MraaPlatformType.mockPlatform;
}

/// Combined type function decoder
MraaCombinedTypeDecode decodeCombinedType(int value) {
  final ret = MraaCombinedTypeDecode();
  ret.mainPlatform = MraaPlatformType.platformTypes(value & 0xFF);
  ret.subPlatform = MraaPlatformType.platformTypes(value & (0xFF00 << 8));
  return ret;
}
