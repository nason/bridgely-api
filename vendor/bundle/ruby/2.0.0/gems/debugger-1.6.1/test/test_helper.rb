require 'pathname'
require 'minitest/autorun'
require 'mocha/setup'

require 'debugger'
require 'debugger/test'

$debugger_test_dir = File.expand_path("..", __FILE__)
Debugger::Command.settings[:debuggertesting] = true
Debugger::Command.settings[:width] = 180
