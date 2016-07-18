require 'yaml'

class Authenticator
  @@utilities = YAML.load_file('./utilities.yml')

  def initialize(utility = 'dominion', browser)
    @utility = utility
    @browser = browser

    @login_info = @@utilities[@utility][:login]
    raise 'Invalid Utility' unless @login_info
  end
  attr_accessor :login_info, :utility, :browser

  def login(username, password)
    raise 'Invalid Login Information' unless username && password

    browser.goto(login_info[:url])

    # set username & password fields
    browser.text_field(login_info[:username_identifier]).set(username)
    browser.text_field(login_info[:password_identifier]).set(password)

    # submit form
    browser.button(login_info[:submit_identifier]).click
    success_verifier = login_info[:success_verifier]

    # Return expected value, to verify if login attempt was successful
    browser.element(xpath: success_verifier[:xpath]).text == success_verifier[:expected_value]
  end
end
