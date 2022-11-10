/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The GPIO MRAA API
///
/// GPIO is the General Purpose IO interface to MRAA. Its features
/// depend on the board type used, it can use gpiolibs (exported via a
/// kernel module through sysfs), or memory mapped IO via
/// a /dev/uio device or /dev/mem depending again depending on the board configuration.
class MraaGpio {
  /// Construction
  MraaGpio(this._impl, this._noJsonLoading, this._useGrovePi) {
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  /// The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  final bool _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  int _initialiseMultiPinCount = 0;

  /// Initialise - mraa_gpio_init
  ///
  /// Initialise a [MraaGpioContext] based on pin number
  MraaGpioContext initialise(int pin) =>
      _impl.mraa_gpio_init(pin + _grovePiPinOffset);

  /// GPIO direction - mraa_gpio_dir
  ///
  /// Set the GPIO direction
  MraaReturnCode direction(
          MraaGpioContext context, MraaGpioDirection direction) =>
      returnCode.fromInt(
          _impl.mraa_gpio_dir(context, gpioDirections.asInt(direction)));

  /// Read - mraa_gpio_read
  ///
  /// Read the GPIO value. This can be 0 or 1.
  /// A response of [Mraa.generalError] means that there was a fatal error.
  int read(MraaGpioContext context) => _impl.mraa_gpio_read(context);

  /// Initialise multi - mraa_gpio_init_multi
  ///
  /// Initialise a [MraaGpioContext] for multiple pins (can be one).
  MraaGpioContext initialiseMulti(List<int> pins, int numPins) {
    for (int i = 0; i < pins.length; i++) {
      pins[i] += _grovePiPinOffset;
    }
    final mPins = ffi.calloc.allocate<Int32>(numPins);
    final values = Int32List.fromList(pins);
    final dataItems = mPins.asTypedList(values.length);
    dataItems.setAll(0, values);
    _initialiseMultiPinCount = numPins;
    return _impl.mraa_gpio_init_multi(mPins.cast<Int>(), numPins);
  }

  /// Initialise raw - mraa_gpio_init_raw
  ///
  /// Initialise a [MraaGpioContext] without any mapping to a pin.
  /// The [gpioPin] supplied is as listed in SYSFS.
  MraaGpioContext initialiseRaw(int gpioPin) =>
      _impl.mraa_gpio_init_raw(gpioPin + _grovePiPinOffset);

  /// Edge mode - mraa_gpio_edge_mode
  ///
  /// Set the edge mode on the GPIO
  MraaReturnCode edgeMode(MraaGpioContext dev, MraaGpioEdge mode) =>
      returnCode.fromInt(_impl.mraa_gpio_edge_mode(dev, gpioEdge.asInt(mode)));

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
  List<MraaGpioEvent> events(MraaGpioContext dev) {
    if (_initialiseMultiPinCount == 0) {
      return <MraaGpioEvent>[];
    }
    final mevents = _impl.mraa_gpio_get_events(dev);
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
  MraaReturnCode mode(MraaGpioContext dev, MraaGpioOutputMode mode) =>
      returnCode
          .fromInt(_impl.mraa_gpio_mode(dev, gpioOutputModes.asInt(mode)));

  /// Read direction - mraa_gpio_read_dir
  ///
  /// Read the GPIO's direction.
  MraaReturnCode readDirection(
      MraaGpioContext dev, MraaGpioDirectionRead gpioDirection) {
    final dir = ffi.calloc.allocate<Int32>(1);
    final ret = returnCode.fromInt(_impl.mraa_gpio_read_dir(dev, dir));
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
  MraaReturnCode close(MraaGpioContext dev) =>
      returnCode.fromInt(_impl.mraa_gpio_close(dev));

  /// Read multi - mraa_gpio_read_multi
  ///
  /// Read the GPIO(s) value. Reads the number of pins provided to
  /// the initialiseMulti() functionwhich must have been called before using
  /// this method.
  MraaReturnCode readMulti(MraaGpioContext dev, MraaGpioMultiRead values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    final rawValues = ffi.calloc.allocate<Int32>(_initialiseMultiPinCount);
    var intRet = _impl.mraa_gpio_read_multi(dev, rawValues.cast<Int>());
    if (intRet == Mraa.generalError) {
      intRet = 99; // unspecified
    }
    final typedValues = rawValues.asTypedList(_initialiseMultiPinCount);
    values.values = List<int>.from(typedValues);
    ffi.calloc.free(rawValues);

    return returnCode.fromInt(intRet);
  }

  /// Write - mraa_gpio_write
  ///
  /// Write to the GPIO.
  MraaReturnCode write(MraaGpioContext dev, int value) =>
      returnCode.fromInt(_impl.mraa_gpio_write(dev, value));

  /// Write multi - mraa_gpio_write_multi
  ///
  /// Write multiple values to the GPIO. The user must provide an
  /// integer array with a length equal to the number of pins provided
  /// to [initialiseMulti()] method and in the same order.
  MraaReturnCode writeMulti(MraaGpioContext dev, List<int> values) {
    if (_initialiseMultiPinCount == 0) {
      return MraaReturnCode.errorUnspecified;
    }
    if (values.length != _initialiseMultiPinCount) {
      return MraaReturnCode.errorUnspecified;
    }
    final rawValues = ffi.calloc.allocate<Int32>(values.length);
    final typedValues = rawValues.asTypedList(_initialiseMultiPinCount);
    typedValues.setAll(0, values);
    return returnCode
        .fromInt(_impl.mraa_gpio_write_multi(dev, rawValues.cast<Int>()));
  }

  /// Owner - mraa_gpio_owner
  ///
  /// Change ownership of a [MraaGpioContext], setting [own] true indicates
  /// you wish to become the owner.
  MraaReturnCode owner(MraaGpioContext dev, bool own) {
    final rawOwn = own ? 1 : 0;
    return returnCode.fromInt(_impl.mraa_gpio_owner(dev, rawOwn));
  }

  /// Pin - mraa_gpio_get_pin
  ///
  /// Get a pin number of the GPIO, returns [Mraa.generalError] on failure.
  int pin(MraaGpioContext dev) =>
      _impl.mraa_gpio_get_pin(dev) - _grovePiPinOffset;

  /// Pin raw - mraa_gpio_get_pin_raw
  ///
  /// Get a GPIO number as used within sysfs,
  /// returns [Mraa.generalError] on failure.
  int pinRaw(MraaGpioContext dev) =>
      _impl.mraa_gpio_get_pin_raw(dev) - _grovePiPinOffset;

  /// Input mode - mraa_gpio_input_mode
  ///
  /// Set the GPIO input mode
  MraaReturnCode inputMode(MraaGpioContext dev, MraaGpioInputMode mode) =>
      returnCode
          .fromInt(_impl.mraa_gpio_input_mode(dev, gpioInputModes.asInt(mode)));

  /// Output driver mode - mraa_gpio_out_driver_mode
  ///
  /// Set the GPIO output driver mode.
  /// This is not a standard feature, it needs a custom implementation
  /// for each board.
  MraaReturnCode outputDriverMode(
          MraaGpioContext dev, MraaGpioOutputDriverMode mode) =>
      returnCode.fromInt(_impl.mraa_gpio_out_driver_mode(
          dev, gpioOutputDriverModes.asInt(mode)));
}
