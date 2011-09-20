require 'rest_client'
require 'uri'
require 'account'

Account.class_eval do
  unless Rails.env == 'test'
    if RollcallEjabberd::MODE == 'rest'
      require 'ejabberd_rest'
      include RollcallEjabberd::EjabberdRest
      Rails.logger.debug "Loaded Ejabberd REST connector for domain #{RollcallEjabberd::DOMAIN}."
    else
      require 'ejabberd_cli'
      include RollcallEjabberd::EjabberdCli
      Rails.logger.debug "Loaded Ejabberd CLI connector for domain #{RollcallEjabberd::DOMAIN}."
    end
  
    before_validation :create_account_in_ejabberd, :on => :create, :if => proc{ !login.blank? && !password.blank? }
    before_validation :update_account_in_ejabberd, :on => :update, :if => proc{ !login.blank? && !password.blank? }
    before_destroy :delete_account_in_ejabberd
  
    validate do
      if !@ejabberd_error && !ejabberd_account_exists?
        @ejabberd_error = "#{login}@#{RollcallEjabberd::DOMAIN} does not exist on the ejabbberd server!"
      end
      
      self.errors[:base] << @ejabberd_error if @ejabberd_error
    end
  end
end