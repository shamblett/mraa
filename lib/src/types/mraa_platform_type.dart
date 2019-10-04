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
dynamic _valuesFuncPlatformType() => MraaPlatformType.values;

/// Platform types helper
MraaEnumHelper<MraaPlatformType> platformTypes =
    MraaEnumHelper<MraaPlatformType>(_valuesFuncPlatformType);
