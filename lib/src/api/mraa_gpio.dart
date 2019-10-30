/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaGpioContextIntParameterFunc = Pointer<MraaGpioContext>
    Function(Int32);
typedef returnIntGpioContextIntParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>, Int32);
typedef returnIntGpioContextParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>);
typedef returnMraaGpioContextIntArrayIntParameterFunc = Pointer<MraaGpioContext>
    Function(Pointer<Int32>, Int32);
typedef returnMraaGpioEventArrayMraaGpioContextParameter
    = Pointer<MraaGpioEvent> Function(Pointer<MraaGpioContext>);
typedef returnIntGpioContextPtrIntParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef returnMraaGpioContextIntArrayParameterFunc = Pointer<MraaGpioContext>
    Function(Pointer<Int32>);

/// Dart Function typedefs
typedef MraaGpioInitialiseType = Pointer<MraaGpioContext> Function(int);
typedef MraaGpioDirectionType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioReadType = int Function(Pointer<MraaGpioContext>);
typedef MraaGpioInitialiseMultiType = Pointer<MraaGpioContext> Function(
    Pointer<Int32>, int);
typedef MraaGpioInitialiseRawType = Pointer<MraaGpioContext> Function(int);
typedef MraaGpioEdgeModeType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioEventsType = Pointer<MraaGpioEvent> Function(
    Pointer<MraaGpioContext>);
typedef MraaGpioModeType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioReadDirectionType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef MraaGpioCloseType = int Function(Pointer<MraaGpioContext>);
typedef MraaGpioReadMultiType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef MraaGpioWriteType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioWriteMultiType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef MraaGpioOwnerType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioPinType = int Function(Pointer<MraaGpioContext>);
typedef MraaGpioPinRawType = int Function(Pointer<MraaGpioContext>);
typedef MraaGpioInputModeType = int Function(Pointer<MraaGpioContext>, int);
typedef MraaGpioOutputDriverModeType = int Function(
    Pointer<MraaGpioContext>, int);

/// The GPIO MRAA API
/// Gpio is the General Purpose IO interface to libmraa. Its features depend on the board type used,
/// it can use gpiolibs (exported via a kernel module through sysfs), or memory mapped IO via
/// a /dev/uio device or /dev/mem depending again on the board configuration.
class _MraaGpio {
  _MraaGpio(this._lib, this._noJsonLoading) {
    _setUpPointers();
    _setUpFunctions();
  }

  /// The MRAA library
  DynamicLibrary _lib;

  bool _noJsonLoading = false;

  int _initialiseMultiPinCount = 0;

  /// C Pointers
  Pointer<NativeFunction<returnMraaGpioContextIntParameterFunc>>
      _initialisePointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>>
      _directionPointer;
  Pointer<NativeFunction<returnIntGpioContextParametersFunc>> _readPointer;
  Pointer<NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>
      _initialiseMultiPointer;
  Pointer<NativeFunction<returnMraaGpioContextIntParameterFunc>>
      _initialiseRawPointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>>
      _edgeModePointer;
  Pointer<NativeFunction<returnMraaGpioEventArrayMraaGpioContextParameter>>
      _eventsPointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>> _modePointer;
  Pointer<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _readDirectionPointer;
  Pointer<NativeFunction<returnIntGpioContextParametersFunc>> _closePointer;
  Pointer<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _readMultiPointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>> _writePointer;
  Pointer<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _writeMultiPointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>> _ownerPointer;
  Pointer<NativeFunction<returnIntGpioContextParametersFunc>> _pinPointer;
  Pointer<NativeFunction<returnIntGpioContextParametersFunc>> _pinRawPointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>>
      _inputModePointer;
  Pointer<NativeFunction<returnIntGpioContextIntParametersFunc>>
      _outputDriverModePointer;

  /// Dart Functions
  dynamic _initialiseFunc;
  dynamic _directionFunc;
  dynamic _readFunc;
  dynamic _initialiseMultiFunc;
  dynamic _initialiseRawFunc;
  dynamic _edgeModeFunc;
  dynamic _eventsFunc;
  dynamic _modeFunc;
  dynamic _readDirectionFunc;
  dynamic _closeFunc;
  dynamic _readMultiFunc;
  dynamic _writeFunc;
  dynamic _writeMultiFunc;
  dynamic _ownerFunc;
  dynamic _pinFunc;
  dynamic _pinRawFunc;
  dynamic _inputModeFunc;
  dynamic _outputDriverModeFunc;

  /// Initialise - mraa_gpio_init
  /// Initialise gpio_context, based on board number
  Pointer<MraaGpioContext> initialise(int pin) => _initialiseFunc(pin);

  /// GPIO direction - mraa_gpio_dir
  /// Set Gpio(s) direction
  MraaReturnCode direction(
          Pointer<MraaGpioContext> context, MraaGpioDirection direction) =>
      returnCode
          .fromInt(_directionFunc(context, gpioDirections.asInt(direction)));

  /// Read - mraa_gpio_read
  /// Read the Gpio value. This can be 0 or 1.
  /// A response of -1 means that there was a fatal error.
  int read(Pointer<MraaGpioContext> context) => _readFunc(context);

  /// Initialise multi - mraa_gpio_init_multi
  /// Initialise gpio_context, based on board number, for multiple pins (can be one).
  Pointer<MraaGpioContext> initialiseMulti(List<int> pins, int numPins) {
    final Pointer<Int32> mpins = ffi.allocate<Int32>(count: numPins);
    final Int32List values = Int32List.fromList(pins);
    final Int32List dataItems = mpins.asTypedList(values.length);
    dataItems.setAll(0, values);
    _initialiseMultiPinCount = numPins;
    return _initialiseMultiFunc(mpins, numPins);
  }

  /// Initialise raw - mraa_gpio_init_raw
  /// Initialise gpio context without any mapping to a pin
  /// Pin supplied is as listed in SYSFS
  Pointer<MraaGpioContext> initialiseRaw(int gpioPin) =>
      _initialiseRawFunc(gpioPin);

  /// Edge mode - mraa_gpio_edge_mode
  /// Set the edge mode on the gpio
  MraaReturnCode edgeMode(Pointer<MraaGpioContext> dev, MraaGpioEdge mode) =>
      returnCode.fromInt(_edgeModeFunc(dev, gpioEdge.asInt(mode)));

  /// Events - mraa_gpio_get_events
  /// Get an array of structures describing triggered events.
  /// Returns a list of events containing pairs of pin id's and the associated timestamp.
  /// An event with negative id value indicates that no event was triggered for the respective pin.
  /// The list length is that of the number of pins provided in initialiseMulti(). Note if this
  /// has not been called we cant get the event list so we return null.
  List<MraaGpioEvent> events(Pointer<MraaGpioContext> dev) {
    if (_initialiseMultiPinCount == 0) {
      return null;
    }
    final Pointer<MraaGpioEvent> mevents = _eventsFunc(dev);
    final List<MraaGpioEvent> events = <MraaGpioEvent>[];
    if (mevents.address == 0) {
      return events;
    }
    for (int i = 0; i < _initialiseMultiPinCount; i++) {
      events.add(mevents[i]);
    }
    return events;
  }

  /// Mode - mraa_gpio_mode
  /// Set Gpio(s) Output Mode,
  MraaReturnCode mode(Pointer<MraaGpioContext> dev, MraaGpioOutputMode mode) =>
      returnCode.fromInt(_modeFunc(dev, gpioOutputModes.asInt(mode)));

  /// Read direction - mraa_gpio_read_dir
  /// Read Gpio(s) direction
  MraaReturnCode readDirection(
      Pointer<MraaGpioContext> dev, MraaGpioDirectionRead gpioDirection) {
    final Pointer<Int32> dir = ffi.allocate<Int32>(count: 1);
    final MraaReturnCode ret = returnCode.fromInt(_readDirectionFunc(dev, dir));
    gpioDirection.direction = gpioDirections.fromInt(dir.value);
    return ret;
  }

  /// Close - mraa_gpio_close
  /// Close the Gpio context
  /// Free's the memory for the context and unexport the Gpio - sysfs interface.
  /// Free's up the memory used by context and close related file descriptors -
  /// chardev interface.
  MraaReturnCode close(Pointer<MraaGpioContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Read multi - mraa_gpio_read_multi
  /// Read the Gpio(s) value. Reads the number of pins provided to
  /// the initialiseMulti() function.
  MraaReturnCode readMulti(
      Pointer<MraaGpioContext> dev, MraaGpioMultiRead values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    final Pointer<Int32> rawValues =
        ffi.allocate<Int32>(count: _initialiseMultiPinCount);
    int intRet = _readMultiFunc(dev, rawValues);
    if (intRet == Mraa.generalError) {
      intRet = 99; // unspecified
    }
    final Int32List typedValues =
        rawValues.asTypedList(_initialiseMultiPinCount);
    values.values = List<int>.from(typedValues);
    ffi.free(rawValues);
    return returnCode.fromInt(intRet);
  }

  /// Write - mraa_gpio_write
  /// Write to the Gpio Value.
  MraaReturnCode write(Pointer<MraaGpioContext> dev, int value) =>
      returnCode.fromInt(_writeFunc(dev, value));

  /// Write multi - mraa_gpio_write_multi
  /// Write to the Gpio(s) Value. The user must provide an integer array with a length
  /// equal to the number of pins provided to initialiseMulti() function and in
  /// the same order.
  MraaReturnCode writeMulti(Pointer<MraaGpioContext> dev, List<int> values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    if (values.length != _initialiseMultiPinCount) {
      return MraaReturnCode.errorUnspecified;
    }
    final Pointer<Int32> rawValues = ffi.allocate<Int32>(count: values.length);
    final Int32List typedValues =
        rawValues.asTypedList(_initialiseMultiPinCount);
    typedValues.setAll(0, values);
    return returnCode.fromInt(_writeMultiFunc(dev, rawValues));
  }

  /// Owner - mraa_gpio_owner
  /// Change ownership of the context, true indicates become the owner
  MraaReturnCode owner(Pointer<MraaGpioContext> dev, bool own) {
    final int rawOwn = own ? 1 : 0;
    return returnCode.fromInt(_ownerFunc(dev, rawOwn));
  }

  /// Pin - mraa_gpio_get_pin
  /// Get a pin number of the gpio, invalid will return mraaGeneralError
  int pin(Pointer<MraaGpioContext> dev) => _pinFunc(dev);

  /// Pin raw - mraa_gpio_get_pin_raw
  /// Get a gpio number as used within sysfs, invalid will return mraaGeneralError
  int pinRaw(Pointer<MraaGpioContext> dev) => _pinRawFunc(dev);

  /// Input mode - mraa_gpio_input_mode
  /// Set Gpio input mode
  MraaReturnCode inputMode(
          Pointer<MraaGpioContext> dev, MraaGpioInputMode mode) =>
      returnCode.fromInt(_inputModeFunc(dev, gpioInputModes.asInt(mode)));

  /// Output driver mode - mraa_gpio_out_driver_mode
  /// Set Gpio output driver mode
  /// This is not a standard feature, it needs custom implementation for each board.
  MraaReturnCode outputDriverMode(
          Pointer<MraaGpioContext> dev, MraaGpioOutputDriverMode mode) =>
      returnCode.fromInt(
          _outputDriverModeFunc(dev, gpioOutputDriverModes.asInt(mode)));

  void _setUpPointers() {
    _initialisePointer =
        _lib.lookup<NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init');
    _directionPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_dir');
    _readPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_read');
    _initialiseMultiPointer = _lib
        .lookup<NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>(
            'mraa_gpio_init_multi');
    _initialiseRawPointer =
        _lib.lookup<NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init_raw');
    _edgeModePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_edge_mode');
    _eventsPointer = _lib.lookup<
            NativeFunction<returnMraaGpioEventArrayMraaGpioContextParameter>>(
        'mraa_gpio_get_events');
    _modePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_mode');
    _readDirectionPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_dir');
    _closePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_close');
    _readMultiPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_multi');
    _writePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_write');
    _writeMultiPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_write_multi');
    _ownerPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_owner');
    _pinPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_get_pin');
    _pinRawPointer =
        _lib.lookup<NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_get_pin_raw');
    _inputModePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_input_mode');
    _outputDriverModePointer =
        _lib.lookup<NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_out_driver_mode');
  }

  void _setUpFunctions() {
    _initialiseFunc = _initialisePointer.asFunction<MraaGpioInitialiseType>();
    _directionFunc = _directionPointer.asFunction<MraaGpioDirectionType>();
    _readFunc = _readPointer.asFunction<MraaGpioReadType>();
    _initialiseMultiFunc =
        _initialiseMultiPointer.asFunction<MraaGpioInitialiseMultiType>();
    _initialiseRawFunc =
        _initialiseRawPointer.asFunction<MraaGpioInitialiseRawType>();
    _edgeModeFunc = _edgeModePointer.asFunction<MraaGpioEdgeModeType>();
    _eventsFunc = _eventsPointer.asFunction<MraaGpioEventsType>();
    _modeFunc = _modePointer.asFunction<MraaGpioModeType>();
    _readDirectionFunc =
        _readDirectionPointer.asFunction<MraaGpioReadDirectionType>();
    _closeFunc = _closePointer.asFunction<MraaGpioCloseType>();
    _readMultiFunc = _readMultiPointer.asFunction<MraaGpioReadMultiType>();
    _writeFunc = _writePointer.asFunction<MraaGpioWriteType>();
    _writeMultiFunc = _writeMultiPointer.asFunction<MraaGpioWriteMultiType>();
    _ownerFunc = _ownerPointer.asFunction<MraaGpioOwnerType>();
    _pinFunc = _pinPointer.asFunction<MraaGpioPinType>();
    _pinRawFunc = _pinRawPointer.asFunction<MraaGpioPinRawType>();
    _inputModeFunc = _inputModePointer.asFunction<MraaGpioInputModeType>();
    _outputDriverModeFunc =
        _outputDriverModePointer.asFunction<MraaGpioOutputDriverModeType>();
  }
}
