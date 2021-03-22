# frozen_string_literal: true
require 'httparty'

module HttpHelper
  def get_response(url)
    response = HTTParty.get(url)
    response = begin
      response.parsed_response
    rescue StandardError
      {}
    end
  end
end
