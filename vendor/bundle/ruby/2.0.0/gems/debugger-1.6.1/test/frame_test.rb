require_relative 'test_helper'

describe "Frame Command" do
  include TestDsl

  it "must go up" do
    enter 'break 25', 'cont', 'up'
    debug_file('frame') { state.line.must_equal 21 }
  end

  it "must go up by specific number of frames" do
    enter 'break 25', 'cont', 'up 2'
    debug_file('frame') { state.line.must_equal 17 }
  end

  it "must go down" do
    enter 'break 25', 'cont', 'up', 'down'
    debug_file('frame') { state.line.must_equal 25 }
  end

  it "must go down by specific number of frames" do
    enter 'break 25', 'cont', 'up 3', 'down 2'
    debug_file('frame') { state.line.must_equal 21 }
  end

  it "must set frame" do
    enter 'break 25', 'cont', 'frame 2'
    debug_file('frame') { state.line.must_equal 17 }
  end

  it "must set frame to the first one by default" do
    enter 'break 25', 'cont', 'up', 'frame'
    debug_file('frame') { state.line.must_equal 25 }
  end

  it "must print current stack frame when without arguments" do
    enter 'break 25', 'cont', 'up', 'frame'
    debug_file('frame')
    check_output_includes "#0 A.d(e#String) at line #{fullpath('frame')}:25"
  end

  it "must set frame to the first one" do
    enter 'break 25', 'cont', 'up', 'frame 0'
    debug_file('frame') { state.line.must_equal 25 }
  end

  it "must set frame to the last one" do
    enter 'break 25', 'cont', 'frame -1'
    debug_file('frame') { state.line.must_equal 29 }
  end

  it "must not set frame if the frame number is too low" do
    enter 'break 25', 'cont', 'down'
    debug_file('frame') { state.line.must_equal 25 }
    check_output_includes "Adjusting would put us beyond the newest (innermost) frame", interface.error_queue
  end

  it "must not set frame if the frame number is too high" do
    enter 'break 25', 'cont', 'up 100'
    debug_file('frame') { state.line.must_equal 25 }
    check_output_includes "Adjusting would put us beyond the oldest (initial) frame", interface.error_queue
  end

  describe "full path settings" do
    temporary_change_hash_value(Debugger::Command.settings, :full_path, false)

    def short_path(fullpath)
      separator = File::ALT_SEPARATOR || File::SEPARATOR
      "...#{separator}" + fullpath.split(separator)[-3..-1].join(separator)
    end

    it "must display current backtrace with full path = true" do
      enter 'set fullpath', 'break 25', 'cont', 'where'
      debug_file('frame')
      check_output_includes(Regexp.new(
        "--> #0 A.d\\(e#String\\) at line #{fullpath('frame')}:25\\n" +
        "    #1 A.c at line #{fullpath('frame')}:21\\n",
      Regexp::MULTILINE))
    end

    it "must display current backtrace with full path = false" do
      enter 'set nofullpath', 'break 25', 'cont', 'where'
      debug_file('frame')
      check_output_includes(Regexp.new(
        "--> #0 A.d\\(e#String\\) at line #{short_path(fullpath('frame'))}:25\\n" +
        "    #1 A.c at line #{short_path(fullpath('frame'))}:21",
      Regexp::MULTILINE))
    end
  end

  describe "display backtrace with callstyle" do
    temporary_change_hash_value(Debugger::Command.settings, :callstyle, :last)

    it "must display current backtrace with last callstyle" do
      enter 'set callstyle last', 'break 25', 'cont', 'where'
      debug_file('frame')
      check_output_includes(Regexp.new(
        "--> #0 A.d\\(e#String\\) at line #{fullpath('frame')}:25\\n" +
        "    #1 A.c at line #{fullpath('frame')}:21\\n" +
        "    #2 A.b at line #{fullpath('frame')}:17\\n" +
        "    #3 A.a at line #{fullpath('frame')}:14\\n",
      Regexp::MULTILINE))
    end

    it "must display current backtrace with short callstyle" do
      enter 'set callstyle short', 'break 25', 'cont', 'where'
      debug_file('frame')
      check_output_includes(Regexp.new(
        "--> #0 d\\(e\\) at line #{fullpath('frame')}:25\\n" +
        "    #1 c at line #{fullpath('frame')}:21\\n" +
        "    #2 b at line #{fullpath('frame')}:17\\n" +
        "    #3 a at line #{fullpath('frame')}:14\\n",
      Regexp::MULTILINE))
    end

    # NOTE: We also have support of 'tracked' callstyle in the code, but by some reason
    # it is not allowed to be set by the 'set' command
    it "must not set 'tracked' callstyle" do
      enter 'set callstyle tracked'
      debug_file('frame')
      check_output_includes "Invalid call style tracked. Should be one of: 'short' or 'last'"
      Debugger::Command.settings[:callstyle].must_equal :last
    end
  end

  it "must change frame in another thread"
  it "must not change frame in another thread if specified thread doesn't exist"

  describe "Post Mortem" do
    # TODO: This test fails with "Segmentation fault". Probably need to fix it somehow, or forbid this
    # command in the post mortem mode. Seems like state.context.frame_file and state.context.frame_line
    # cause that.
    it "must work in post-mortem mode"
    #  enter 'cont', "frame"
    #  debug_file "post_mortem"
    #  pi
    #end
  end

end
