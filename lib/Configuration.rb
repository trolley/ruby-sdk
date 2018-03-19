class Configuration
  def initialize(publicKey, privateKey, enviroment)
    @publicKey = publicKey
    @privateKey = privateKey
    @apiBase = set_enviroment(enviroment)
  end

  def set_enviroment(apiBase)
    case apiBase
    when 'production'
      'https://api.paymentrails.com'
    when 'development'
      'http://api.railz.io'
    when 'integration'
      'http://api.local.dev:3000'
    else
      'https://api.paymentrails.com'
    end
  end

  attr_reader :publicKey

  attr_writer :publicKey

  attr_reader :privateKey

  attr_writer :privateKey

  attr_reader :apiBase
end
