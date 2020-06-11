require 'parallel'
require_relative 'ShippingStrategy';

class OrderProcessor
  attr_reader :fileName, :cores, :strategy, :coreThreshold, :pretty

  def initialize(fileName, cores, strategy, pretty)
    @fileName = fileName
    @cores = cores
    @strategy = strategy
    @coreThreshold = 501
    @pretty = pretty
  end

  # Return array of orders
  def getOrdersFromFile
    File.readlines(fileName).map do |line|
      line.split().map(&:to_f)
    end
  end

  def splitOrders orders
    orders.each_slice(orders.length / cores).to_a
  end

  def process
    orders = getOrdersFromFile

    if orders.length < coreThreshold
      orders.each do | order |
        ShippingContext.new(strategy, order, pretty).shipItems
      end

      return
    end

    processOrder = proc do | array |
      array.each do | order |
        ShippingContext.new(strategy, order, pretty).shipItems
      end
    end

    processOrders = proc do
      orders = splitOrders(orders)
      Parallel.map(orders, in_processes: cores) { |array|
        processOrder.call array
      }

    end

    processOrders.call
  end
end
