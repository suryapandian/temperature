# frozen_string_literal: true

require_relative 'http'

class CityTemperature
  include HttpHelper

  attr_reader :city, :temperature_data

  def initialize(city)
    @city = city
    @temperature_data = { temperature_minima: {}, temperature_maxima: {}, day_data: {} }
  end

  def get_url
    url = ENV['TIEMPO_URL'] || 'http://api.tiempo.com/index.php?api_lang=es&division=102&affiliate_id=zdo2c683olan'
    cities_data = get_response(url)
    result = ''
    cities_data['report']['location']['data'].each do |city_data|
      result = "#{city_data['url']}&affiliate_id=zdo2c683olan" if city_data['name']['__content__'] == city
    end
    result
  end

  TEMP_MINIMA_KEY = 'Temperatura Mínima'
  TEMP_MAXIMA_KEY = 'Temperatura Máxima'
  DAY_KEY = 'Día'

  def get_temperature_data
    city_url = get_url
    raise "Invalid city #{city}" if city_url == ''

    city_data = get_response(city_url)

    city_data['report']['location']['var'].each do |city_d|
      temperature_data[:temperature_minima] = city_d['data']['forecast'] if city_d['name'] == TEMP_MINIMA_KEY
      temperature_data[:temperature_maxima] = city_d['data']['forecast'] if city_d['name'] == TEMP_MAXIMA_KEY
      temperature_data[:day_data] = city_d['data']['forecast'] if city_d['name'] == DAY_KEY
    end
    {
      avg_minima: get_avg(temperature_data[:temperature_minima]),
      avg_maxima: get_avg(temperature_data[:temperature_maxima]),
      day_temp: get_todays_temperature
    }
  end

  def get_avg(temp_data)
    total_temp = 0
    total_data_points = temp_data.length
    temp_data.each  do |temp|
      total_temp += temp['value'].to_i
    end
    total_temp / total_data_points
  end

  def get_temp_by_day(day, temp_data)
    result = 0
    temp_data.each do |temp|
      if temp['data_sequence'].to_i == day
        result = temp['value'].to_i
        break
      end
    end
    result
  end

  SPANISH_DAY_CONVERSION = {
    'Domingo' => 'Sunday',
    'Lunes' => 'Monday',
    'Martes' => 'Tuesday',
    'Miércoles' => 'Wednesday',
    'Jueves' => 'Thursday',
    'Viernes' => 'Friday',
    'Sábado' => 'Saturday'
  }.freeze

  def get_todays_temperature
    today = Date.today.strftime('%A')
    temp_index = 0
    temperature_data[:day_data].each do |day_d|
      if today == SPANISH_DAY_CONVERSION[day_d['value']]
        temp_index = day_d['data_sequence'].to_i
        break
      end
    end
    (get_temp_by_day(temp_index,
                     temperature_data[:temperature_minima]) + get_temp_by_day(temp_index,
                                                                              temperature_data[:temperature_maxima])) / 2
  end
end
