module RollcallEjabberd
  class Railtie < Rails::Railtie
    config.ejabberd = ActiveSupport::OrderedOptions.new

    initializer 'ejabberd.initialize' do |app|
      if config.ejabberd.mod_rest_url
        RollcallEjabberd::MOD_REST_URL = config.ejabberd.mod_rest_url

        require 'account_callbacks'
      end
    end
  end
end