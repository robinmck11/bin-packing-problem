if !ARGV[0]
  raise "No filename provided to arguments"
end

File.open(ARGV[0]) do | file |
  file.each_line do | line |
    bin =  [];
    bins = [];
    line = line.split(' ').sort.reverse;

    # Take the First Fit approach
    # Process each item in the line,
    # add to the bin if the sum of the bin items plus the current item is <= 1
    line.each_with_index do | line_item, index |
      line_item = line_item.to_f;

      # Push first item to bin
      if bin.empty?
        bin.push line_item;
        next;
      end

      if bin.reduce(0) { |sum, num| sum + num } + line_item <= 1
        bin.push line_item;

        # If its the last item to be processed, push to the bins array
        if index === line.length - 1
          bins.push bin;
        end

        next;

      end

      if index === items.length - 1
        bins.push([line_item]);
      end

      bins.push bin;
      bin = [];
      bin.push line_item;

    end

    puts "All Bins: "
    p bins;
    puts "\n";

  end
end
