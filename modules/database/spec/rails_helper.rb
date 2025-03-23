# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../test/dummy/config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
# Uncomment the line below in case you have `--require rails_helper` in the `.rspec` file
# that will avoid rails generators crashing because migrations haven't been run yet
# return unless Rails.env.test?
require 'rspec/rails'
require 'capybara/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails uses metadata to mix in different behaviours to your tests,
  # for example enabling you to call `get` and `post` in request specs. e.g.:
  #
  #     RSpec.describe UsersController, type: :request do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/7-1/rspec-rails
  #
  # You can also this infer these behaviours automatically by location, e.g.
  # /spec/models would pull in the same behaviour as `type: :model` but this
  # behaviour is considered legacy and will be removed in a future version.
  #
  # To enable this behaviour uncomment the line below.
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  config.filter_gems_from_backtrace("rspec", "rspec-core")

  feature_module = Module.new do
    def visit!(path)
      visit(path)
      expect(current_path).to eq(path)
      expect(status_code).to eq(200)
    end

    def table_hash(css = "table")
      rows = find(css).find_all("tr")

      keys = rows[0].find_all("th").map(&:text)
      records = rows[1..-1].map { _1.find_all("td").map(&:text) }

      records.map { |row| keys.zip(row).to_h }
    end

    # TODO make a better spec/helper file system
    def create_client(name)
      email = "#{name}@localhost".downcase

      visit!('/database/clients/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      click_button

      expect(current_path).to match(/clients\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
    end

    def create_provider(name)
      email = "#{name}@localhost".downcase

      visit!('/database/providers/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      click_button

      expect(current_path).to match(/providers\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
    end

    def associate_client_to_providers(client, sub_providers)
      visit!('/database/clients')

      click_on(client)

      click_on('Edit')

      sub_providers.each do |provider|
        check(provider)
      end

      click_button

      expect(current_path).to match(/clients\/\d+\z/)

      expect(table_hash.map{|row| row['Name']}.sort).to eq(sub_providers.sort)

      # Check that all subproviders are visible
      sub_providers.each do |provider|
        click_on provider
        expect(current_path).to match(/clients\/\d+\/providers\/\d+\z/)
        click_on client
      end
    end
  end
  config.include(feature_module, type: :feature)
end
