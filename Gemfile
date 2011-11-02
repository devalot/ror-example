################################################################################
source('http://rubygems.org')

################################################################################
# Mandatory gems
gem('rails', '3.1.1')
gem('sqlite3') # or your database adapter of choice
gem('json')

################################################################################
# Gems needed for the asset pipeline.  Not used in production unless
# you are going to compile assets on the fly or build cached version
# on a production machine.
group(:assets) do
  # You *must* have a JavaScript interpreter installed.  The easiest
  # one to install is The Ruby Racer (https://github.com/cowboyd/therubyracer) 
  # but there are others: https://github.com/sstephenson/execjs
  gem('therubyracer')

  # Other asset related gems
  gem('sass-rails',   '~> 3.1.4')
  gem('coffee-rails', '~> 3.1.1')
  gem('uglifier',     '>= 1.0.3')
end

################################################################################
# Other gems that we'll be using
gem('jquery-rails') # If you prefer prototype: gem('prototype-rails')
gem('bcrypt-ruby', '~> 3.0.0')  # So we can use: has_secure_password

