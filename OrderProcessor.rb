require 'parallel';

class OrderProcessor
  attr_reader :fileName, :cores

  def initialize(fileName, cores)
    @fileName = fileName
    @cores = cores;
  end

  # Return array of orders
  def getOrdersFromFile
    File.readlines(fileName).map do |line|
      line.split().sort.reverse.map(&:to_f)
    end
  end

  def splitOrders
    orders = getOrdersFromFile.each_slice(cores).to_a;
  end

  def file_found?
    if !fileName
      return false;
    end
  end
end

class FirstFitOrderProcessor < OrderProcessor
  def initialize(filename, cores)
    super
  end

  def processSequential
    arrays = splitOrders;
    sum = 0;
    arrays.each do | array |
      array.each do |sub_array |
        p sub_array;
      end
    end
  end

  def processFirstFitOrders

    # Test to see that we can process orders in parallel
    processOrder = proc do | array |
      size = 0;
      array.each do | order |
        p order;
      end
    end

    processOrders = proc do
      arrays = splitOrders;

      Parallel.map(arrays, in_processes: arrays.length) { |array|
        processOrder.call array
      }

    end

    processOrders.call;

  end
end

## Sequential Test
# order_processor = FirstFitOrderProcessor.new('SampleData/sampleData.txt', 3);
# order_processor.processSequential;

## Parallel test
order_processor1 = FirstFitOrderProcessor.new('sampleData/sampleData.txt', 50);
order_processor1.processFirstFitOrders;
