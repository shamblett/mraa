/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The main MRAA interface.
///
/// MRAA allows Dart to interface with the I/O on Galileo, Edison & other platforms,
/// with a structured and sane API where port names/numbering matches the board that you are on.
/// Use of MRAA does not tie you to specific hardware with board detection
/// done at runtime you can create portable code that will work across
/// the supported platforms.
///
/// The intent is to make it easier for developers and sensor manufacturers
/// to map their sensors & actuators on top of supported hardware and to allow
/// control of low level communication protocol using Dart.
class Mraa {
  /// Default uses the platform library
  Mraa() {
    _impl = mraaimpl.MraaImpl(DynamicLibrary.open('libmraa.so'));
  }

  /// Specify the library and path
  Mraa.fromLib(String libPath) {
    _impl = mraaimpl.MraaImpl(DynamicLibrary.open(libPath));
  }

  /// The MRAA Implementation class
  late mraaimpl.MraaImpl _impl;

  /// AIO read error
  static const int aioReadError = -1;

  /// AIO read double error
  static const double aioReadDoubleError = -1;

  /// General common function error
  static int _generalError = -1;
  static int get generalError => _generalError;
  static set generalError(int val) {}

  /// Grove PI pin offset value
  static const int grovePiPinOffset = 512;

  /// Do not use JSON platform loading, some versions of MRAA do not
  /// support this, must be set for MRAA API <2.0.0 usage. Set this before
  /// initialising.
  bool noJsonLoading = false;

  /// Use the Grove Pi shield.
  /// Set this if you are using GPIO/AIO devices on a Raspberry PI through the
  /// Grove Pi shield. Set this before initialising.
  bool _useGrovePi = false;
  bool get useGrovePi => _useGrovePi;
  set useGrovePi(bool flag) {
    _generalError = flag ? -511 : -1;
    _useGrovePi = flag;
  }

  /// Initialise the package, note this does NOT do an MRAA initialise
  /// if you need this call it separately. You MUST call this before usage.
  void initialise() {
    _setupAPI();
    // Initialise the sub platform if using Grove Pi
    if (useGrovePi) {
      common.addSubplatform(MraaPlatformType.grovepi, '0');
    }
  }

  /// The common API
  late MraaCommon common;

  /// The GPIO API
  late MraaGpio gpio;

  /// The AIO API
  late MraaAio aio;

  /// The I2C API
  late MraaI2c i2c;

  /// The LED API
  late MraaLed led;

  /// The PWM API
  late MraaPwm pwm;

  /// The SPI API
  late MraaSpi spi;

  /// The UART API
  late MraaUart uart;

  void _setupAPI() {
    common = MraaCommon(_impl, noJsonLoading, useGrovePi);
    gpio = MraaGpio(_impl, noJsonLoading, useGrovePi);
    aio = MraaAio(_impl, noJsonLoading, useGrovePi);
    i2c = MraaI2c(_impl, noJsonLoading);
    led = MraaLed(_impl, noJsonLoading);
    pwm = MraaPwm(_impl, noJsonLoading, useGrovePi);
    //spi = MraaSpi(_impl, noJsonLoading);
    //uart = MraaUart(_impl, noJsonLoading);
  }
}
