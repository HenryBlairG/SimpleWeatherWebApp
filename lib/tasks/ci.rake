# frozen_string_literal: true

if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'
  require 'scss_lint/rake_task'
  require 'bundler/audit'

  RuboCop::RakeTask.new
  SCSSLint::RakeTask.new do |t|
    t.files = Dir.glob(['app/assets/stylesheets/'])
  end

  task audit: :environment do
    sh 'bundle-audit check --update'
  end
  task brakeman: :environment do
    sh 'brakeman -z -q'
  end
  task eslint: :environment do
    sh 'npm run eslint'
  end
  task erblint: :environment do
    sh 'bundle exec erblint --lint-all'
  end
  task linters: %i[rubocop brakeman audit eslint scss_lint erblint]
  task default: %i[linters]
end
