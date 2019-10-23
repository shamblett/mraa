/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

// ignore_for_file: avoid_positional_boolean_parameters

part of mraa;

/// C Function type typedefs
typedef returnMraaGpioContextIntParameterFunc = ffi.Pointer<MraaGpioContext>
    Function(ffi.Int32);
typedef returnIntGpioContextIntParametersFunc = ffi.Int32 Function(
    ffi.Pointer<MraaGpioContext>, ffi.Int32);
typedef returnIntGpioContextParametersFunc = ffi.Int32 Function(
    ffi.Pointer<MraaGpioContext>);
typedef returnMraaGpioContextIntArrayIntParameterFunc
    = ffi.Pointer<MraaGpioContext> Function(ffi.Pointer<ffi.Int32>, ffi.Int32);
typedef returnMraaGpioEventArrayMraaGpioContextParameter
    = ffi.Pointer<MraaGpioEvent> Function(ffi.Pointer<MraaGpioContext>);
typedef returnIntGpioContextPtrIntParametersFunc = ffi.Int32 Function(
    ffi.Pointer<MraaGpioContext>, ffi.Pointer<ffi.Int32>);
typedef returnMraaGpioContextIntArrayParameterFunc
    = ffi.Pointer<MraaGpioContext> Function(ffi.Pointer<ffi.Int32>);

/// Dart Function typedefs
typedef MraaGpioInitialiseType = ffi.Pointer<MraaGpioContext> Function(int);
typedef MraaGpioDirectionType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioReadType = int Function(ffi.Pointer<MraaGpioContext>);
typedef MraaGpioInitialiseMultiType = ffi.Pointer<MraaGpioContext> Function(
    ffi.Pointer<ffi.Int32>, int);
typedef MraaGpioInitialiseRawType = ffi.Pointer<MraaGpioContext> Function(int);
typedef MraaGpioEdgeModeType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioEventsType = ffi.Pointer<MraaGpioEvent> Function(
    ffi.Pointer<MraaGpioContext>);
typedef MraaGpioModeType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioReadDirectionType = int Function(
    ffi.Pointer<MraaGpioContext>, ffi.Pointer<ffi.Int32>);
typedef MraaGpioCloseType = int Function(ffi.Pointer<MraaGpioContext>);
typedef MraaGpioReadMultiType = int Function(
    ffi.Pointer<MraaGpioContext>, ffi.Pointer<ffi.Int32>);
typedef MraaGpioWriteType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioWriteMultiType = int Function(
    ffi.Pointer<MraaGpioContext>, ffi.Pointer<ffi.Int32>);
typedef MraaGpioOwnerType = int Function(ffi.Pointer<MraaGpioContext>, int);
typedef MraaGpioPinType = int Function(ffi.Pointer<MraaGpioContext>);

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
  ffi.DynamicLibrary _lib;

  bool _noJsonLoading = false;

  int _initialiseMultiPinCount = 0;

  /// C Pointers
  ffi.Pointer<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>
      _initialisePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _directionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextParametersFunc>>
      _readPointer;
  ffi.Pointer<ffi.NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>
      _initialiseMultiPointer;
  ffi.Pointer<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>
      _initialiseRawPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _edgeModePointer;
  ffi.Pointer<
          ffi.NativeFunction<returnMraaGpioEventArrayMraaGpioContextParameter>>
      _eventsPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _modePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _readDirectionPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextParametersFunc>>
      _closePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _readMultiPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _writePointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>
      _writeMultiPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>
      _ownerPointer;
  ffi.Pointer<ffi.NativeFunction<returnIntGpioContextParametersFunc>>
      _pinPointer;

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

  /// Initialise - mraa_gpio_init
  /// Initialise gpio_context, based on board number
  ffi.Pointer<MraaGpioContext> initialise(int pin) => _initialiseFunc(pin);

  /// GPIO direction - mraa_gpio_dir
  /// Set Gpio(s) direction
  MraaReturnCode direction(
          ffi.Pointer<MraaGpioContext> context, MraaGpioDirection direction) =>
      returnCode
          .fromInt(_directionFunc(context, gpioDirections.asInt(direction)));

  /// Read - mraa_gpio_read
  /// Read the Gpio value. This can be 0 or 1.
  /// A response of -1 means that there was a fatal error.
  int read(ffi.Pointer<MraaGpioContext> context) => _readFunc(context);

  /// Initialise multi - mraa_gpio_init_multi
  /// Initialise gpio_context, based on board number, for multiple pins (can be one).
  ffi.Pointer<MraaGpioContext> initialiseMulti(List<int> pins, int numPins) {
    final ffi.Pointer<ffi.Int32> mpins =
        ffi.Pointer<ffi.Int32>.allocate(count: numPins);
    final Int32List values = Int32List.fromList(pins);
    final Int32List dataItems = mpins.asExternalTypedData(count: values.length);
    final int length = values.length;
    for (int i = 0; i < length; i++) {
      dataItems[i] = values[i];
    }
    _initialiseMultiPinCount = numPins;
    return _initialiseMultiFunc(mpins, numPins);
  }

  /// Initialise raw - mraa_gpio_init_raw
  /// Initialise gpio context without any mapping to a pin
  /// Pin supplied is as listed in SYSFS
  ffi.Pointer<MraaGpioContext> initialiseRaw(int gpioPin) =>
      _initialiseRawFunc(gpioPin);

  /// Edge mode - mraa_gpio_edge_mode
  /// Set the edge mode on the gpio
  MraaReturnCode edgeMode(
          ffi.Pointer<MraaGpioContext> dev, MraaGpioEdge mode) =>
      returnCode.fromInt(_edgeModeFunc(dev, gpioEdge.asInt(mode)));

  /// Events - mraa_gpio_get_events
  /// Get an array of structures describing triggered events.
  /// Returns a list of events containing pairs of pin id's and the associated timestamp.
  /// An event with negative id value indicates that no event was triggered for the respective pin.
  /// The list length is that of the number of pins provided in initialiseMulti(). Note if this
  /// has not been called we cant get the event list so we return null.
  List<MraaGpioEvent> events(ffi.Pointer<MraaGpioContext> dev) {
    if (_initialiseMultiPinCount == 0) {
      return null;
    }
    final ffi.Pointer<MraaGpioEvent> mevents = _eventsFunc(dev);
    final List<MraaGpioEvent> events = <MraaGpioEvent>[];
    if (mevents.address == 0) {
      return events;
    }
    for (int i = 0; i < _initialiseMultiPinCount; i++) {
      events.add(mevents.elementAt(i).load());
    }
    return events;
  }

  /// Mode - mraa_gpio_mode
  /// Set Gpio(s) Output Mode,
  MraaReturnCode mode(
          ffi.Pointer<MraaGpioContext> dev, MraaGpioOutputMode mode) =>
      returnCode.fromInt(_modeFunc(dev, gpioOutputModes.asInt(mode)));

  /// Read direction - mraa_gpio_read_dir
  /// Read Gpio(s) direction
  MraaReturnCode readDirection(
      ffi.Pointer<MraaGpioContext> dev, MraaGpioDirectionRead gpioDirection) {
    final ffi.Pointer<ffi.Int32> dir =
        ffi.Pointer<ffi.Int32>.allocate(count: 1);
    final MraaReturnCode ret = returnCode.fromInt(_readDirectionFunc(dev, dir));
    gpioDirection.direction = gpioDirections.fromInt(dir.load());
    return ret;
  }

  /// Close - mraa_gpio_close
  /// Close the Gpio context
  /// Free's the memory for the context and unexport the Gpio - sysfs interface.
  /// Free's up the memory used by context and close related file descriptors -
  /// chardev interface.
  MraaReturnCode close(ffi.Pointer<MraaGpioContext> dev) =>
      returnCode.fromInt(_closeFunc(dev));

  /// Read multi - mraa_gpio_read_multi
  /// Read the Gpio(s) value. Reads the number of pins provided to
  /// the initialiseMulti() function.
  MraaReturnCode readMulti(
      ffi.Pointer<MraaGpioContext> dev, MraaGpioMultiRead values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    final ffi.Pointer<ffi.Int32> rawValues =
        ffi.Pointer<ffi.Int32>.allocate(count: _initialiseMultiPinCount);
    int intRet = _readMultiFunc(dev, rawValues);
    if (intRet == Mraa.mraaGeneralError) {
      intRet = 99; // unspecified
    }
    final Int32List typedValues =
        rawValues.asExternalTypedData(count: _initialiseMultiPinCount);
    values.values = List<int>.from(typedValues);
    return returnCode.fromInt(intRet);
  }

  /// Write - mraa_gpio_write
  /// Write to the Gpio Value.
  MraaReturnCode write(ffi.Pointer<MraaGpioContext> dev, int value) =>
      returnCode.fromInt(_writeFunc(dev, value));

  /// Write multi - mraa_gpio_write_multi
  /// Write to the Gpio(s) Value. The user must provide an integer array with a length
  /// equal to the number of pins provided to initialiseMulti() function and in
  /// the same order.
  MraaReturnCode writeMulti(
      ffi.Pointer<MraaGpioContext> dev, List<int> values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    if (values.length != _initialiseMultiPinCount) {
      return MraaReturnCode.errorUnspecified;
    }
    final ffi.Pointer<ffi.Int32> rawValues =
        ffi.Pointer<ffi.Int32>.allocate(count: _initialiseMultiPinCount);
    final Int32List typedValues =
        rawValues.asExternalTypedData(count: _initialiseMultiPinCount);
    for (int i = 0; i < _initialiseMultiPinCount; i++) {
      typedValues[i] = values[i];
    }
    return returnCode.fromInt(_writeMultiFunc(dev, rawValues));
  }

  /// Owner - mraa_gpio_owner
  /// Change ownership of the context, true indicates become the owner
  MraaReturnCode owner(ffi.Pointer<MraaGpioContext> dev, bool own) {
    final int rawOwn = own ? 1 : 0;
    return returnCode.fromInt(_ownerFunc(dev, rawOwn));
  }

  /// Pin - mraa_gpio_get_pin
  /// Get a pin number of the gpio, invalid will return mraaGeneralError
  int pin(ffi.Pointer<MraaGpioContext> dev) => _pinFunc(dev);

  void _setUpPointers() {
    _initialisePointer =
        _lib.lookup<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init');
    _directionPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_dir');
    _readPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_read');
    _initialiseMultiPointer = _lib.lookup<
            ffi.NativeFunction<returnMraaGpioContextIntArrayIntParameterFunc>>(
        'mraa_gpio_init_multi');
    _initialiseRawPointer =
        _lib.lookup<ffi.NativeFunction<returnMraaGpioContextIntParameterFunc>>(
            'mraa_gpio_init_raw');
    _edgeModePointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_edge_mode');
    _eventsPointer = _lib.lookup<
            ffi.NativeFunction<
                returnMraaGpioEventArrayMraaGpioContextParameter>>(
        'mraa_gpio_get_events');
    _modePointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_mode');
    _readDirectionPointer = _lib
        .lookup<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_dir');
    _closePointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_close');
    _readMultiPointer = _lib
        .lookup<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_read_multi');
    _writePointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_write');
    _writeMultiPointer = _lib
        .lookup<ffi.NativeFunction<returnIntGpioContextPtrIntParametersFunc>>(
            'mraa_gpio_write_multi');
    _ownerPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextIntParametersFunc>>(
            'mraa_gpio_owner');
    _pinPointer =
        _lib.lookup<ffi.NativeFunction<returnIntGpioContextParametersFunc>>(
            'mraa_gpio_get_pin');
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
  }
}
