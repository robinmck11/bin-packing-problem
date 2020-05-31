require 'parallel'
require_relative 'ShippingStrategy';

class OrderProcessor
  attr_reader :fileName, :cores, :strategy

  def initialize(fileName, cores, strategy)
    @fileName = fileName
    @cores = cores
    @strategy = strategy
  end

  # Return array of orders
  def getOrdersFromFile
    File.readlines(fileName).map do |line|
      line.split().map(&:to_f)
    end
  end

  def splitOrders
    orders = getOrdersFromFile.each_slice(cores).to_a
  end

  def file_found?
    if !fileName
      false
    end
  end

  def processSequential
    arrays = splitOrders
    arrays.each do | array |
      array.each do |order |
        ShippingContext.new(strategy, order).shipItems
      end
    end
  end

  def process
    processOrder = proc do | array |
      array.each do | order |
        p ShippingContext.new(strategy, order).shipItems
      end
    end

    processOrders = proc do
      Parallel.map(splitOrders, in_processes: cores) { |array|
        processOrder.call array
      }

    end

    processOrders.call
  end
end
