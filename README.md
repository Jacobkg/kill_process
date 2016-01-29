# KillProcess

Normally when you want to make sure that a block of code in Ruby does not run longer than a maximum amount of time, you would use `Timeout` from the standard library (http://ruby-doc.org/stdlib-2.3.0/libdoc/timeout/rdoc/Timeout.html). While this works most of the time, in some edge cases it fails to stop the process. See, for example http://www.mikeperham.com/2015/05/08/timeout-rubys-most-dangerous-api/.

This gem provides a backstop in the case that you absolutely, positvely want your process to die after N seconds have elapsed. It is implemented using POSIX advanced realtime timers, in particular `timer_create` (http://man7.org/linux/man-pages/man2/timer_create.2.html) and `timer_settime` (http://man7.org/linux/man-pages/man2/timer_settime.2.html).

When `KillProcess.after(1.minute)` is called, a kernel process timer is creating that will send a `SIGKILL` (aka `kill -9`) to the process after 60 seconds. This is about as serious of a way as I am aware of to make sure the process dies. 

## Compatibility

Although advanced realtime timers are part of POSIX, not all unix-y distributions support them. The most notable exception is Max OS X which does not support these libraries. It should work on any modern Linux distro. Obviously Windows is not supported.

If you call this library on a non-supported platform, it will print a warning and perform a noop.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kill_process'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kill_process

## Usage

Because `KillProcess` is a very dirty way to kill your process (does not allow for cleanup), I like to use it as a backstop to the standard ruby `Timeout`. For example

```ruby
KillProcess.after(75)
Timeout::timeout(60) do
  # Something expected to take less than 60 seconds
end
# Exit here. This library does not currently support unsetting the timer 
# so if you don't exit within 75 seconds it will die
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

