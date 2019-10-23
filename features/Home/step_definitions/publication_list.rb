require 'httparty'
require 'json'

When(/^loading the home page "([^"]*)"$/) do |web_url|
  @browser.goto web_url
end

Then(/^the title is "([^"]*)"$/) do |expected_message|
  @browser.h1(:text => expected_message).wait_until(&:present?)
end

Then(/^the main button is "([^"]*)"$/) do |expected_message|
  @browser.button(:class => 'mat-raised-button').wait_until(&:present?).text.should include expected_message
end

And(/^click on button "([^"]*)"$/) do |expected_message|
  @browser.button(:text => expected_message).wait_until(&:present?).click
end

And(/^author information:$/) do |author|
  @authors = author.hashes
end

And("enter author information") do
  @authors.each do |row|
    @browser.text_field(:id => /authorName/).set(row[:authorName])
    @browser.text_field(:id => /birthDate/).set(row[:birthDate])
    @browser.text_field(:id => /email/).set(row[:email])
  end
end

Then("author should be on the list") do
  @authors.each do |row|
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should include row[:authorName]
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should include row[:birthDate]
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should include row[:email]
  end
end

And("click on author") do
  @authors.each do |row|
    @browser.a(:text => row[:authorName]).wait_until(&:present?).click
  end
end

Then("author should be on form") do
  @authors.each do |row|
    expect(@browser.text_field(:id => /authorName/).value).to eq(row[:authorName])
    expect(@browser.text_field(:id => /birthDate/).value).to eq(row[:birthDate])
    expect(@browser.text_field(:id => /email/).value).to eq(row[:email])
  end
end

Then("author should not be on the list") do
  @authors.each do |row|
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should_not include row[:authorName]
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should_not include row[:birthDate]
    @browser.element(:class => /mat-table/).wait_until(&:present?).text.should_not include row[:email]
  end
end