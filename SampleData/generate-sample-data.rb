require_relative 'SampleData'

GenerateSampleData.new.generate ARGV[0].to_i, ARGV[1].to_i, 'sample-data.txt', true
