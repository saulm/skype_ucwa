module OnlineMeetings
  def schedule_meeting(subject)
    my_online_meetings_url = @app["_embedded"]["onlineMeetings"]["_links"]["myOnlineMeetings"]["href"]

    body = {accessLevel: "Everyone", subject: subject}

    url = self.base_url+my_online_meetings_url
    r = RestClient.post url, body.to_json,  headers(self.base_url)
    return JSON.parse(r.body)
  end
end
