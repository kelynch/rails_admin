require 'font-awesome-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'kaminari'
require 'nested_form'
require 'rack-pjax'
require 'rails'
require 'rails_admin'
require 'remotipart'

module RailsAdmin
  class Engine < Rails::Engine
    isolate_namespace RailsAdmin

    config.action_dispatch.rescue_responses.merge!('RailsAdmin::ActionNotAllowed' => :forbidden)

    initializer 'RailsAdmin precompile hook', group: :all do |app|
      app.config.assets.precompile += %W(
        rails_admin/rails_admin.js
        rails_admin/rails_admin.css
        rails_admin/jquery.colorpicker.js
        rails_admin/jquery.colorpicker.css
        #{"rails_admin/themes/#{ENV['RAILS_ADMIN_THEME']}/ui.js" if ENV['RAILS_ADMIN_THEME'].present?}
      )
    end

    initializer 'RailsAdmin pjax hook' do |app|
      app.config.middleware.use Rack::Pjax
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '../tasks/*.rake')].each { |f| load f }
    end
  end
end
