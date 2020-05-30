class ShippingContext
  attr_writer :strategy
  attr_reader :data

  def initialize(strategy, data)
    @strategy = strategy
    @data = data
  end

  def shipItems
    puts 'Context: Sorting data using the strategy (not sure how it\'ll do it)'
    result = @strategy.ship(@data)
    # For debugging purposes
    print result
  end
end

class ShippingStrategy
  def ship(data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ShippingStrategyFirstFit < ShippingStrategy
  def ship(items)
    bin =  [];
    bins = [];

    # Process each item in the line,
    # add to the bin if the sum of the bin items plus the current item is <= 1
    items.each_with_index do | line_item, index |
      line_item = line_item.to_f;

      # Push first item to bin
      if bin.empty?
        bin.push line_item;
        next;
      end

      # if the sum of the current bin + the current item is < 1
      # Add the item to the bin
      if bin.reduce(0) { |sum, num| sum + num } + line_item <= 1
        bin.push line_item;

        # If its the last item to be processed, push to the bins array
        if index === items.length - 1
          bins.push bin;
        end

        # There may be more items to add to this bin
        next;
      end

      # If we reach this point and it's the last item in the list,
      # we know we need to create a new bin for this item
      if index === items.length - 1
        bins.push([line_item]);
      end

      # Conditon above is false, Create a new bin
      bins.push bin;
      bin = [];
      bin.push line_item;
    end

    # Return the items bundled into bins
    bins;

  end
end
