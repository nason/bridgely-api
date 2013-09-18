## Description
Fork of [ruby\_core\_source](https://github.com/mark-moseley/ruby_core_source)
that uses included Ruby headers (\*.h and \*.inc) instead of downloading
them. Used by [debugger](http://github.com/cldwalker/debugger).

##Usage

Example use in extconf.rb:

```ruby
require 'ruby_core_source'
hdrs = proc { have_header("vm_core.h") and have_header("iseq.h") }
dir_config("ruby") # allow user to pass in non-standard core include directory
if !Ruby_core_source::create_makefile_with_core(hdrs, "foo")
  # error
  exit(1)
end
```

To add another ruby version's source to this gem's directory:

    $ rake add_source VERSION=1.9.3-p0

##Credits
* @stepheneb for 1.9.2-p320 headers
* @jeremy for 1.9.3-p286 headers
* @eiel for 1.9.3-p327, 1.9.3-p362, 2.0.0* headers
* @willian for 1.9.3-p374 headers

## LICENSE
Ruby library code is MIT license, see LICENSE.txt.  Included ruby headers,
lib/debugger/ruby\_core\_source/, are mostly Ruby license, see RUBY\_LICENSE. Some headers have
their own licenses, see LEGAL.
