/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The Common MRAA API
///
/// Defines the basic shared functions and values for MRAA.
class MraaCommon {
  /// Construction
  MraaCommon(this._impl, this._noJsonLoading, this._useGrovePi) {
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  final bool _noJsonLoading;

  final bool _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  /// Version - mraa_get_version
  ///
  /// Get the version string of this MRAA library autogenerated
  /// from its git tag.
  /// The version returned may not be what is expected however
  /// it is a reliable number associated with the git tag closest
  /// to that version at build time.
  String version() {
    final ptr = _impl.mraa_get_version();
    if (ptr != nullptr) {
      return ptr.cast<ffi.Utf8>().toDartString();
    }
    return 'Version information is unavailable';
  }

  /// Initialise - mraa_init
  ///
  /// Initialise MRAA
  ///
  /// Detects the running platform and attempts to use the included pinmap,
  /// this is run on a module/library init/load but is handy to rerun to
  /// check the board initialised correctly.
  MraaReturnCode initialise() => returnCode.fromInt(_impl.mraa_init());

  /// Platform name - mraa_get_platform_name
  ///
  /// Return the Platform's name.
  /// If no platform is detected NULL is returned.
  String platformName() {
    final ptr = _impl.mraa_get_platform_name();
    if (ptr != nullptr) {
      return ptr.cast<ffi.Utf8>().toDartString();
    }
    return 'Platform Name is unavailable';
  }

  /// Platform version - mraa_get_platform_version
  ///
  /// Return the platform's versioning info, the information given
  /// depends per platform and can be NULL.
  /// [platformOffset] is 0 for the main platform, and 1 for sub platform.
  String platformVersion(int platformOffset) {
    final ptr = _impl.mraa_get_platform_version(platformOffset);
    if (ptr != nullptr) {
      return ptr.cast<ffi.Utf8>().toDartString();
    }
    return 'Platform Version is unavailable';
  }

  /// Platform type - mraa_get_platform_type
  ///
  /// Get the platform type, the board must be initialised.
  MraaPlatformType platformType() =>
      platformTypes.fromInt(_impl.mraa_get_platform_type());

  /// Initialise JSON platform - mraa_init_json_platform
  ///
  /// Instantiate an unknown board from a json file
  MraaReturnCode initialiseJsonPlatform(String path) => _noJsonLoading
      ? MraaReturnCode.errorFeatureNotSupported
      : returnCode.fromInt(
          _impl.mraa_init_json_platform(path.toNativeUtf8().cast<Char>()));

  /// Set the log level - mraa_set_log_level
  ///
  /// Sets the log level to use from 0-7 where 7 is very verbose.
  /// These are the syslog log levels, see syslog(3) for more
  /// information on the levels.
  MraaReturnCode setLogLevel(int level) =>
      returnCode.fromInt(_impl.mraa_set_log_level(level));

  /// Pin mode test - mraa_pin_mode_test
  ///
  /// Checks if a pin is able to use the requested mode.
  /// Returns true if the mode is supported.
  bool pinmodeTest(int pin, MraaPinmode mode) {
    final ret =
        _impl.mraa_pin_mode_test(pin + _grovePiPinOffset, pinmode.asInt(mode));
    return ret != 0;
  }

  /// ADC raw bits - mraa_adc_raw_bits
  ///
  /// Get the board's bit size in use when reading analogue values.
  /// Returns 0 if no ADC.
  int adcRawBits() => _impl.mraa_adc_raw_bits();

  /// Platform ADC raw bits - mraa_get_platform_adc_raw_bits
  ///
  /// Get the board's bit size in use when reading analogue values.
  /// [platformOffset] is 0 for the main platform, 1 for a sub platform
  /// Returns 0 if no ADC.
  int platformAdcRawBits(int platformOffset) =>
      _impl.mraa_get_platform_adc_raw_bits(platformOffset);

  /// ADC supported bits - mraa_adc_supported_bits
  ///
  /// The value that the raw value should be shifted to,
  /// i.e. the actual bit size the ADC value should be
  /// understood as.
  /// Returns 0 if no ADC.
  int adcSupportedBits() => _impl.mraa_adc_supported_bits();

  /// Platform ADC supported bits - mraa_get_platform_adc_supported_bits
  ///
  /// The value that the raw value should be shifted to
  /// i.e. the actual bit size the ADC value should be
  ///  understood as.
  /// [platformOffset] is 0 for the main platform, 1 for a sub platform
  /// Returns 0 if no ADC
  int platformAdcSupportedBits(int platformOffset) =>
      _impl.mraa_get_platform_adc_supported_bits(platformOffset);

  /// Set priority - mraa_set_priority
  ///
  /// This function attempts to set the process to a given
  /// priority and the scheduler to SCHED_RR. The highest priority is
  /// typically 99 and the minimum is 0
  /// Returns [Mraa.generalError] on failure.
  int setPriority(int priority) => _impl.mraa_set_priority(priority);

  /// Result print - mraa_result_print
  ///
  /// Print a textual representation of the MRAA integer result type.
  void resultPrint(int result) => _impl.mraa_result_print(result);

  /// Platform combined type - mraa_get_platform_combined_type
  ///
  /// Get the combined platform type, the board must be initialised.
  /// The combined type is represented as
  /// (sub_platform_type << 8) | main_platform_type.
  /// Use the [MraaCombinedTypeDecode] class and the
  /// [decodeCombinedType] support function to decode.
  int platformCombinedType() => _impl.mraa_get_platform_combined_type();

  /// Pin count - mraa_get_pin_count
  ///
  /// Get the platform pin count, the board must be initialised.
  int pinCount() => _impl.mraa_get_pin_count();

  /// UART count - mraa_get_uart_count
  ///
  /// Get the number of usable UARTs, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int uartCount() => _impl.mraa_get_uart_count();

  /// SPI Bus count - mraa_get_spi_bus_count
  ///
  /// Get the number of usable SPI buses, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int spiBusCount() => _impl.mraa_get_spi_bus_count();

  /// PWM count - mraa_get_pwm_count
  ///
  /// Get the number of usable PWM pins, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int pwmCount() => _impl.mraa_get_pwm_count();

  /// GPIO count - mraa_get_gpio_count
  ///
  /// Get the number of usable GPIOs, the board must be initialised
  /// Returns [Mraa.generalError] on failure.
  int gpioCount() => _impl.mraa_get_gpio_count();

  /// AIO count - mraa_get_gpio_count
  ///
  /// Get the number of usable analogue pins, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int aioCount() => _impl.mraa_get_aio_count();

  /// I2C Bus count - mraa_get_i2c_bus_count
  ///
  /// Get platform usable I2C bus count, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int i2cBusCount() => _impl.mraa_get_i2c_bus_count();

  /// I2C Bus Id - mraa_get_i2c_bus_id
  ///
  /// Gets the I2C adapter number in sysfs given the logical I2C bus number.
  ///Returns [Mraa.generalError] on failure.
  int i2cBusId(int i2cBus) => _impl.mraa_get_i2c_bus_id(i2cBus);

  /// Platform pin count - mraa_get_platform_pin_count
  ///
  /// Get the specified platform pin count, the board must be initialised.
  /// [offset] is 0 for the main platform, 1 for a sub platform.
  int platformPinCount(int offset) => _impl.mraa_get_platform_pin_count(offset);

  /// Pin name - mraa_get_pin_name
  ///
  /// Get the name of a pin, the board must be initialised.
  String pinName(int pinNumber) => _impl
      .mraa_get_pin_name(pinNumber + _grovePiPinOffset)
      .cast<ffi.Utf8>()
      .toDartString();

  /// GPIO lookup - mraa_gpio_lookup
  ///
  /// Get the GPIO index by pin name, the board must be initialised.
  /// Returns the MRAA index for GPIO or [Mraa.generalError] on error.
  int gpioLookup(String pinName) =>
      _impl.mraa_gpio_lookup(pinName.toNativeUtf8().cast<Char>());

  /// I2C lookup - mraa_i2c_lookup
  ///
  /// Get the I2C bus index by bus name, the board must be initialised.
  /// Returns the MRAA index for I2C bus or [Mraa.generalError] on error.
  int i2cLookup(String i2cName) =>
      _impl.mraa_i2c_lookup(i2cName.toNativeUtf8().cast<Char>());

  /// SPI lookup - mraa_spi_lookup
  ///
  /// Get the SPI bus index by bus name, the board must be initialised.
  /// Returns the MRAA index for SPI bus or [Mraa.generalError] on error.
  int spiLookup(String spiName) =>
      _impl.mraa_spi_lookup(spiName.toNativeUtf8().cast<Char>());

  /// PWM lookup - mraa_pwm_lookup
  ///
  /// Get the PWM index by name, the board must be initialised.
  /// Returns the MRAA index for PWM name or [Mraa.generalError] on error.
  int pwmLookup(String pwmName) =>
      _impl.mraa_pwm_lookup(pwmName.toNativeUtf8().cast<Char>());

  /// UART lookup - mraa_uart_lookup
  ///
  /// Get the UART index by name, the board must be initialised.
  /// Returns the MRAA index for the UART name or [Mraa.generalError] on error.
  int uartLookup(String uartName) =>
      _impl.mraa_uart_lookup(uartName.toNativeUtf8().cast<Char>());

  /// Default I2c bus - mraa_get_default_i2c_bus
  ///
  /// Get the default I2C bus, the board must be initialised.
  int defaultI2cBus(int platformOffset) =>
      _impl.mraa_get_default_i2c_bus(platformOffset);

  /// Has sub platform - mraa_has_sub_platform
  ///
  /// Detect the presence of sub platform.
  /// Returns true if a sub platform is present and initialized.
  bool hasSubPlatform() {
    final ret = _impl.mraa_has_sub_platform();
    return ret == 1;
  }

  /// Is sub platform id - mraa_is_sub_platform_id
  ///
  /// Check if a pin or bus id includes a sub platform mask.
  /// Returns true if the pin or bus id is for a sub platform.
  bool isSubPlatformId(int pinOrBusId) {
    final ret = _impl.mraa_is_sub_platform_id(pinOrBusId);
    return ret == 1;
  }

  /// Sub platform id - mraa_get_sub_platform_id
  ///
  /// Convert a pin or bus index to its corresponding sub platform id.
  int subPlatformId(int pinOrBusIndex) =>
      _impl.mraa_get_sub_platform_id(pinOrBusIndex);

  /// Sub platform index - mraa_get_sub_platform_index
  ///
  /// Convert a pin or bus sub platform id to its index.
  int subPlatformIndex(int pinOrBusId) =>
      _impl.mraa_get_sub_platform_index(pinOrBusId);

  /// Add sub platform - mraa_add_subplatform
  ///
  /// Add MRAA sub platform
  /// Parameters are the sub platform type and the device or
  /// I2C bus the sub platform is on.
  MraaReturnCode addSubplatform(MraaPlatformType subplatformType, String dev) =>
      returnCode.fromInt(_impl.mraa_add_subplatform(
          platformTypes.asInt(subplatformType),
          dev.toNativeUtf8().cast<Char>()));

  /// Remove subplatform - mraa_remove_subplatform
  ///
  /// Remove an MRAA sub platform
  /// Parameters are the sub platform type and the device or
  /// I2C bus the sub platform is on.
  MraaReturnCode removeSubplatform(MraaPlatformType subplatformType) =>
      returnCode.fromInt(
          _impl.mraa_remove_subplatform(platformTypes.asInt(subplatformType)));
}
