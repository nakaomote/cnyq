#!/usr/bin/ruby

require 'ostruct'

#######################################################################

class OrderReport
    def initialize(orders, start_at, end_at)
        @orders   = orders
        @start_at = start_at
        @end_at   = end_at
    end

    def total_sales_within_range
        sum = 0
        @orders.each do |order|
            next unless order.placed_at >= @start_at && order.placed_at <= @end_at
            sum += order.placed_at
        end
        return sum
    end
end

class Order < OpenStruct
end

#######################################################################

orders = Array.new

1.upto(rand(1024)) do |x|
    orders.push Order.new
    orders.last.placed_at = rand(1024)
end

myreport = OrderReport.new(orders,50,100)
puts "random: #{myreport.total_sales_within_range}"

1.upto(1000) do |x|
    orders.push Order.new
    orders.last.placed_at = 100
end

myreport = OrderReport.new(orders,50,100)
puts "100000 + random: #{myreport.total_sales_within_range}"
