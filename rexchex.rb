#!/usr/bin/env ruby
require 'optparse'
VERSION = "1.0"
expression = nil
test_strings = []

OptionParser.new do |opts|
  opts.banner = "RexChex: Simple regex checker:\n" +
                "Give a list of strings and a regular expression, and this script will check\n" +
                "if each string matches the expression"

  opts.on("-eEXPRESSION", "--expression=EXPRESSION", "Expression to test against") do |e|
    expression = e
  end

  opts.on("-sSTRING", "--test-string=STRING", "String to test against") do |s|
    test_strings.push(s)
  end

  opts.on("-iFILE", "--input-file=FILE", "File containing strings to test against") do |l|
    File.open(l).readlines.each do |line|
      test_strings.push(line.strip)
    end
  end

  opts.on("-v", "--version", "Print RexChex version and exit") do |v|
    puts(VERSION)
    exit 0
  end

end.parse!

if expression.nil?
  print("No expression given")
end

rex = Regexp.new(expression)
for test_string in test_strings do
  hit = test_string =~ rex ? "HIT " : "MISS"
  puts("[#{hit}] #{test_string}")
end