class GenerateSampleData
  def generate orders, max_items, file_name
    file = File.new(file_name, "w")

    # Generate items for customers
    while orders > 0
      (0..rand(max_items)).each do | order |
        file.print rand(0.1..1).round(1).to_s + " "
      end

      file.puts ""
      orders-=1

    end

    file.close()
  end
end
