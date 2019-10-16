/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnStringNoParametersFunc = ffi.Pointer<Utf8> Function();
typedef returnStringIntParametersFunc = ffi.Pointer<Utf8> Function(ffi.Int32);
typedef returnIntNoParametersFunc = ffi.Int32 Function();
typedef returnIntIntParametersFunc = ffi.Int32 Function(ffi.Int32);
typedef returnIntStringParametersFunc = ffi.Int32 Function(ffi.Pointer<Utf8>);
typedef returnInt2IntParametersFunc = ffi.Int32 Function(ffi.Int32, ffi.Int32);
typedef returnVoidIntParametersFunc = ffi.Void Function(ffi.Int32);
typedef returnIntUint8ParametersFunc = ffi.Int32 Function(ffi.Uint8);
typedef returnIntIntStringParametersFunc = ffi.Int32 Function(
    ffi.Int32, ffi.Pointer<Utf8>);

/// Dart Function typedefs
typedef MraaCommonVersionType = ffi.Pointer<Utf8> Function();
typedef MraaCommonPlatformVersionType = ffi.Pointer<Utf8> Function(int);
typedef MraaCommonInitialiseType = int Function();
typedef MraaCommonPlatformNameType = ffi.Pointer<Utf8> Function();
typedef MraaCommonPlatformTypeType = int Function();
typedef MraaCommonInitJsonPlatformType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonSetLogLevelType = int Function(int);
typedef MraaCommonPinmodeTestType = int Function(int, int);
typedef MraaCommonADCRawBitsType = int Function();
typedef MraaCommonPlatformAdcRawBitsType = int Function(int);
typedef MraaCommonAdcSupportedBitsType = int Function();
typedef MraaCommonPlatformAdcSupportedBitsType = int Function(int);
typedef MraaCommonSetPriorityType = int Function(int);
typedef MraaCommonResultPrintType = void Function(int);
typedef MraaCommonPlatformCombinedTypeType = int Function();
typedef MraaCommonPinCountType = int Function();
typedef MraaCommonUartCountType = int Function();
typedef MraaCommonSpiBusCountType = int Function();
typedef MraaCommonPwmCountType = int Function();
typedef MraaCommonGpioCountType = int Function();
typedef MraaCommonAioCountType = int Function();
typedef MraaCommonI2cBusCountType = int Function();
typedef MraaCommonI2cBusIdType = int Function(int);
typedef MraaCommonPlatformPinCountType = int Function(int);
typedef MraaCommonPinNameType = ffi.Pointer<Utf8> Function(int);
typedef MraaCommonGpioLookupType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonI2cLookupType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonSpiLookupType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonPwmLookupType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonUartLookupType = int Function(ffi.Pointer<Utf8>);
typedef MraaCommonDefaultI2cBusType = int Function(int);
typedef MraaCommonHasSubPlatformType = int Function();
typedef MraaCommonIsSubPlatformIdType = int Function(int);
typedef MraaCommonSubPlatformIdType = int Function(int);
typedef MraaCommonSubPlatformIndexType = int Function(int);
typedef MraaCommonAddSubplatformType = int Function(int, ffi.Pointer<Utf8>);

/// The Common MRAA API
class _MraaCommon {
  _MraaCommon(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnStringNoParametersFunc>> _versionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _initialisePointer;
  ffi.Pointer<ffi.NativeFunction<returnStringNoParametersFunc>>
      _platformNamePointer;
  ffi.Pointer<ffi.NativeFunction<returnStringIntParametersFunc>>
      _platformVersionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _platformTypePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _initJsonPlatformPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _setLogLevelPointer;
  ffi.Pointer<ffi.NativeFunction<returnInt2IntParametersFunc>>
      _pinmodeTestPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _adcRawBitsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _platformAdcRawBitsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _adcSupportedBitsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _platformAdcSupportedBitsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _setPriorityPointer;
  ffi.Pointer<ffi.NativeFunction<returnVoidIntParametersFunc>>
      _resultPrintPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _platformCombinedTypePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _pinCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _uartCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _spiBusCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _pwmCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _gpioCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>> _aioCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _i2cBusCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>> _i2cBusIdPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntUint8ParametersFunc>>
      _platformPinCountPointer;
  ffi.Pointer<ffi.NativeFunction<returnStringIntParametersFunc>>
      _pinNamePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _gpioLookupPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _i2cLookupPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _spiLookupPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _pwmLookupPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntStringParametersFunc>>
      _uartLookupPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntUint8ParametersFunc>>
      _defaultI2cBusPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntNoParametersFunc>>
      _hasSubPlatformPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _isSubPlatformIdPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _subPlatformIdPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntParametersFunc>>
      _subPlatformIndexPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntIntStringParametersFunc>>
      _addSubplatformPointer;

  /// Dart Functions
  dynamic _versionFunc;
  dynamic _initFunc;
  dynamic _platformNameFunc;
  dynamic _platformVersionFunc;
  dynamic _platformTypeFunc;
  dynamic _initJsonPlatformFunc;
  dynamic _setLogLevelFunc;
  dynamic _pinModeTestFunc;
  dynamic _adcRawBitsFunc;
  dynamic _platformAdcRawBitsFunc;
  dynamic _adcSupportedBitsFunc;
  dynamic _platformAdcSupportedBitsFunc;
  dynamic _setPriorityFunc;
  dynamic _resultPrintFunc;
  dynamic _platformCombinedTypeFunc;
  dynamic _pinCountTypeFunc;
  dynamic _uartCountTypeFunc;
  dynamic _spiBusCountTypeFunc;
  dynamic _pwmCountTypeFunc;
  dynamic _gpioCountTypeFunc;
  dynamic _aioCountTypeFunc;
  dynamic _i2cBusCountTypeFunc;
  dynamic _i2cBusIdFunc;
  dynamic _platformPinCountFunc;
  dynamic _pinNameFunc;
  dynamic _gpioLookupFunc;
  dynamic _i2cLookupFunc;
  dynamic _spiLookupFunc;
  dynamic _pwmLookupFunc;
  dynamic _uartLookupFunc;
  dynamic _defaultI2cBusFunc;
  dynamic _hasSubPlatformFunc;
  dynamic _isSubPlatformIdFunc;
  dynamic _subPlatformIdFunc;
  dynamic _subPlatformIndexFunc;
  dynamic _addSubplatformFunc;

  /// Version - mraa_get_version
  /// Get the version string of mraa autogenerated from git tag
  /// The version returned may not be what is expected however it is a reliable number
  /// associated with the git tag closest to that version at build time.
  String version() => Utf8.fromUtf8(_versionFunc());

  /// Initialise - mraa_init
  /// Initialise MRAA
  /// Detects running platform and attempts to use included pinmap, this is run on module/library
  /// init/load but is handy to rerun to check board initialised correctly.
  /// MRAA_SUCCESS indicates correct initialisation.
  MraaReturnCode initialise() => returnCode.fromInt(_initFunc());

  /// Platform name - mraa_get_platform_name
  /// Return the Platform's Name, If no platform detected return NULL
  String platformName() => Utf8.fromUtf8(_platformNameFunc());

  /// Platform version - mraa_get_platform_version
  /// Return the platform's versioning info, the information given depends per platform and can be NULL.
  /// platform_offset has to be given. 0 for main platform, 1 for sub platform.
  String platformVersion(int platformOffset) =>
      Utf8.fromUtf8(_platformVersionFunc(platformOffset));

  /// Platform type - mraa_get_platform_type
  /// Get platform type, board must be initialised.
  MraaPlatformType platformType() => platformTypes.fromInt(_platformTypeFunc());

  /// Initialise JSON platform - mraa_init_json_platform
  /// Instantiate an unknown board using a json file
  MraaReturnCode initialiseJsonPlatform(String path) => _noJsonLoading
      ? MraaReturnCode.mraaErrorFeatureNotSupported
      : returnCode.fromInt(_initJsonPlatformFunc(Utf8.toUtf8(path)));

  /// Set the log level - mraa_set_log_level
  /// Sets the log level to use from 0-7 where 7 is very verbose.
  /// These are the syslog log levels, see syslog(3) for more information on the levels.
  MraaReturnCode setLogLevel(int level) =>
      returnCode.fromInt(_setLogLevelFunc(level));

  /// Pin mode test - mraa_pin_mode_test
  /// Checks if a pin is able to use the passed in mode.
  /// True if the mode is supported
  bool pinmodeTest(int pin, MraaPinmode mode) {
    final int ret = _pinModeTestFunc(pin, pinmode.asInt(mode));
    return ret == 1;
  }

  /// ADC raw bits - mraa_adc_raw_bits
  /// Check the board's bit size when reading the value
  /// 0 if no ADC
  int adcRawBits() => _adcRawBitsFunc();

  /// Platform ADC raw bits - mraa_platform_adc_raw_bits
  /// Check the board's bit size when reading the value
  /// Specified platform offset; 0 for main platform, 1 for sub platform
  /// 0 if no ADC
  int platformAdcRawBits(int platformOffset) =>
      _platformAdcRawBitsFunc(platformOffset);

  /// ADC supported bits - mraa_adc_supported_bits
  /// The value that the raw value should be shifted to,
  /// i.e. the actual bit size the adc value should be
  /// understood as.
  /// 0 if no ADC
  int adcSupportedBits() => _adcSupportedBitsFunc();

  /// Platform ADC supported bits - mraa_platform_adc_supported_bits
  /// The value that the raw value should be shifted to
  /// i.e. the actual bit size the adc value should be
  ///  understood as.
  /// Specified platform offset; 0 for main platform, 1 for sub platform
  /// 0 if no ADC
  int platformAdcSupportedBits(int platformOffset) =>
      _platformAdcSupportedBitsFunc(platformOffset);

  /// Set priority - mraa_set_prority
  /// This function attempts to set the mraa process to a given priority and the scheduler
  /// to SCHED_RR. Highest priority is typically 99 and minimum is 0
  /// Return is mraaGeneralError on failure.
  int setPriority(int priority) => _setPriorityFunc(priority);

  /// Result print - mraa_result_print
  /// Print a textual representation of the MraaReturCodes type
  void resultPrint(int result) => _resultPrintFunc(result);

  /// Platform combined type - mraa_get_platform_combined_type
  /// Get combined platform type, board must be initialised.
  /// The combined type is represented as (sub_platform_type << 8) | main_platform_type.
  int platformCombinedType() => _platformCombinedTypeFunc();

  /// Pin count - mraa_get_pin_count
  /// Get platform pincount, board must be initialised.
  int pinCount() => _pinCountTypeFunc();

  /// Uart count - mraa_get_uart_count
  /// Get the number of usable UARTs, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int uartCount() => _uartCountTypeFunc();

  /// SPI Bus count - mraa_get_spi_bus_count
  /// Get the number of usable SPI buses, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int spiBusCount() => _spiBusCountTypeFunc();

  /// PWM count - mraa_get_pwm_count
  /// Get the number of usable PWM pins, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int pwmCount() => _pwmCountTypeFunc();

  /// GPIO count - mraa_get_gpio_count
  /// Get the number of usable GPIOs, board must be initialised
  /// Returns mraaGeneralError on failure.
  int gpioCount() => _gpioCountTypeFunc();

  /// AIO count - mraa_get_gpio_count
  /// Get the number of usable analog pins, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int aioCount() => _aioCountTypeFunc();

  /// I2C Bus count - mraa_get_i2c_bus_count
  /// Get platform usable I2C bus count, board must be initialised.
  /// Returns mraaGeneralError on failure.
  int i2cBusCount() => _i2cBusCountTypeFunc();

  /// I2C Bus Id - mraa_get_i2c_bus_id
  /// Gets the I2C adapter number in sysfs given the logical I2C bus number
  /// Returns mraaGeneralError on failure.
  int i2cBusId(int i2cBus) => _i2cBusIdFunc(i2cBus);

  /// Platform pin count - mraa_get_platform_pin_count
  /// Get specified platform pincount, board must be initialised.
  /// Using the specified platform offset; 0 for main platform, 1 for sub platform
  int platformPinCount(int offset) => _platformPinCountFunc(offset);

  /// Pin name - mraa_get_pin_name
  /// Get name of pin, board must be initialised.
  String pinName(int pinNumber) => Utf8.fromUtf8(_pinNameFunc(pinNumber));

  /// GPIO lookup - mraa_gpio_lookup
  /// Get GPIO index by pin name, board must be initialised.
  /// Returns MRAA index for GPIO or mraaGeneralError if not found.
  int gpioLookup(String pinName) => _gpioLookupFunc(Utf8.toUtf8(pinName));

  /// I2C lookup - mraa_i2c_lookup
  /// Get I2C bus index by bus name, board must be initialised.
  /// Returns MRAA index for I2C bus or mraaGeneralError if not found.
  int i2cLookup(String i2cName) => _i2cLookupFunc(Utf8.toUtf8(i2cName));

  /// SPI lookup - mraa_spi_lookup
  /// Get SPI bus index by bus name, board must be initialised.
  /// Returns MRAA index for SPI bus or mraaGeneralError if not found.
  int spiLookup(String spiName) => _spiLookupFunc(Utf8.toUtf8(spiName));

  /// PWM lookup - mraa_pwm_lookup
  /// Get PWM index by name, board must be initialised.
  /// Returns MRAA index for PWM name or mraaGeneralError if not found.
  int pwmLookup(String pwmName) => _pwmLookupFunc(Utf8.toUtf8(pwmName));

  /// UART lookup - mraa_uart_lookup
  /// Get UART index by name, board must be initialised.
  /// Returns MRAA index for UART name or mraaGeneralError if not found.
  int uartLookup(String uartName) => _uartLookupFunc(Utf8.toUtf8(uartName));

  /// Default I2c bus - mraa_get_default_i2c_bus
  /// Get default I2C bus, board must be initialised.
  int defaultI2cBus(int platformOffset) => _defaultI2cBusFunc(platformOffset);

  /// Has sub platform - mraa_has_sub_platform
  /// Detect presence of sub platform.
  /// Returns true if sub platform is present and initialized.
  bool hasSubPlatform() {
    final int ret = _hasSubPlatformFunc();
    return ret == 1;
  }

  /// Is sub platform id - mraa_is_sub_platform_id
  /// Check if pin or bus id includes sub platform mask.
  /// Returns true if pin or bus is for sub platform
  bool isSubPlatformId(int pinOrBusId) {
    final int ret = _isSubPlatformIdFunc(pinOrBusId);
    return ret == 1;
  }

  /// Sub platform id - mraa_get_sub_platform_id
  /// Convert pin or bus index to corresponding sub platform id.
  int subPlatformId(int pinOrBusIndex) => _subPlatformIdFunc(pinOrBusIndex);

  /// Sub platform index - mraa_get_sub_platform_index
  /// Convert pin or bus sub platform id to index.
  int subPlatformIndex(int pinOrBusId) => _subPlatformIndexFunc(pinOrBusId);

  /// Add subplatform - mraa_add_subplatform
  /// Add mraa subplatform
  /// Parameters are the subplatform type and the device or I2C bus the subplatform is on.
  MraaReturnCode addSubplatform(MraaPlatformType subplatformType, String dev) =>
      returnCode.fromInt(_addSubplatformFunc(
          platformTypes.asInt(subplatformType), Utf8.toUtf8(dev)));

  void _setUpPointers() {
    _versionPointer =
        _lib.lookup<ffi.NativeFunction<returnStringNoParametersFunc>>(
            'mraa_get_version');
    _initialisePointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>('mraa_init');
    _platformNamePointer =
        _lib.lookup<ffi.NativeFunction<returnStringNoParametersFunc>>(
            'mraa_get_platform_name');
    _platformVersionPointer =
        _lib.lookup<ffi.NativeFunction<returnStringIntParametersFunc>>(
            'mraa_get_platform_version');
    _platformTypePointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_platform_type');
    if (!_noJsonLoading) {
      _initJsonPlatformPointer =
          _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
              'mraa_init_json_platform');
    }
    _setLogLevelPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_set_log_level');
    _pinmodeTestPointer =
        _lib.lookup<ffi.NativeFunction<returnInt2IntParametersFunc>>(
            'mraa_pin_mode_test');
    _adcRawBitsPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_adc_raw_bits');
    _platformAdcRawBitsPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_get_platform_adc_raw_bits');
    _adcSupportedBitsPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_adc_supported_bits');
    _platformAdcSupportedBitsPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_get_platform_adc_supported_bits');
    _setPriorityPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_set_priority');
    _resultPrintPointer =
        _lib.lookup<ffi.NativeFunction<returnVoidIntParametersFunc>>(
            'mraa_result_print');
    _platformCombinedTypePointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_platform_combined_type');
    _pinCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_pin_count');
    _uartCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_uart_count');
    _spiBusCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_spi_bus_count');
    _pwmCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_pwm_count');
    _gpioCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_gpio_count');
    _aioCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_aio_count');
    _i2cBusCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_get_i2c_bus_count');
    _i2cBusIdPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_get_i2c_bus_id');
    _platformPinCountPointer =
        _lib.lookup<ffi.NativeFunction<returnIntUint8ParametersFunc>>(
            'mraa_get_platform_pin_count');
    _pinNamePointer =
        _lib.lookup<ffi.NativeFunction<returnStringIntParametersFunc>>(
            'mraa_get_pin_name');
    _gpioLookupPointer =
        _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
            'mraa_gpio_lookup');
    _i2cLookupPointer =
        _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
            'mraa_i2c_lookup');
    _spiLookupPointer =
        _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
            'mraa_spi_lookup');
    _pwmLookupPointer =
        _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
            'mraa_pwm_lookup');
    _uartLookupPointer =
        _lib.lookup<ffi.NativeFunction<returnIntStringParametersFunc>>(
            'mraa_uart_lookup');
    _defaultI2cBusPointer =
        _lib.lookup<ffi.NativeFunction<returnIntUint8ParametersFunc>>(
            'mraa_get_default_i2c_bus');
    _hasSubPlatformPointer =
        _lib.lookup<ffi.NativeFunction<returnIntNoParametersFunc>>(
            'mraa_has_sub_platform');
    _isSubPlatformIdPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_is_sub_platform_id');
    _subPlatformIdPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_get_sub_platform_id');
    _subPlatformIndexPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntParametersFunc>>(
            'mraa_get_sub_platform_index');
    _addSubplatformPointer =
        _lib.lookup<ffi.NativeFunction<returnIntIntStringParametersFunc>>(
            'mraa_add_subplatform');
  }

  void _setUpFunctions() {
    _versionFunc = _versionPointer.asFunction<MraaCommonVersionType>();
    _initFunc = _initialisePointer.asFunction<MraaCommonInitialiseType>();
    _platformNameFunc =
        _platformNamePointer.asFunction<MraaCommonPlatformNameType>();
    _platformVersionFunc =
        _platformVersionPointer.asFunction<MraaCommonPlatformVersionType>();
    _platformTypeFunc =
        _platformTypePointer.asFunction<MraaCommonPlatformTypeType>();
    if (!_noJsonLoading) {
      _initJsonPlatformFunc =
          _initJsonPlatformPointer.asFunction<MraaCommonInitJsonPlatformType>();
    }
    _setLogLevelFunc =
        _setLogLevelPointer.asFunction<MraaCommonSetLogLevelType>();
    _pinModeTestFunc =
        _pinmodeTestPointer.asFunction<MraaCommonPinmodeTestType>();
    _adcRawBitsFunc = _adcRawBitsPointer.asFunction<MraaCommonADCRawBitsType>();
    _platformAdcRawBitsFunc = _platformAdcRawBitsPointer
        .asFunction<MraaCommonPlatformAdcRawBitsType>();
    _adcSupportedBitsFunc =
        _adcSupportedBitsPointer.asFunction<MraaCommonAdcSupportedBitsType>();
    _platformAdcSupportedBitsFunc = _platformAdcSupportedBitsPointer
        .asFunction<MraaCommonPlatformAdcSupportedBitsType>();
    _setPriorityFunc =
        _setPriorityPointer.asFunction<MraaCommonSetPriorityType>();
    _resultPrintFunc =
        _resultPrintPointer.asFunction<MraaCommonResultPrintType>();
    _platformCombinedTypeFunc = _platformCombinedTypePointer
        .asFunction<MraaCommonPlatformCombinedTypeType>();
    _pinCountTypeFunc = _pinCountPointer.asFunction<MraaCommonPinCountType>();
    _uartCountTypeFunc =
        _uartCountPointer.asFunction<MraaCommonUartCountType>();
    _spiBusCountTypeFunc =
        _spiBusCountPointer.asFunction<MraaCommonSpiBusCountType>();
    _pwmCountTypeFunc = _pwmCountPointer.asFunction<MraaCommonPwmCountType>();
    _gpioCountTypeFunc =
        _gpioCountPointer.asFunction<MraaCommonGpioCountType>();
    _aioCountTypeFunc = _aioCountPointer.asFunction<MraaCommonAioCountType>();
    _i2cBusCountTypeFunc =
        _i2cBusCountPointer.asFunction<MraaCommonI2cBusCountType>();
    _i2cBusIdFunc = _i2cBusIdPointer.asFunction<MraaCommonI2cBusIdType>();
    _platformPinCountFunc =
        _platformPinCountPointer.asFunction<MraaCommonPlatformPinCountType>();
    _pinNameFunc = _pinNamePointer.asFunction<MraaCommonPinNameType>();
    _gpioLookupFunc = _gpioLookupPointer.asFunction<MraaCommonGpioLookupType>();
    _i2cLookupFunc = _i2cLookupPointer.asFunction<MraaCommonI2cLookupType>();
    _spiLookupFunc = _spiLookupPointer.asFunction<MraaCommonSpiLookupType>();
    _pwmLookupFunc = _pwmLookupPointer.asFunction<MraaCommonPwmLookupType>();
    _uartLookupFunc = _uartLookupPointer.asFunction<MraaCommonUartLookupType>();
    _defaultI2cBusFunc =
        _defaultI2cBusPointer.asFunction<MraaCommonDefaultI2cBusType>();
    _hasSubPlatformFunc =
        _hasSubPlatformPointer.asFunction<MraaCommonHasSubPlatformType>();
    _isSubPlatformIdFunc =
        _isSubPlatformIdPointer.asFunction<MraaCommonIsSubPlatformIdType>();
    _subPlatformIdFunc =
        _subPlatformIdPointer.asFunction<MraaCommonSubPlatformIdType>();
    _subPlatformIndexFunc =
        _subPlatformIndexPointer.asFunction<MraaCommonSubPlatformIndexType>();
    _addSubplatformFunc =
        _addSubplatformPointer.asFunction<MraaCommonAddSubplatformType>();
  }
}
