module RollcallEjabberd
  class Railtie < Rails::Railtie
    config.ejabberd = ActiveSupport::OrderedOptions.new

    initializer 'ejabberd.initialize' do |app|
      if config.ejabberd.mod_rest_url
        RollcallEjabberd::MODE = 'rest'
        RollcallEjabberd::MOD_REST_URL = config.ejabberd.mod_rest_url
      else
        RollcallEjabberd::MODE = 'cli'
        
        if config.ejabberd.ctl_path
          RollcallEjabberd::CTL = config.ejabberd.ctl_path
        else
          RollcallEjabberd::CTL = 'ejabberdctl'
        end
      end
      
      if config.ejabberd.domain
        RollcallEjabberd::DOMAIN = config.ejabberd.domain
      else
        RollcallEjabberd::DOMAIN = 'localhost'
      end
      
      require 'account_callbacks'
    end
    
  end
end