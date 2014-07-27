#!/usr/bin/ruby

require 'optparse'

start = 5
finish = start + 10
OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"
    opts.on("-s", "--from Start from position N") do |x|
        start  = x.to_i
        finish = start + 10 if start < finish
    end
    opts.on("-a", "--amount Numbers after the starting position to show") do |x|
        finish = start + x.to_i
    end
end.parse!

new = 0
old = 0

1.upto(finish) do |count|
    print "#{new} " if count.between?(start,finish - 1)
    if new == 0
        new += 1
        next
    end
    new = old + new
    old = new - old
end
