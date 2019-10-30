/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The main MRAA class
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
  static const double aioReadDoubleError = -1.0;

  /// General common function error
  static const int generalError = -1;

  /// Do not use JSON platform loading, some versions of MRAA do not
  /// support this, must be set for MRAA API 1.0.0 usage. Set this before
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
