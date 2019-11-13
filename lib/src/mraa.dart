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
    _lib = DynamicLibrary.open('libmraa.so');
  }

  /// Specify the library and path
  Mraa.fromLib(String libPath) {
    _lib = DynamicLibrary.open(libPath);
  }

  /// AIO read error
  static const int aioReadError = -1;

  /// AIO read double error
  static const double aioReadDoubleError = -1;

  /// General common function error
  static const int generalError = -1;

  /// Do not use JSON platform loading, some versions of MRAA do not
  /// support this, must be set for MRAA API <2.0.0 usage. Set this before
  /// initialising.
  bool noJsonLoading = false;

  /// Initialise the package, note this does NOT do an MRAA initialise
  /// if you need this call it separately. You MUST call this before usage.
  void initialise() {
    _setupAPI();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  /// The common API
  MraaCommon common;

  /// The GPIO API
  MraaGpio gpio;

  /// The AIO API
  MraaAio aio;

  /// The I2C API
  MraaI2c i2c;

  /// The LED API
  MraaLed led;

  /// The PWM API
  MraaPwm pwm;

  /// The SPI API
  MraaSpi spi;

  /// The UART API
  MraaUart uart;

  void _setupAPI() {
    common = MraaCommon(_lib, noJsonLoading);
    gpio = MraaGpio(_lib, noJsonLoading);
    aio = MraaAio(_lib, noJsonLoading);
    i2c = MraaI2c(_lib, noJsonLoading);
    led = MraaLed(_lib, noJsonLoading);
    pwm = MraaPwm(_lib, noJsonLoading);
    spi = MraaSpi(_lib, noJsonLoading);
    uart = MraaUart(_lib, noJsonLoading);
  }
}
