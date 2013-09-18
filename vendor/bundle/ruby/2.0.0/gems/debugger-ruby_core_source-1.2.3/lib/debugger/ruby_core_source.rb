require 'debugger/ruby_core_source/version'
require 'rbconfig'

module Debugger
  module RubyCoreSource
    REVISION_MAP = {
      24186 => 'ruby-1.9.2-preview1',
      27362 => 'ruby-1.9.2-preview3',
      28524 => 'ruby-1.9.2-rc1',
      28618 => 'ruby-1.9.2-rc2',
      32789 => 'ruby-1.9.3-preview1',
      33323 => 'ruby-1.9.3-rc1',
      37411 => 'ruby-2.0.0-preview1',
      38126 => 'ruby-2.0.0-preview2',
      38733 => 'ruby-2.0.0-rc1',
      39161 => 'ruby-2.0.0-rc2',
    }

    def self.create_makefile_with_core(hdrs, name)
      # First, see if the gem already has the needed headers
      if hdrs.call
        create_makefile(name)
        return true
      end

      ruby_dir = if RUBY_PATCHLEVEL < 0
        REVISION_MAP[RUBY_REVISION] or
          no_source_abort("ruby-#{RUBY_VERSION} (revision #{RUBY_REVISION})")
      else
        "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
      end

      # Check if core headers were already downloaded; if so, use them
      if RbConfig::CONFIG["rubyhdrdir"]
        dest_dir = RbConfig::CONFIG["rubyhdrdir"] + "/" + ruby_dir
        with_cppflags("-I" + dest_dir) {
          if hdrs.call
            create_makefile(name)
            return true
          end
        }
      end

      # Look for sources that ship with gem
      dest_dir = File.dirname(__FILE__) + "/ruby_core_source/#{ruby_dir}"
      no_source_abort(ruby_dir) unless File.directory?(dest_dir)

      with_cppflags("-I" + dest_dir) {
        if hdrs.call
          create_makefile(name)
          return true
        end
      }
      return false
    end

    def self.no_source_abort(ruby_version)
      abort <<-STR
Makefile creation failed
**************************************************************************
No source for #{ruby_version} provided with debugger-ruby_core_source gem.
**************************************************************************
STR
    end
  end
end
