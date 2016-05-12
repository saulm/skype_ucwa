require 'rest-client'
require 'net/http'
require 'httplog'

require_relative 'skype_ucwa/authentication'
require_relative 'skype_ucwa/application'
require_relative 'skype_ucwa/api_client_utils'
require_relative 'skype_ucwa/online_meetings'

class SkypeUCWA
  attr_accessor :app, :domain, :username, :password, :tokens, :client_id, :last_url, :base_url
  include Authentication
  include Application
  include APIClientUtils
  include OnlineMeetings

  def initialize(domain, username, password, client_id)
    @tokens = {}
    @domain = domain
    @username = username
    @password = password
    @client_id = client_id
    @app = application
  end
end
