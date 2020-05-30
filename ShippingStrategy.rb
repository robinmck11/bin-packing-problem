class ShippingContext
  attr_writer :strategy
  attr_reader :data

  def initialize(strategy, data)
    @strategy = strategy
    @data = data
  end

  def shipItems
    @strategy.ship(@data)
  end
end

class ShippingStrategy
  def ship(data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ShippingStrategyFirstFit < ShippingStrategy
  def ship(items)
    bin =  []
    bins = []

    # Process each item in the line,
    # add to the bin if the sum of the bin items plus the current item is <= 1
    items.sort.reverse.each_with_index do | item, index |
      item = item.to_f

      # Only 1 item to pack?
      return bins.push([item]) if (items.length == 1)

      # Create first bin
      if index == 0
        bin.push item
        next
      end

      # if the sum of the current bin + the current item is <= 1
      # Add the item to the bin
      # else add the item to a new bin
      if bin.reduce(0) { |sum, num| sum + num } + item <= 1
        bin.push item
      else
        bins.push bin
        bin = []
        bin.push item
      end

      # Anything left over goes into a new bin
      if index == items.length - 1
        bins.push bin
      end
    end

    # Return the items bundled into bins
    bins

  end
end
