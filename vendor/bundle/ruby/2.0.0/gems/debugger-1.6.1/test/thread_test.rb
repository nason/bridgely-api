require_relative 'test_helper'

describe "Thread Command" do
  include TestDsl
  let(:release) { 'eval Thread.main[:should_break] = true' }

  describe "list" do
    it "must show current thread by 'plus' sign" do
      thnum = nil
      enter 'break 8', 'cont', 'thread list', release
      debug_file('thread') { thnum = Debugger.contexts.first.thnum }
      check_output_includes /\+ #{thnum} #<Thread:\S+ run>\t#{fullpath('thread')}:8/
    end

    it "must work with shortcut" do
      thnum = nil
      enter 'break 8', 'cont', 'th list', release
      debug_file('thread') { thnum = Debugger.contexts.first.thnum }
      check_output_includes /\+ #{thnum} #<Thread:\S+ run>\t#{fullpath('thread')}:8/
    end

    it "must show 3 available threads" do
      enter 'break 21', 'cont', 'thread list', release
      debug_file 'thread'
      check_output_includes /#<Thread:\S+ (sleep|run)>.*#<Thread:\S+ (sleep|run)>.*#<Thread:\S+ (sleep|run)>/m
    end
  end


  describe "stop" do
    it "must stop one of the threads" do
      thnum = nil
      enter 'break 21', 'cont', ->{"thread stop #{Debugger.contexts.last.thnum}"}, release
      debug_file('thread') { thnum = Debugger.contexts.last.thnum }
      check_output_includes /\$ #{thnum} #<Thread:/
    end

    it "must show error message if thread number is not specified" do
      enter 'break 8', 'cont', "thread stop", release
      debug_file 'thread'
      check_output_includes "'thread stop' needs a thread number", interface.error_queue
    end

    it "must show error message when trying to stop current thread" do
      enter 'break 8', 'cont', ->{"thread stop #{Debugger.contexts.first.thnum}"}, release
      debug_file 'thread'
      check_output_includes "It's the current thread", interface.error_queue
    end
  end


  describe "resume" do

    # TODO: This test sometimes causes Segmentation Fault. No idea how to fix it...
    it "must resume one of the threads"# do
    #  thnum = nil
    #  # If we don't put some sleep before 'thread resume', it may not change its status yet... :(
    #  enter(
    #    'break 21',
    #    'cont',
    #    -> do
    #      thnum = Debugger.contexts.last.thnum
    #      "thread stop #{thnum}"
    #    end,
    #    -> { puts; "thread resume #{thnum}" },
    #    -> { puts; release }
    #  )
    #  debug_file('thread') { Debugger.contexts.last.suspended?.must_equal false }
    #  check_output_includes "", thnum.to_s, /#<Thread:/
    #end

    it "must show error message if thread number is not specified" do
      enter 'break 8', 'cont', "thread resume", release
      debug_file 'thread'
      check_output_includes "'thread resume' needs a thread number", interface.error_queue
    end

    it "must show error message when trying to resume current thread" do
      enter 'break 8', 'cont', ->{"thread resume #{Debugger.contexts.first.thnum}"}, release
      debug_file 'thread'
      check_output_includes "It's the current thread", interface.error_queue
    end

    it "must show error message if it is not stopped" do
      enter 'break 21', 'cont', ->{"thread resume #{Debugger.contexts.last.thnum}"}, release
      debug_file('thread')
      check_output_includes "Already running", interface.error_queue
    end
  end


  describe "switch" do
    it "must switch to another thread"# do
    #  enter 'break 21', 'cont', ->{"thread #{Debugger.contexts.last.thnum}"}, release
    #  debug_file('thread') { state.line.must_equal 16 }
    #end

    it "must show error message if thread number is not specified" do
      enter 'break 8', 'cont', "thread switch", release
      debug_file 'thread'
      check_output_includes "thread thread switch argument 'switch' needs to be a number"
    end

    it "must show error message when trying to switch current thread" do
      enter 'break 8', 'cont', ->{"thread switch #{Debugger.contexts.first.thnum}"}, release
      debug_file 'thread'
      check_output_includes "It's the current thread", interface.error_queue
    end
  end


  describe "Post Mortem" do
    it "must work in post-mortem mode" do
      enter 'cont', 'thread list'
      debug_file('post_mortem')
      check_output_includes /\+ \d+ #<Thread:(\S+) run/
    end
  end

end
