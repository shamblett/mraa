/*
 * Package : mraa
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 03/10/2019
 * Copyright :  S.Hamblett
 */

part of '../../mraa.dart';

/// The PWM MRAA API
///
/// PWM is the Pulse Width Modulation interface to MRAA.
/// It allows the generation of a signal on a pin. Some boards may
/// have higher or lower levels of resolution so make sure you
/// check the board & pin you are using before hand.
class MraaPwm {
  // The MRAA implementation
  final mraaimpl.MraaImpl _impl;

  // ignore: unused_field
  final bool _noJsonLoading;

  final bool _useGrovePi;

  // Pin offset if we are using the grove pi shield.
  int _grovePiPinOffset = 0;

  /// Construction
  MraaPwm(this._impl, this._noJsonLoading, this._useGrovePi) {
    // Set up the pin offset for grove pi usage.
    if (_useGrovePi) {
      _grovePiPinOffset = Mraa.grovePiPinOffset;
    }
  }

  /// Initialise - mraa_pwm_init
  ///
  /// Initialise an [MraaPwmContext] uses board mapping
  /// Returns pwm context or NULL.
  MraaPwmContext initialise(int pin) =>
      _impl.mraa_pwm_init(pin + _grovePiPinOffset);

  /// Initialise raw - mraa_pwm_init_raw
  ///
  /// Initialise an [MraaPwmContext], raw mode, uses the
  /// chip in which the PWM is under in SYSFS.
  MraaPwmContext initialiseRaw(int chipId, int pin) =>
      _impl.mraa_pwm_init_raw(chipId, pin + _grovePiPinOffset);

  /// Write - mraa_pwm_write
  ///
  /// Set the output duty-cycle percentage, as a double.
  /// The percentage value should lie between 0.0f
  /// (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f
  MraaReturnCode write(MraaPwmContext dev, double percentage) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_write(dev, percentage));

  /// Read - mraa_pwm_read
  ///
  /// Read the output duty-cycle percentage, as a double
  /// Returns a floating-point value representing percentage of output.
  /// The value should lie between 0.0f (representing on 0%) and 1.0f.
  /// Values above or below this range will be set at either 0.0f or 1.0f.
  double read(MraaPwmContext dev) => _impl.mraa_pwm_read(dev);

  /// Period - mraa_pwm_period
  ///
  /// Set the PWM period as seconds represented in a double
  MraaReturnCode period(MraaPwmContext dev, double seconds) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_period(dev, seconds));

  /// Period milliseconds - mraa_pwm_period_ms
  ///
  /// Set the PWM period in milliseconds
  MraaReturnCode periodMs(MraaPwmContext dev, int milliseconds) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_period_ms(dev, milliseconds));

  /// Period microseconds - mraa_pwm_period_us
  ///
  /// Set the PWM period in microseconds
  MraaReturnCode periodUs(MraaPwmContext dev, int microseconds) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_period_us(dev, microseconds));

  /// Pulse width - mraa_pwm_pulsewidth
  ///
  /// Set the PWM pulse width as seconds represented in a double
  MraaReturnCode pulseWidth(MraaPwmContext dev, double seconds) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_pulsewidth(dev, seconds));

  /// Pulse width milliseconds - mraa_pwm_pulsewidth_ms
  ///
  /// Set the PWM pulse width  in milliseconds
  MraaReturnCode pulseWidthMs(MraaPwmContext dev, int milliseconds) =>
      MraaReturnCode.returnCode(
        _impl.mraa_pwm_pulsewidth_ms(dev, milliseconds),
      );

  /// Pulse width microseconds - mraa_pwm_pulsewidth_us
  ///
  /// Set the PWM pulse width in microseconds
  MraaReturnCode pulseWidthUs(MraaPwmContext dev, int microseconds) =>
      MraaReturnCode.returnCode(
        _impl.mraa_pwm_pulsewidth_us(dev, microseconds),
      );

  /// Enable - mraa_pwm_enable
  ///
  /// Set the enable status of the PWM pin.
  /// None zero will assume on with output being driven. and 0 will
  /// disable the output.
  MraaReturnCode enable(MraaPwmContext dev, int enable) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_enable(dev, enable));

  /// Owner - mraa_pwm_owner
  ///
  /// Change(take) ownership of context
  /// Owner set to true indicates a take ownership
  MraaReturnCode owner(MraaPwmContext dev, bool owner) {
    final rawBool = owner ? 1 : 0;
    return MraaReturnCode.returnCode(_impl.mraa_pwm_owner(dev, rawBool));
  }

  /// Close - mraa_pwm_close
  ///
  /// Close and unexport the PWM pin
  MraaReturnCode close(MraaPwmContext dev) =>
      MraaReturnCode.returnCode(_impl.mraa_pwm_close(dev));

  /// Maximum period - mraa_pwm_get_max_period
  ///
  /// The maximum PWM period in us
  int maxPeriod(MraaPwmContext dev) => _impl.mraa_pwm_get_max_period(dev);

  /// Minimum period - mraa_pwm_get_min_period
  ///
  /// The minimum PWM period in us
  int minPeriod(MraaPwmContext dev) => _impl.mraa_pwm_get_min_period(dev);
}
