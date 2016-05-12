module Application
  private

  def application
    r = RestClient.get "http://lyncdiscover.#{@domain}/", {:accept => :json}
    r = JSON.parse(r)

    unless r["_links"].has_key? "user"
      redirect_url = r["_links"]["redirect"]["href"]
      r = JSON.parse(RestClient.get redirect_url)
    end

    users_url = r["_links"]["user"]["href"]
    r = auth_and_retry_if_unauthorized(:get, users_url)

    apps_url = JSON.parse(r.body)["_links"]["applications"]["href"]

    body = {Culture: 'en-us' , EndpointId: "client_id", UserAgent: "Ruby RestClient"}
    r = auth_and_retry_if_unauthorized(:post, apps_url, body.to_json)
    uri = URI(self.last_url)
    self.base_url = "#{uri.scheme}://#{uri.host}"

    JSON.parse(r.body)
  end
end
