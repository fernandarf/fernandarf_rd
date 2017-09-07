#enconding: utf-8

require 'cucumber/formatter/unicode'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'capybara/rspec'


Before do
  @driver = Selenium::WebDriver.for :firefox
end


After do
  @driver.close
end