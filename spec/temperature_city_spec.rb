require 'spec_helper'
require_relative '../temperature'

  describe '#get_avg' do

    it 'should compute average temperature' do
      city_data = CityTemperature.new('test_city')
      temperature_data = [{"data_sequence"=>"1", "value"=>"6"}, {"data_sequence"=>"2", "value"=>"7"}, {"data_sequence"=>"3", "value"=>"6"}, {"data_sequence"=>"4", "value"=>"5"}, {"data_sequence"=>"5", "value"=>"11"}, {"data_sequence"=>"6", "value"=>"9"}, {"data_sequence"=>"7", "value"=>"8"}]
      expect(city_data.get_avg(temperature_data)).to eql(7)
    end
  end

  describe '#get_temp_by_day' do
    it 'should compute temperature for the current day' do
      city_data = CityTemperature.new('test_city')
      temperature_data = [{"data_sequence"=>"1", "value"=>"6"}, {"data_sequence"=>"2", "value"=>"7"}, {"data_sequence"=>"3", "value"=>"6"}, {"data_sequence"=>"4", "value"=>"5"}, {"data_sequence"=>"5", "value"=>"11"}, {"data_sequence"=>"6", "value"=>"9"}, {"data_sequence"=>"7", "value"=>"8"}]
       expect(city_data.get_temp_by_day(4,temperature_data)).to eql(5)
    end
  end