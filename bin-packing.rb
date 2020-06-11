require_relative "OrderProcessing/OrderProcessor"
require_relative "OrderProcessing/ShippingStrategy"

strategy = ShippingStrategyFirstFit.new
cores = 3
pretty = nil

if !ARGV[0]
  raise "Missing file name argument\nUsage: < ruby bin-packing.rb <file_name> <pretty> >"
end

if !ARGV[1]
  pretty = false
else
  pretty = true
end

bins = OrderProcessor.new(ARGV[0], cores, strategy, pretty).process
