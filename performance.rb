require_relative "SampleData/GenerateSampleData"

generator = GenerateSampleData.new
max_items = 100
time_to_complete = {}

(1..100).each do | index |
  timeStart = Time.now
  generator.generate index, max_items, 'sample-data.txt'
  time_to_complete[index] = (Time.now - timeStart)
end

p time_to_complete
