class GenerateSampleData
  def generate orders, max_items, file_name, random
    file = File.new(file_name, "w")

    # Generate items for customers
    while orders > 0
      if random
        number_of_items = rand(max_items)
      else
        number_of_items = max_items
      end

      (0..number_of_items).each do | order |
        file.print rand(0.1..1).round(1).to_s + " "
      end

      file.puts ""
      orders-=1

    end

    file.close()
  end
end
