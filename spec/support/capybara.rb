require 'action_dispatch/system_test_case'
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end

Capybara.register_driver :selenium_chrome_headless do |app|
  Capybara::Selenium::Driver.new(app, 
    browser: :chrome,
    desired_capabilities: {
      "chromeOptions" => {
        "args" => %w{ window-size=1024,768 }
      }
    }
  )
end
Capybara.server = :puma