module Authentication
  private

  def auth(resource)
    uri = URI("https://login.windows.net/#{domain.split('.').first}.onmicrosoft.com/oauth2/token")
    params = {:resource=>resource, :client_id=>@client_id, :grant_type=>"password",
              :username=>@username, :password=>@password, :scope=>"openid"}
    r = Net::HTTP.post_form(uri, params)
    @tokens[resource] = "Bearer "+JSON.parse(r.body)["access_token"]
  end
end
