require_relative '../test_helper'

describe "Printers::Plain" do
  include PrinterHelpers
  include TestDsl

  let(:klass) { Printers::Plain }
  let(:printer) { klass.new }
  let(:yaml_plain) do
    {
      "foo" => {
        "bar" => "plain {zee}, {uga} gaa",
        "with_c" => "{arg} bla|c",
        "confirmations" => {
          "okay" => "Okay?"
        }
      },
      "variable" => {"variable" => "{key}: {value}"}
    }
  end

  let(:yaml_base) do
    {
      "foo" => {
        "bar" => "base {zee}, {uga} gaa",
        "boo" => "{zee}, gau"
      }
    }
  end

  before do
    YAML.stubs(:load_file).with(yaml_file_path('plain')).returns(yaml_plain)
    YAML.stubs(:load_file).with(yaml_file_path('base')).returns(yaml_base)
  end

  describe "#print" do
    it "must return correctly translated string" do
      printer.print("foo.bar", zee: 'zuu', uga: 'aga').must_equal "plain zuu, aga gaa\n"
    end

    it "must add (y/n) to the confirmation strings" do
      printer.print("foo.confirmations.okay").must_equal "Okay? (y/n) \n"
    end

    it "must use strings, inherited from base" do
      printer.print("foo.boo", zee: 'zuu').must_equal "zuu, gau\n"
    end
  end

  describe "errors" do
    it "must show an error if there is no specified path" do
      ->{ printer.print("foo.bla") }.must_raise klass::MissedPath
    end

    it "must show an error if there is no specified argument" do
      ->{ printer.print("foo.bar", zee: 'zuu') }.must_raise klass::MissedArgument
    end
  end

  describe "#print_collection" do
    it "must print collection" do
      printer.print_collection("foo.bar", [{uga: 'a'}, {uga: 'b'}]) do |item, index|
        item.merge(zee: index)
      end.must_equal "plain 0, a gaa\nplain 1, b gaa\n"
    end

    it "must columnize collection with modifier 'c'" do
      temporary_change_hash_value(Debugger.settings, :width, 30) do
        printer.print_collection("foo.with_c", (1..10)) { |i, _| {arg: i} }.must_equal(
          "1 bla  4 bla  7 bla  10 bla\n" +
          "2 bla  5 bla  8 bla\n" +
          "3 bla  6 bla  9 bla\n"
        )
      end
    end
  end

  describe "#print_variables" do
    it "must print variables" do
      printer.print_variables([['a', 'b'], ['c', 'd']], '').must_equal %{a: b\nc: d\n}
    end
  end

end
