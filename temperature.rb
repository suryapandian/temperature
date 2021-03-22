# frozen_string_literal: true

require 'active_support/all'
require_relative 'temperature_city'

input = ARGV[0].split(' ')

if input.length > 1

  result = CityTemperature.new(input[2]).get_temperature_data

  puts "todays temperature #{result[:day_temp]}" if input[1] == '-today' || input[1] == '-all'
  puts "average temperature minima #{result[:avg_minima]}" if input[1] == '-av_min' || input[1] == '-all'
  puts "average temperature maxima #{result[:avg_maxima]}" if input[1] == '-av_max' || input[1] == '-all'

end
