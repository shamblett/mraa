# Unimplemented MRAA API calls

## Common
mraa_deinit - No need for this, we will not be debugging/developing MRAA in Dart

## GPIO
mraa_gpio_isr<br>
mraa_gpio_isr_exit

The ISR function needs a callback registering, currently we can't do this with FFI,
as we cant support some of the ISR functionality and not all of it we don't support
these calls.
