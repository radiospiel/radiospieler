source "https://rubygems.org"

# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem "rake"
gem "htmlentities"
gem "simple_cache_rs"
gem "nokogiri"
gem "addressable"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development, :test do
  gem "bundler"
  
  # vcr stuff: this needs psych or else will crash
  gem "vcr"
  gem "webmock"
  gem "psych"
  
  gem 'simplecov', :require => false
  # gem "ruby-debug19"
  # gem "simple_cov"
  gem "test-unit"
end
