/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// C Function signature typedefs
typedef _returnMraaGpioContextIntParameterFunc = Pointer<MraaGpioContext>
    Function(Int32);
typedef _returnIntGpioContextIntParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>, Int32);
typedef _returnIntGpioContextParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>);
typedef _returnMraaGpioContextIntArrayIntParameterFunc
    = Pointer<MraaGpioContext> Function(Pointer<Int32>, Int32);
typedef _returnMraaGpioEventArrayMraaGpioContextParameter
    = Pointer<MraaGpioEvent> Function(Pointer<MraaGpioContext>);
typedef _returnIntGpioContextPtrIntParametersFunc = Int32 Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);

/// Dart Function typedefs
typedef _MraaGpioInitialiseType = Pointer<MraaGpioContext> Function(int);
typedef _MraaGpioDirectionType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioReadType = int Function(Pointer<MraaGpioContext>);
typedef _MraaGpioInitialiseMultiType = Pointer<MraaGpioContext> Function(
    Pointer<Int32>, int);
typedef _MraaGpioInitialiseRawType = Pointer<MraaGpioContext> Function(int);
typedef _MraaGpioEdgeModeType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioEventsType = Pointer<MraaGpioEvent> Function(
    Pointer<MraaGpioContext>);
typedef _MraaGpioModeType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioReadDirectionType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef _MraaGpioCloseType = int Function(Pointer<MraaGpioContext>);
typedef _MraaGpioReadMultiType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef _MraaGpioWriteType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioWriteMultiType = int Function(
    Pointer<MraaGpioContext>, Pointer<Int32>);
typedef _MraaGpioOwnerType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioPinType = int Function(Pointer<MraaGpioContext>);
typedef _MraaGpioPinRawType = int Function(Pointer<MraaGpioContext>);
typedef _MraaGpioInputModeType = int Function(Pointer<MraaGpioContext>, int);
typedef _MraaGpioOutputDriverModeType = int Function(
    Pointer<MraaGpioContext>, int);

/// The GPIO MRAA API
///
/// GPIO is the General Purpose IO interface to MRAA. Its features
/// depend on the board type used, it can use gpiolibs (exported via a
/// kernel module through sysfs), or memory mapped IO via
/// a /dev/uio device or /dev/mem depending again depending on the board configuration.
class MraaGpio {
  /// Construction
  MraaGpio(this._lib, this._noJsonLoading, this._useGrovePi) {
    _setUpPointers();
    _setUpFunctions();
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  /// The MRAA library
  final DynamicLibrary _lib;

  // ignore: unused_field
  final _noJsonLoading;

  final _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  int _initialiseMultiPinCount = 0;

  /// C Pointers
  late Pointer<NativeFunction<_returnMraaGpioContextIntParameterFunc>>
      _initialisePointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _directionPointer;
  late Pointer<NativeFunction<_returnIntGpioContextParametersFunc>>
      _readPointer;
  late Pointer<NativeFunction<_returnMraaGpioContextIntArrayIntParameterFunc>>
      _initialiseMultiPointer;
  late Pointer<NativeFunction<_returnMraaGpioContextIntParameterFunc>>
      _initialiseRawPointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _edgeModePointer;
  late Pointer<
          NativeFunction<_returnMraaGpioEventArrayMraaGpioContextParameter>>
      _eventsPointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _modePointer;
  late Pointer<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>
      _readDirectionPointer;
  late Pointer<NativeFunction<_returnIntGpioContextParametersFunc>>
      _closePointer;
  late Pointer<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>
      _readMultiPointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _writePointer;
  late Pointer<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>
      _writeMultiPointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _ownerPointer;
  late Pointer<NativeFunction<_returnIntGpioContextParametersFunc>> _pinPointer;
  late Pointer<NativeFunction<_returnIntGpioContextParametersFunc>>
      _pinRawPointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _inputModePointer;
  late Pointer<NativeFunction<_returnIntGpioContextIntParametersFunc>>
      _outputDriverModePointer;

  /// Dart Functions
  late _MraaGpioInitialiseType _initialiseFunc;
  late _MraaGpioDirectionType _directionFunc;
  late _MraaGpioReadType _readFunc;
  late _MraaGpioInitialiseMultiType _initialiseMultiFunc;
  late _MraaGpioInitialiseRawType _initialiseRawFunc;
  late _MraaGpioEdgeModeType _edgeModeFunc;
  late _MraaGpioEventsType _eventsFunc;
  late _MraaGpioModeType _modeFunc;
  late _MraaGpioReadDirectionType _readDirectionFunc;
  late _MraaGpioCloseType _closeFunc;
  late _MraaGpioReadMultiType _readMultiFunc;
  late _MraaGpioWriteType _writeFunc;
  late _MraaGpioWriteMultiType _writeMultiFunc;
  late _MraaGpioOwnerType _ownerFunc;
  late _MraaGpioPinType _pinFunc;
  late _MraaGpioPinRawType _pinRawFunc;
  late _MraaGpioInputModeType _inputModeFunc;
  late _MraaGpioOutputDriverModeType _outputDriverModeFunc;

  /// Initialise - mraa_gpio_init
  ///
  /// Initialise a [MraaGpioContext] based on pin number
  Pointer<MraaGpioContext> initialise(int pin) =>
      _initialiseFunc(pin + _grovePiPinOffset);

  /// GPIO direction - mraa_gpio_dir
  ///
  /// Set the GPIO direction
  MraaReturnCode direction(
          Pointer<MraaGpioContext> context, MraaGpioDirection direction) =>
      returnCode
          .fromInt(_directionFunc(context, gpioDirections.asInt(direction)));

  /// Read - mraa_gpio_read
  ///
  /// Read the GPIO value. This can be 0 or 1.
  /// A response of [Mraa.generalError] means that there was a fatal error.
  int read(Pointer<MraaGpioContext> context) => _readFunc(context);

  /// Initialise multi - mraa_gpio_init_multi
  ///
  /// Initialise a [MraaGpioContext] for multiple pins (can be one).
  Pointer<MraaGpioContext> initialiseMulti(List<int> pins, int numPins) {
    pins.forEach((int pin) {
      pin += _grovePiPinOffset;
    });
    final mpins = ffi.allocate<Int32>(count: numPins);
    final values = Int32List.fromList(pins);
    final dataItems = mpins.asTypedList(values.length);
    dataItems.setAll(0, values);
    _initialiseMultiPinCount = numPins;
    return _initialiseMultiFunc(mpins, numPins);
  }

  /// Initialise raw - mraa_gpio_init_raw
  ///
  /// Initialise a [MraaGpioContext] without any mapping to a pin.
  /// The [gpioPin] supplied is as listed in SYSFS.
  Pointer<MraaGpioContext> initialiseRaw(int gpioPin) =>
      _initialiseRawFunc(gpioPin + _grovePiPinOffset);

  /// Edge mode - mraa_gpio_edge_mode
  ///
  /// Set the edge mode on the GPIO
  MraaReturnCode edgeMode(Pointer<MraaGpioContext> dev, MraaGpioEdge mode) =>
      returnCode.fromInt(_edgeModeFunc(dev, gpioEdge.asInt(mode)));

  /// Events - mraa_gpio_get_events
  ///
  /// Get an array of [MraaGpioEvent] structures describing triggered events.
  /// Returns a list of events containing pairs of pin id's and
  /// the associated timestamp.
  /// An event with negative id value indicates that no event was
  /// triggered for the respective pin.
  /// The list length is that of the number of pins provided in
  /// [initialiseMulti].
  /// Note if this method has not been called we can't get the event list
  /// so null is returned.
  List<MraaGpioEvent> events(Pointer<MraaGpioContext> dev) {
    if (_initialiseMultiPinCount == 0) {
      return null;
    }
    final mevents = _eventsFunc(dev);
    final events = <MraaGpioEvent>[];
    if (mevents == nullptr) {
      return events;
    }
    for (var i = 0; i < _initialiseMultiPinCount; i++) {
      events.add(mevents[i]);
    }
    return events;
  }

  /// Mode - mraa_gpio_mode
  ///
  /// Set the GPIO's output Mode.
  MraaReturnCode mode(Pointer<MraaGpioContext> dev, MraaGpioOutputMode mode) =>
      returnCode.fromInt(_modeFunc(dev, gpioOutputModes.asInt(mode)));

  /// Read direction - mraa_gpio_read_dir
  ///
  /// Read the GPIO's direction.
  MraaReturnCode readDirection(
      Pointer<MraaGpioContext> dev, MraaGpioDirectionRead gpioDirection) {
    final dir = ffi.allocate<Int32>(count: 1);
    final ret = returnCode.fromInt(_readDirectionFunc(dev, dir));
    gpioDirection.direction = gpioDirections.fromInt(dir.value);
    return ret;
  }

  /// Close - mraa_gpio_close
  ///
  /// Close the [MraaGpioContext]
  /// Free's the memory for the context and unexports the
  /// Gpio - sysfs interface.
  /// Free's up the memory used by context and closes any related
  /// file descriptors - chardev interface.
  MraaReturnCode close(Pointer<MraaGpioContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Read multi - mraa_gpio_read_multi
  ///
  /// Read the GPIO(s) value. Reads the number of pins provided to
  /// the initialiseMulti() functionwhich must have been called before using
  /// this method.
  MraaReturnCode readMulti(
      Pointer<MraaGpioContext> dev, MraaGpioMultiRead values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    final rawValues = ffi.allocate<Int32>(count: _initialiseMultiPinCount);
    var intRet = _readMultiFunc(dev, rawValues);
    if (intRet == Mraa.generalError) {
      intRet = 99; // unspecified
    }
    final typedValues = rawValues.asTypedList(_initialiseMultiPinCount);
    values.values = List<int>.from(typedValues);
    ffi.free(rawValues);
    return returnCode.fromInt(intRet);
  }

  /// Write - mraa_gpio_write
  ///
  /// Write to the GPIO.
  MraaReturnCode write(Pointer<MraaGpioContext> dev, int value) =>
      returnCode.fromInt(_writeFunc(dev, value));

  /// Write multi - mraa_gpio_write_multi
  ///
  /// Write multiple values to the GPIO. The user must provide an
  /// integer array with a length equal to the number of pins provided
  /// to [initialiseMulti()] method and in the same order.
  MraaReturnCode writeMulti(Pointer<MraaGpioContext> dev, List<int> values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    if (values.length != _initialiseMultiPinCount) {
      return MraaReturnCode.errorUnspecified;
    }
    final rawValues = ffi.allocate<Int32>(count: values.length);
    final typedValues = rawValues.asTypedList(_initialiseMultiPinCount);
    typedValues.setAll(0, values);
    return returnCode.fromInt(_writeMultiFunc(dev, rawValues));
  }

  /// Owner - mraa_gpio_owner
  ///
  /// Change ownership of a [MraaGpioContext], setting [own] true indicates
  /// you wish to become the owner.
  MraaReturnCode owner(Pointer<MraaGpioContext> dev, bool own) {
    final rawOwn = own ? 1 : 0;
    return returnCode.fromInt(_ownerFunc(dev, rawOwn));
  }

  /// Pin - mraa_gpio_get_pin
  ///
  /// Get a pin number of the GPIO, returns [Mraa.generalError] on failure.
  int pin(Pointer<MraaGpioContext> dev) => _pinFunc(dev) - _grovePiPinOffset;

  /// Pin raw - mraa_gpio_get_pin_raw
  ///
  /// Get a GPIO number as used within sysfs,
  /// returns [Mraa.generalError] on failure.
  int pinRaw(Pointer<MraaGpioContext> dev) =>
      _pinRawFunc(dev) - _grovePiPinOffset;

  /// Input mode - mraa_gpio_input_mode
  ///
  /// Set the GPIO input mode
  MraaReturnCode inputMode(
          Pointer<MraaGpioContext> dev, MraaGpioInputMode mode) =>
      returnCode.fromInt(_inputModeFunc(dev, gpioInputModes.asInt(mode)));

  /// Output driver mode - mraa_gpio_out_driver_mode
  ///
  /// Set the GPIO output driver mode.
  /// This is not a standard feature, it needs a custom implementation
  /// for each board.
  MraaReturnCode outputDriverMode(
          Pointer<MraaGpioContext> dev, MraaGpioOutputDriverMode mode) =>
      returnCode.fromInt(
          _outputDriverModeFunc(dev, gpioOutputDriverModes.asInt(mode)));

  void _setUpPointers() {
    _initialisePointer =
        _lib.lookup<NativeFunction<_returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init');
    _directionPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_dir');
    _readPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextParametersFunc>>(
            'mraa_gpio_read');
    _initialiseMultiPointer = _lib
        .lookup<NativeFunction<_returnMraaGpioContextIntArrayIntParameterFunc>>(
            'mraa_gpio_init_multi');
    _initialiseRawPointer =
        _lib.lookup<NativeFunction<_returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init_raw');
    _edgeModePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_edge_mode');
    _eventsPointer = _lib.lookup<
            NativeFunction<_returnMraaGpioEventArrayMraaGpioContextParameter>>(
        'mraa_gpio_get_events');
    _modePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_mode');
    _readDirectionPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_dir');
    _closePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextParametersFunc>>(
            'mraa_gpio_close');
    _readMultiPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_multi');
    _writePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_write');
    _writeMultiPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_write_multi');
    _ownerPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_owner');
    _pinPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextParametersFunc>>(
            'mraa_gpio_get_pin');
    _pinRawPointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextParametersFunc>>(
            'mraa_gpio_get_pin_raw');
    _inputModePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_input_mode');
    _outputDriverModePointer =
        _lib.lookup<NativeFunction<_returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_out_driver_mode');
  }

  void _setUpFunctions() {
    _initialiseFunc = _initialisePointer.asFunction<_MraaGpioInitialiseType>();
    _directionFunc = _directionPointer.asFunction<_MraaGpioDirectionType>();
    _readFunc = _readPointer.asFunction<_MraaGpioReadType>();
    _initialiseMultiFunc =
        _initialiseMultiPointer.asFunction<_MraaGpioInitialiseMultiType>();
    _initialiseRawFunc =
        _initialiseRawPointer.asFunction<_MraaGpioInitialiseRawType>();
    _edgeModeFunc = _edgeModePointer.asFunction<_MraaGpioEdgeModeType>();
    _eventsFunc = _eventsPointer.asFunction<_MraaGpioEventsType>();
    _modeFunc = _modePointer.asFunction<_MraaGpioModeType>();
    _readDirectionFunc =
        _readDirectionPointer.asFunction<_MraaGpioReadDirectionType>();
    _closeFunc = _closePointer.asFunction<_MraaGpioCloseType>();
    _readMultiFunc = _readMultiPointer.asFunction<_MraaGpioReadMultiType>();
    _writeFunc = _writePointer.asFunction<_MraaGpioWriteType>();
    _writeMultiFunc = _writeMultiPointer.asFunction<_MraaGpioWriteMultiType>();
    _ownerFunc = _ownerPointer.asFunction<_MraaGpioOwnerType>();
    _pinFunc = _pinPointer.asFunction<_MraaGpioPinType>();
    _pinRawFunc = _pinRawPointer.asFunction<_MraaGpioPinRawType>();
    _inputModeFunc = _inputModePointer.asFunction<_MraaGpioInputModeType>();
    _outputDriverModeFunc =
        _outputDriverModePointer.asFunction<_MraaGpioOutputDriverModeType>();
  }
}
