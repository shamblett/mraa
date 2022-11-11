/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of mraa;

/// The LED MRAA API
///
/// LED is the Light Emitting Diode interface to MRAA
/// It is used to access the on board LED's via sysfs.
class MraaLed {
  /// Construction
  MraaLed(this._impl, this._noJsonLoading);

  /// The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  /// Initialise - mraa_led_init
  ///
  /// Initialise a [MraaLedContext], based on LED index.
  /// Returns a a [MraaLedContext] or NULL
  MraaLedContext initialise(int led) => _impl.mraa_led_init(led);

  /// Initialise raw - mraa_led_init_raw
  ///
  /// Initialise a a [MraaLedContext] based on LED function name.
  /// The structure of a LED entry in sysfs is "devicename:colour:function"
  /// This method expects only one unique LED identifier which would be
  /// "function" name most often.
  /// For instance, initialiseRaw("user4")
  MraaLedContext initialiseRaw(String ledDev) =>
      _impl.mraa_led_init_raw(ledDev.toNativeUtf8().cast<Char>());

  /// Set brightness - mraa_led_set_brightness
  ///
  /// Set LED brightness
  MraaReturnCode setBrightness(MraaLedContext dev, int value) =>
      returnCode.fromInt(_impl.mraa_led_set_brightness(dev, value));

  /// Read brightness - mraa_led_read_brightness
  ///
  /// Read LED brightness
  int readBrightness(MraaLedContext dev) => _impl.mraa_led_read_brightness(dev);

  /// Read brightness - mraa_led_read_max_brightness
  ///
  /// Read LED maximum brightness
  int readMaxBrightness(MraaLedContext dev) =>
      _impl.mraa_led_read_max_brightness(dev);

  /// Set trigger - mraa_led_set_trigger
  ///
  /// Set LED trigger to the trigger name supplied.
  MraaReturnCode setTrigger(MraaLedContext dev, String triggerName) =>
      returnCode.fromInt(_impl.mraa_led_set_trigger(
          dev, triggerName.toNativeUtf8().cast<Char>()));

  /// Clear trigger - mraa_led_clear_trigger
  ///
  /// Clear active LED trigger
  MraaReturnCode clearTrigger(MraaLedContext dev) =>
      returnCode.fromInt(_impl.mraa_led_clear_trigger(dev));

  /// Close - mraa_led_close
  ///
  /// Close LED file descriptors and free the context memory.
  MraaReturnCode close(MraaLedContext dev) =>
      returnCode.fromInt(_impl.mraa_led_close(dev));
}
