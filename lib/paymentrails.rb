class Paymentrails
  def Gateway
    load 'Gateway.rb'
    return Gateway
  end
  
  def Configuration
    load 'Configuration.rb'
    return Configuration
  end
end