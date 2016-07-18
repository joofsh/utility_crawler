#!/usr/bin/env ruby

require 'headless'
require 'watir-webdriver'
require 'dotenv'

require_relative './authenticator'
require_relative './utility_info'

Dotenv.load
browser = Watir::Browser.new :phantomjs
authenticator = Authenticator.new('dominion', browser)

username = ENV['USERNAME'] || ARGV[0]
password = ENV['PASSWORD'] || ARGV[1]
authenticator.login(username, password)

utility_info = UtilityInfo.new('dominion', username, browser)
utility_info.fetch_data!
utility_info.print

