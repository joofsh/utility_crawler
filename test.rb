require 'minitest'
require "minitest/autorun"
require 'headless'
require 'watir-webdriver'
require_relative './authenticator'
require_relative './utility_info'

require 'dotenv'
Dotenv.load

USERNAME = ENV['USERNAME'] || ARGV[0]
PASSWORD = ENV['PASSWORD'] || ARGV[1]

describe 'Utility Info System' do
  before do
    @browser = Watir::Browser.new :phantomjs
    @authenticator = Authenticator.new('dominion', @browser)
  end

  describe Authenticator do
    it 'authenticates' do
      assert @authenticator.login(USERNAME, PASSWORD)
    end
  end

  describe UtilityInfo do
    before do
      @authenticator.login(USERNAME, PASSWORD)
      @utility_info = UtilityInfo.new('dominion', USERNAME, @browser)
      @utility_info.fetch_data!
    end

    it 'extracts expected raw values' do
      # TODO: VCR record the response.
      # Currently this does the web crawling live, which will result
      # in the tests failing as the values change throughout the month
      expected_values = {
        bill_due_date: 'August 8, 2016',
        bill_amount: '$120.17',
        meter_read_date: '07/14/2016',
        meter_usage: '978',
        service_start_date: 'July 15, 2016'
      }
      @utility_info.data.each do |key, value|
        assert_equal expected_values[key], value
      end
    end
  end
end

