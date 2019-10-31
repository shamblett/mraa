/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

// ignore_for_file: avoid_private_typedef_functions

part of mraa;

/// C Function signature typedefs
typedef _returnMraaCommonStringNoParametersFunc = Pointer<ffi.Utf8> Function();
typedef _returnMraaCommonStringIntParametersFunc = Pointer<ffi.Utf8> Function(Int32);
typedef _returnMraaCommonIntNoParametersFunc = Int32 Function();
typedef _returnMraaCommonIntIntParametersFunc = Int32 Function(Int32);
typedef _returnMraaCommonIntStringParametersFunc = Int32 Function(Pointer<ffi.Utf8>);
typedef _returnMraaCommonInt2IntParametersFunc = Int32 Function(Int32, Int32);
typedef _returnMraaCommonVoidIntParametersFunc = Void Function(Int32);
typedef _returnMraaCommonIntUint8ParametersFunc = Int32 Function(Uint8);
typedef _returnMraaCommonIntIntStringParametersFunc = Int32 Function(
    Int32, Pointer<ffi.Utf8>);

/// Dart Function typedefs
typedef _MraaCommonVersionType = Pointer<ffi.Utf8> Function();
typedef _MraaCommonPlatformVersionType = Pointer<ffi.Utf8> Function(int);
typedef _MraaCommonInitialiseType = int Function();
typedef _MraaCommonPlatformNameType = Pointer<ffi.Utf8> Function();
typedef _MraaCommonPlatformTypeType = int Function();
typedef _MraaCommonInitJsonPlatformType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonSetLogLevelType = int Function(int);
typedef _MraaCommonPinmodeTestType = int Function(int, int);
typedef _MraaCommonADCRawBitsType = int Function();
typedef _MraaCommonPlatformAdcRawBitsType = int Function(int);
typedef _MraaCommonAdcSupportedBitsType = int Function();
typedef _MraaCommonPlatformAdcSupportedBitsType = int Function(int);
typedef _MraaCommonSetPriorityType = int Function(int);
typedef _MraaCommonResultPrintType = void Function(int);
typedef _MraaCommonPlatformCombinedTypeType = int Function();
typedef _MraaCommonPinCountType = int Function();
typedef _MraaCommonUartCountType = int Function();
typedef _MraaCommonSpiBusCountType = int Function();
typedef _MraaCommonPwmCountType = int Function();
typedef _MraaCommonGpioCountType = int Function();
typedef _MraaCommonAioCountType = int Function();
typedef _MraaCommonI2cBusCountType = int Function();
typedef _MraaCommonI2cBusIdType = int Function(int);
typedef _MraaCommonPlatformPinCountType = int Function(int);
typedef _MraaCommonPinNameType = Pointer<ffi.Utf8> Function(int);
typedef _MraaCommonGpioLookupType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonI2cLookupType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonSpiLookupType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonPwmLookupType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonUartLookupType = int Function(Pointer<ffi.Utf8>);
typedef _MraaCommonDefaultI2cBusType = int Function(int);
typedef _MraaCommonHasSubPlatformType = int Function();
typedef _MraaCommonIsSubPlatformIdType = int Function(int);
typedef _MraaCommonSubPlatformIdType = int Function(int);
typedef _MraaCommonSubPlatformIndexType = int Function(int);
typedef _MraaCommonAddSubplatformType = int Function(int, Pointer<ffi.Utf8>);
typedef _MraaCommonRemoveSubplatformType = int Function(int);

/// The Common MRAA API
///
/// Defines the basic shared functions and values for MRAA.
class MraaCommon {
  /// Construction
  MraaCommon(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  Pointer<NativeFunction<_returnMraaCommonStringNoParametersFunc>> _versionPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _initialisePointer;
  Pointer<NativeFunction<_returnMraaCommonStringNoParametersFunc>> _platformNamePointer;
  Pointer<NativeFunction<_returnMraaCommonStringIntParametersFunc>>
      _platformVersionPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _platformTypePointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>>
      _initJsonPlatformPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _setLogLevelPointer;
  Pointer<NativeFunction<_returnMraaCommonInt2IntParametersFunc>> _pinmodeTestPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _adcRawBitsPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>>
      _platformAdcRawBitsPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _adcSupportedBitsPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>>
      _platformAdcSupportedBitsPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _setPriorityPointer;
  Pointer<NativeFunction<_returnMraaCommonVoidIntParametersFunc>> _resultPrintPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>>
      _platformCombinedTypePointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _pinCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _uartCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _spiBusCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _pwmCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _gpioCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _aioCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _i2cBusCountPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _i2cBusIdPointer;
  Pointer<NativeFunction<_returnMraaCommonIntUint8ParametersFunc>>
      _platformPinCountPointer;
  Pointer<NativeFunction<_returnMraaCommonStringIntParametersFunc>> _pinNamePointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>> _gpioLookupPointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>> _i2cLookupPointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>> _spiLookupPointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>> _pwmLookupPointer;
  Pointer<NativeFunction<_returnMraaCommonIntStringParametersFunc>> _uartLookupPointer;
  Pointer<NativeFunction<_returnMraaCommonIntUint8ParametersFunc>> _defaultI2cBusPointer;
  Pointer<NativeFunction<_returnMraaCommonIntNoParametersFunc>> _hasSubPlatformPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _isSubPlatformIdPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _subPlatformIdPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _subPlatformIndexPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntStringParametersFunc>>
      _addSubplatformPointer;
  Pointer<NativeFunction<_returnMraaCommonIntIntParametersFunc>> _removeSubplatformPointer;

  /// Dart Functions
  _MraaCommonVersionType _versionFunc;
  _MraaCommonInitialiseType _initFunc;
  _MraaCommonPlatformNameType _platformNameFunc;
  _MraaCommonPlatformVersionType _platformVersionFunc;
  _MraaCommonPlatformTypeType _platformTypeFunc;
  _MraaCommonInitJsonPlatformType _initJsonPlatformFunc;
  _MraaCommonSetLogLevelType _setLogLevelFunc;
  _MraaCommonPinmodeTestType _pinModeTestFunc;
  _MraaCommonADCRawBitsType _adcRawBitsFunc;
  _MraaCommonPlatformAdcRawBitsType _platformAdcRawBitsFunc;
  _MraaCommonAdcSupportedBitsType _adcSupportedBitsFunc;
  _MraaCommonPlatformAdcSupportedBitsType _platformAdcSupportedBitsFunc;
  _MraaCommonSetPriorityType _setPriorityFunc;
  _MraaCommonResultPrintType _resultPrintFunc;
  _MraaCommonPlatformCombinedTypeType _platformCombinedTypeFunc;
  _MraaCommonPinCountType _pinCountTypeFunc;
  _MraaCommonUartCountType _uartCountTypeFunc;
  _MraaCommonSpiBusCountType _spiBusCountTypeFunc;
  _MraaCommonPwmCountType _pwmCountTypeFunc;
  _MraaCommonGpioCountType _gpioCountTypeFunc;
  _MraaCommonAioCountType _aioCountTypeFunc;
  _MraaCommonI2cBusCountType _i2cBusCountTypeFunc;
  _MraaCommonI2cBusIdType _i2cBusIdFunc;
  _MraaCommonPlatformPinCountType _platformPinCountFunc;
  _MraaCommonPinNameType _pinNameFunc;
  _MraaCommonGpioLookupType _gpioLookupFunc;
  _MraaCommonI2cLookupType _i2cLookupFunc;
  _MraaCommonSpiLookupType _spiLookupFunc;
  _MraaCommonPwmLookupType _pwmLookupFunc;
  _MraaCommonUartLookupType _uartLookupFunc;
  _MraaCommonDefaultI2cBusType _defaultI2cBusFunc;
  _MraaCommonHasSubPlatformType _hasSubPlatformFunc;
  _MraaCommonIsSubPlatformIdType _isSubPlatformIdFunc;
  _MraaCommonSubPlatformIdType _subPlatformIdFunc;
  _MraaCommonSubPlatformIndexType _subPlatformIndexFunc;
  _MraaCommonAddSubplatformType _addSubplatformFunc;
  _MraaCommonRemoveSubplatformType _removeSubplatformFunc;

  /// Version - mraa_get_version
  ///
  /// Get the version string of this MRAA library autogenerated from its git tag.
  /// The version returned may not be what is expected however it is a reliable number
  /// associated with the git tag closest to that version at build time.
  String version() => ffi.Utf8.fromUtf8(_versionFunc());

  /// Initialise - mraa_init
  ///
  /// Initialise MRAA
  ///
  /// Detects the running platform and attempts to use the included pinmap,
  /// this is run on a module/library init/load but is handy to rerun to
  /// check the board initialised correctly.
  MraaReturnCode initialise() => returnCode.fromInt(_initFunc());

  /// Platform name - mraa_get_platform_name
  ///
  /// Return the Platform's name.
  /// If no platform is detected NULL is returned.
  String platformName() => ffi.Utf8.fromUtf8(_platformNameFunc());

  /// Platform version - mraa_get_platform_version
  ///
  /// Return the platform's versioning info, the information given depends per platform and can be NULL.
  /// [platformOffset] is 0 for the main platform, and 1 for sub platform.
  String platformVersion(int platformOffset) {
    final Pointer<ffi.Utf8> retPtr = _platformVersionFunc(platformOffset);
    if (retPtr == nullptr) {
      return 'No platform version set - maybe a mock board?';
    }
    return ffi.Utf8.fromUtf8(_platformVersionFunc(platformOffset));
  }

  /// Platform type - mraa_get_platform_type
  ///
  /// Get the platform type, the board must be initialised.
  MraaPlatformType platformType() => platformTypes.fromInt(_platformTypeFunc());

  /// Initialise JSON platform - mraa_init_json_platform
  ///
  /// Instantiate an unknown board from a json file
  MraaReturnCode initialiseJsonPlatform(String path) => _noJsonLoading
      ? MraaReturnCode.errorFeatureNotSupported
      : returnCode.fromInt(_initJsonPlatformFunc(ffi.Utf8.toUtf8(path)));

  /// Set the log level - mraa_set_log_level
  ///
  /// Sets the log level to use from 0-7 where 7 is very verbose.
  /// These are the syslog log levels, see syslog(3) for more information on the levels.
  MraaReturnCode setLogLevel(int level) =>
      returnCode.fromInt(_setLogLevelFunc(level));

  /// Pin mode test - mraa_pin_mode_test
  ///
  /// Checks if a pin is able to use the requested mode.
  /// Returns true if the mode is supported.
  bool pinmodeTest(int pin, MraaPinmode mode) {
    final int ret = _pinModeTestFunc(pin, pinmode.asInt(mode));
    return ret != 0;
  }

  /// ADC raw bits - mraa_adc_raw_bits
  ///
  /// Get the board's bit size in use when reading analogue values.
  /// Returns 0 if no ADC.
  int adcRawBits() => _adcRawBitsFunc();

  /// Platform ADC raw bits - mraa_platform_adc_raw_bits
  ///
  /// Get the board's bit size in use when reading analogue values.
  /// [platformOffset] is 0 for the main platform, 1 for a sub platform
  /// Returns 0 if no ADC.
  int platformAdcRawBits(int platformOffset) =>
      _platformAdcRawBitsFunc(platformOffset);

  /// ADC supported bits - mraa_adc_supported_bits
  ///
  /// The value that the raw value should be shifted to,
  /// i.e. the actual bit size the ADC value should be
  /// understood as.
  /// Returns 0 if no ADC.
  int adcSupportedBits() => _adcSupportedBitsFunc();

  /// Platform ADC supported bits - mraa_platform_adc_supported_bits
  ///
  /// The value that the raw value should be shifted to
  /// i.e. the actual bit size the ADC value should be
  ///  understood as.
  /// [platformOffset] is 0 for the main platform, 1 for a sub platform
  /// Returns 0 if no ADC
  int platformAdcSupportedBits(int platformOffset) =>
      _platformAdcSupportedBitsFunc(platformOffset);

  /// Set priority - mraa_set_prority
  ///
  /// This function attempts to set the process to a given priority and the scheduler
  /// to SCHED_RR. The highest priority is typically 99 and the minimum is 0
  /// Returns [Mraa.generalError] on failure.
  int setPriority(int priority) => _setPriorityFunc(priority);

  /// Result print - mraa_result_print
  ///
  /// Print a textual representation of the MRAA integer result type.
  void resultPrint(int result) => _resultPrintFunc(result);

  /// Platform combined type - mraa_get_platform_combined_type
  ///
  /// Get the combined platform type, the board must be initialised.
  /// The combined type is represented as (sub_platform_type << 8) | main_platform_type.
  /// Use the [MraaCombinedTypeDecode] class and the [decodeCombinedType] support
  /// function to decode.
  int platformCombinedType() => _platformCombinedTypeFunc();

  /// Pin count - mraa_get_pin_count
  ///
  /// Get the platform pin count, the board must be initialised.
  int pinCount() => _pinCountTypeFunc();

  /// UART count - mraa_get_uart_count
  ///
  /// Get the number of usable UARTs, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int uartCount() => _uartCountTypeFunc();

  /// SPI Bus count - mraa_get_spi_bus_count
  ///
  /// Get the number of usable SPI buses, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int spiBusCount() => _spiBusCountTypeFunc();

  /// PWM count - mraa_get_pwm_count
  /// Get the number of usable PWM pins, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int pwmCount() => _pwmCountTypeFunc();

  /// GPIO count - mraa_get_gpio_count
  ///
  /// Get the number of usable GPIOs, the board must be initialised
  /// Returns [Mraa.generalError] on failure.
  int gpioCount() => _gpioCountTypeFunc();

  /// AIO count - mraa_get_gpio_count
  ///
  /// Get the number of usable analogue pins, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int aioCount() => _aioCountTypeFunc();

  /// I2C Bus count - mraa_get_i2c_bus_count
  ///
  /// Get platform usable I2C bus count, the board must be initialised.
  /// Returns [Mraa.generalError] on failure.
  int i2cBusCount() => _i2cBusCountTypeFunc();

  /// I2C Bus Id - mraa_get_i2c_bus_id
  ///
  /// Gets the I2C adapter number in sysfs given the logical I2C bus number.
  ///Returns [Mraa.generalError] on failure.
  int i2cBusId(int i2cBus) => _i2cBusIdFunc(i2cBus);

  /// Platform pin count - mraa_get_platform_pin_count
  ///
  /// Get the specified platform pin count, the board must be initialised.
  /// [platformOffset] is 0 for the main platform, 1 for a sub platform.
  int platformPinCount(int offset) => _platformPinCountFunc(offset);

  /// Pin name - mraa_get_pin_name
  ///
  /// Get the name of a pin, the board must be initialised.
  String pinName(int pinNumber) => ffi.Utf8.fromUtf8(_pinNameFunc(pinNumber));

  /// GPIO lookup - mraa_gpio_lookup
  ///
  /// Get the GPIO index by pin name, the board must be initialised.
  /// Returns the MRAA index for GPIO or [Mraa.generalError] on error.
  int gpioLookup(String pinName) => _gpioLookupFunc(ffi.Utf8.toUtf8(pinName));

  /// I2C lookup - mraa_i2c_lookup
  ///
  /// Get the I2C bus index by bus name, the board must be initialised.
  /// Returns the MRAA index for I2C bus or [Mraa.generalError] on error.
  int i2cLookup(String i2cName) => _i2cLookupFunc(ffi.Utf8.toUtf8(i2cName));

  /// SPI lookup - mraa_spi_lookup
  ///
  /// Get the SPI bus index by bus name, the board must be initialised.
  /// Returns the MRAA index for SPI bus or [Mraa.generalError] on error.
  int spiLookup(String spiName) => _spiLookupFunc(ffi.Utf8.toUtf8(spiName));

  /// PWM lookup - mraa_pwm_lookup
  ///
  /// Get the PWM index by name, the board must be initialised.
  /// Returns the MRAA index for PWM name or [Mraa.generalError] on error.
  int pwmLookup(String pwmName) => _pwmLookupFunc(ffi.Utf8.toUtf8(pwmName));

  /// UART lookup - mraa_uart_lookup
  ///
  /// Get the UART index by name, the board must be initialised.
  /// Returns the MRAA index for the UART name or [Mraa.generalError] on error.
  int uartLookup(String uartName) => _uartLookupFunc(ffi.Utf8.toUtf8(uartName));

  /// Default I2c bus - mraa_get_default_i2c_bus
  ///
  /// Get the default I2C bus, the board must be initialised.
  int defaultI2cBus(int platformOffset) => _defaultI2cBusFunc(platformOffset);

  /// Has sub platform - mraa_has_sub_platform
  ///
  /// Detect the presence of sub platform.
  /// Returns true if a sub platform is present and initialized.
  bool hasSubPlatform() {
    final int ret = _hasSubPlatformFunc();
    return ret == 1;
  }

  /// Is sub platform id - mraa_is_sub_platform_id
  ///
  /// Check if a pin or bus id includes a sub platform mask.
  /// Returns true if the pin or bus id is for a sub platform.
  bool isSubPlatformId(int pinOrBusId) {
    final int ret = _isSubPlatformIdFunc(pinOrBusId);
    return ret == 1;
  }

  /// Sub platform id - mraa_get_sub_platform_id
  ///
  /// Convert a pin or bus index to its corresponding sub platform id.
  int subPlatformId(int pinOrBusIndex) => _subPlatformIdFunc(pinOrBusIndex);

  /// Sub platform index - mraa_get_sub_platform_index
  ///
  /// Convert a pin or bus sub platform id to its index.
  int subPlatformIndex(int pinOrBusId) => _subPlatformIndexFunc(pinOrBusId);

  /// Add sub platform - mraa_add_subplatform
  ///
  /// Add MRAA sub platform
  /// Parameters are the sub platform type and the device or I2C bus the sub platform is on.
  MraaReturnCode addSubplatform(MraaPlatformType subplatformType, String dev) =>
      returnCode.fromInt(_addSubplatformFunc(
          platformTypes.asInt(subplatformType), ffi.Utf8.toUtf8(dev)));

  /// Remove subplatform - mraa_remove_subplatform
  ///
  /// Remove an MRAA sub platform
  /// Parameters are the sub platform type and the device or I2C bus the sub platform is on.
  MraaReturnCode removeSubplatform(MraaPlatformType subplatformType) =>
      returnCode.fromInt(
          _removeSubplatformFunc(platformTypes.asInt(subplatformType)));

  void _setUpPointers() {
    _versionPointer = _lib.lookup<NativeFunction<_returnMraaCommonStringNoParametersFunc>>(
        'mraa_get_version');
    _initialisePointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>('mraa_init');
    _platformNamePointer =
        _lib.lookup<NativeFunction<_returnMraaCommonStringNoParametersFunc>>(
            'mraa_get_platform_name');
    _platformVersionPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonStringIntParametersFunc>>(
            'mraa_get_platform_version');
    _platformTypePointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_get_platform_type');
    if (!_noJsonLoading) {
      _initJsonPlatformPointer =
          _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
              'mraa_init_json_platform');
    }
    _setLogLevelPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_set_log_level');
    _pinmodeTestPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonInt2IntParametersFunc>>(
            'mraa_pin_mode_test');
    _adcRawBitsPointer = _lib
        .lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>('mraa_adc_raw_bits');
    _platformAdcRawBitsPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_get_platform_adc_raw_bits');
    _adcSupportedBitsPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_adc_supported_bits');
    _platformAdcSupportedBitsPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_get_platform_adc_supported_bits');
    _setPriorityPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_set_priority');
    _resultPrintPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonVoidIntParametersFunc>>(
            'mraa_result_print');
    _platformCombinedTypePointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_get_platform_combined_type');
    _pinCountPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
        'mraa_get_pin_count');
    _uartCountPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
        'mraa_get_uart_count');
    _spiBusCountPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_get_spi_bus_count');
    _pwmCountPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
        'mraa_get_pwm_count');
    _gpioCountPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
        'mraa_get_gpio_count');
    _aioCountPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
        'mraa_get_aio_count');
    _i2cBusCountPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_get_i2c_bus_count');
    _i2cBusIdPointer = _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
        'mraa_get_i2c_bus_id');
    _platformPinCountPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntUint8ParametersFunc>>(
            'mraa_get_platform_pin_count');
    _pinNamePointer =
        _lib.lookup<NativeFunction<_returnMraaCommonStringIntParametersFunc>>(
            'mraa_get_pin_name');
    _gpioLookupPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
            'mraa_gpio_lookup');
    _i2cLookupPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
            'mraa_i2c_lookup');
    _spiLookupPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
            'mraa_spi_lookup');
    _pwmLookupPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
            'mraa_pwm_lookup');
    _uartLookupPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntStringParametersFunc>>(
            'mraa_uart_lookup');
    _defaultI2cBusPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntUint8ParametersFunc>>(
            'mraa_get_default_i2c_bus');
    _hasSubPlatformPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntNoParametersFunc>>(
            'mraa_has_sub_platform');
    _isSubPlatformIdPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_is_sub_platform_id');
    _subPlatformIdPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_get_sub_platform_id');
    _subPlatformIndexPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_get_sub_platform_index');
    _addSubplatformPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntStringParametersFunc>>(
            'mraa_add_subplatform');
    _removeSubplatformPointer =
        _lib.lookup<NativeFunction<_returnMraaCommonIntIntParametersFunc>>(
            'mraa_remove_subplatform');
  }

  void _setUpFunctions() {
    _versionFunc = _versionPointer.asFunction<_MraaCommonVersionType>();
    _initFunc = _initialisePointer.asFunction<_MraaCommonInitialiseType>();
    _platformNameFunc =
        _platformNamePointer.asFunction<_MraaCommonPlatformNameType>();
    _platformVersionFunc =
        _platformVersionPointer.asFunction<_MraaCommonPlatformVersionType>();
    _platformTypeFunc =
        _platformTypePointer.asFunction<_MraaCommonPlatformTypeType>();
    if (!_noJsonLoading) {
      _initJsonPlatformFunc =
          _initJsonPlatformPointer.asFunction<_MraaCommonInitJsonPlatformType>();
    }
    _setLogLevelFunc =
        _setLogLevelPointer.asFunction<_MraaCommonSetLogLevelType>();
    _pinModeTestFunc =
        _pinmodeTestPointer.asFunction<_MraaCommonPinmodeTestType>();
    _adcRawBitsFunc = _adcRawBitsPointer.asFunction<_MraaCommonADCRawBitsType>();
    _platformAdcRawBitsFunc = _platformAdcRawBitsPointer
        .asFunction<_MraaCommonPlatformAdcRawBitsType>();
    _adcSupportedBitsFunc =
        _adcSupportedBitsPointer.asFunction<_MraaCommonAdcSupportedBitsType>();
    _platformAdcSupportedBitsFunc = _platformAdcSupportedBitsPointer
        .asFunction<_MraaCommonPlatformAdcSupportedBitsType>();
    _setPriorityFunc =
        _setPriorityPointer.asFunction<_MraaCommonSetPriorityType>();
    _resultPrintFunc =
        _resultPrintPointer.asFunction<_MraaCommonResultPrintType>();
    _platformCombinedTypeFunc = _platformCombinedTypePointer
        .asFunction<_MraaCommonPlatformCombinedTypeType>();
    _pinCountTypeFunc = _pinCountPointer.asFunction<_MraaCommonPinCountType>();
    _uartCountTypeFunc =
        _uartCountPointer.asFunction<_MraaCommonUartCountType>();
    _spiBusCountTypeFunc =
        _spiBusCountPointer.asFunction<_MraaCommonSpiBusCountType>();
    _pwmCountTypeFunc = _pwmCountPointer.asFunction<_MraaCommonPwmCountType>();
    _gpioCountTypeFunc =
        _gpioCountPointer.asFunction<_MraaCommonGpioCountType>();
    _aioCountTypeFunc = _aioCountPointer.asFunction<_MraaCommonAioCountType>();
    _i2cBusCountTypeFunc =
        _i2cBusCountPointer.asFunction<_MraaCommonI2cBusCountType>();
    _i2cBusIdFunc = _i2cBusIdPointer.asFunction<_MraaCommonI2cBusIdType>();
    _platformPinCountFunc =
        _platformPinCountPointer.asFunction<_MraaCommonPlatformPinCountType>();
    _pinNameFunc = _pinNamePointer.asFunction<_MraaCommonPinNameType>();
    _gpioLookupFunc = _gpioLookupPointer.asFunction<_MraaCommonGpioLookupType>();
    _i2cLookupFunc = _i2cLookupPointer.asFunction<_MraaCommonI2cLookupType>();
    _spiLookupFunc = _spiLookupPointer.asFunction<_MraaCommonSpiLookupType>();
    _pwmLookupFunc = _pwmLookupPointer.asFunction<_MraaCommonPwmLookupType>();
    _uartLookupFunc = _uartLookupPointer.asFunction<_MraaCommonUartLookupType>();
    _defaultI2cBusFunc =
        _defaultI2cBusPointer.asFunction<_MraaCommonDefaultI2cBusType>();
    _hasSubPlatformFunc =
        _hasSubPlatformPointer.asFunction<_MraaCommonHasSubPlatformType>();
    _isSubPlatformIdFunc =
        _isSubPlatformIdPointer.asFunction<_MraaCommonIsSubPlatformIdType>();
    _subPlatformIdFunc =
        _subPlatformIdPointer.asFunction<_MraaCommonSubPlatformIdType>();
    _subPlatformIndexFunc =
        _subPlatformIndexPointer.asFunction<_MraaCommonSubPlatformIndexType>();
    _addSubplatformFunc =
        _addSubplatformPointer.asFunction<_MraaCommonAddSubplatformType>();
    _removeSubplatformFunc =
        _removeSubplatformPointer.asFunction<_MraaCommonRemoveSubplatformType>();
  }
}
