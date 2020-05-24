if !ARGV[0]
  raise "Provide number of orders to arguments
         Usage: generate-sample-data.rb <number_of_orders> <max_number_of_items>";
end

if !ARGV[1]
  raise "Provide max number of items to arguments
         Usage: generate-sample-data.rb <number_of_orders> <max_number_of_items>";
end

orders = ARGV[0].to_i;

file = File.new("sampleData.txt", "w");

# Generate items for customers
while orders > 0
  maxItems = rand(ARGV[1].to_i);

  (0..maxItems).each do | order |
    file.print rand(0.1..1).round(1).to_s + " ";
  end

  file.puts "";
  orders-=1;

end

file.close();
