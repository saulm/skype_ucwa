module APIClientUtils
  private

  def headers(resource=nil)
    h = {"Accept" => "application/json", "Content-Type" => "application/json"}
    token = @tokens.fetch(resource, "")
    h["Authorization"] = token unless token.empty?
    return h
  end

  def auth_and_retry_if_unauthorized(method, url, params=nil)
    uri = URI(url)
    resource = "#{uri.scheme}://#{uri.host}"
    begin
      rest_(method, url, headers(resource), params)
    rescue RestClient::Unauthorized
      auth(resource)
      rest_(method, url, headers(resource), params)
    end
  end

  def rest_(method, url, headers, params=nil)
    self.last_url = url
    if params.nil?
      RestClient.send(method, url, headers)
    else
      RestClient.send(method, url, params, headers)
    end
  end
end
