require_relative "OrderProcessing/OrderProcessor"
require_relative "OrderProcessing/ShippingStrategy"

file_name = "SampleData/sample-data.rb";
strategy = nil;

if !ARGV[0]
  raise "Missing strategy argument\nUsage: <ruby performance.rb <Strategy: (first_fit, best_fit)> <cores: (1..n)>"
end

if !ARGV[1]
  raise "Missing cores argument\nUsage: <ruby performance.rb <Strategy: (first_fit, best_fit)> <cores: (1..n)>"
end

if ARGV[0] == 'first_fit'
  strategy = ShippingStrategyFirstFit.new
elsif ARGV[0] == 'best_fit'
  strategy = ShippingStrategyBestFit.new
else
  raise "Strategy not found"
end

if ARGV[1] == "1"
  OrderProcessor.new(file_name, 1, strategy).processSequential
else
  OrderProcessor.new(file_name, ARGV[1].to_i, strategy).process
end
