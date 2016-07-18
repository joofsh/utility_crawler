require 'yaml'

class UtilityInfo
  @@utilities = YAML.load_file('./utilities.yml')

  def initialize(utility, username, browser)
    @utility = utility
    @username = username
    @browser = browser
    @data = {}

    @data_points_info = @@utilities[@utility][:data_points]
    raise 'Invalid Utility' unless @data_points_info
  end

  attr_accessor :username, :browser, :data_points_info, :data

  def fetch_data!
    @data_points_info.each do |key, info|
      browser.goto(info[:url])
      value = browser.element(xpath: info[:xpath]).text
      @data[key] = value
    end
  end

  def print
    puts "Utility info:"
    puts "Username: #{username}"
    @data.each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end
