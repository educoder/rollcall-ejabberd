module RollcallEjabberd::EjabberdCli
  def create_account_in_ejabberd
    unless @ejabberd_account_created
      command = %{register "#{self.login}" "#{RollcallEjabberd::DOMAIN}" "#{self.encrypted_password}"}
      ejabberd_cli_request(command)
      @ejabberd_account_created = true unless @ejabberd_error
    end
  end

  def update_account_in_ejabberd
    unless @ejabberd_account_created
      # this requires the 'mod_admin_extra' module... lets unregister and re-register instead
      #command = %{change_password "#{self.login}" "#{RollcallEjabberd::DOMAIN}" "#{self.encrypted_password}"}
     
      delete_account_in_ejabberd
      unless @ejabberd_error
        create_account_in_ejabberd
        @ejabberd_account_updated = true unless @ejabberd_error
      end
    end
  end
  
  def delete_account_in_ejabberd
    command = %{unregister "#{self.login}" "#{RollcallEjabberd::DOMAIN}"}
    ejabberd_cli_request(command)
  end

  def ejabberd_cli_request(command)
    ctl = RollcallEjabberd::CTL

    out = `#{ctl} #{command} 2>&1`
    res = $?.to_i
    
    
    Rails.logger.debug "RollcallEjabberd::EjabberdCli.ejabberd_cli_request: #{out}"
    
    if res > 0
      @ejabberd_error = "Ejabberd command \n\n\t`#{command}`\n\nwas unssuccessful because:\n\n\t#{out}"
    end
    
    return out
  end
end