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

class ShippingStrategyBestFit < ShippingStrategy
  def ship(items)
    bins = Hash.new []

    # Populate hash
    (1..10).each do | key |
      bins[key] = []
    end

    # Process each item in the line,
    # add to the bin if the sum of the bin items plus the current item is <= 1
    items.each_with_index do | item, index |
      item = item.to_f

      # Start at position
      insert_at = (10 - item * 10).to_i
      next_best_insert_at = insert_at

      # Create first bin
      if index == 0
        bins[(item * 10).to_i] << [item]
        next
      end

      while next_best_insert_at > 0
        update_position = next_best_insert_at + (item * 10).to_i

        if !bins[next_best_insert_at].empty?

          # Context can either be updating an existing array
          # Or creating a new one
          if bins[update_position].empty?
            bins[update_position] = [bins[next_best_insert_at].last << item]
            bins[next_best_insert_at].pop
          else
            bin = bins[next_best_insert_at].last << item
            bins[update_position] << bin
            bins[next_best_insert_at].pop
          end

          # We've done the work so force it to complete
          next_best_insert_at = 0
        end

        # we've looked but couldn't find an appropriate place
        if next_best_insert_at == 1
          bins[(item * 10).to_i] << [item]
        end

        next_best_insert_at-=1
      end
    end

    bins

  end
end
