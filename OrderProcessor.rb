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
        # Do the work
      end
    end
  end

  def process
    processOrder = proc do | array |
      size = 0;
      array.each do | order |
        # Do the work
      end
    end

    processOrders = proc do
      arrays = splitOrders;

      Parallel.map(arrays, in_processes: cores) { |array|
        processOrder.call array
      }

    end

    processOrders.call;
  end
end

class OrderProcessorFactory
  def self.processOrders fileName, cores, type
    if type == 'first_fit'
      FirstFitOrderProcessor.new fileName, cores
    end
  end
end
