require 'skype_ucwa'

class TestSkypeUCWA < MiniTest::Unit::TestCase
  def test_initialize_generates_application
    discover_response = '{"_links":{"self":{"href":"https://webdir0b.online.lync.com/Autodiscover/AutodiscoverService.svc/root?originalDomain=domain.com"},"xframe":{"href":"https://webdir1A.online.lync.com/Autodiscover/AutodiscoverService.svc/root/xframe"},"redirect":{"href":"https://webdir1A.online.lync.com/Autodiscover/AutodiscoverService.svc/root?originalDomain=domain.com"}}}'
    discover_response2 = '{"_links":{"self":{"href":"https://webdir1a.online.lync.com/Autodiscover/AutodiscoverService.svc/root?originalDomain=domain.com"},"user":{"href":"https://webdir1a.online.lync.com/Autodiscover/AutodiscoverService.svc/root/oauth/user?originalDomain=domain.com"},"xframe":{"href":"https://webdir1a.online.lync.com/Autodiscover/XFrame/XFrame.html"}}}'
    discover_response3 = 'Unauthorized'
    login_response = '{"token_type":"Bearer","scope":"Contacts.ReadWrite Conversations.Initiate Meetings.ReadWrite","expires_in":"3599","expires_on":"1463022255","not_before":"1463018355","resource":"https://webdir1a.online.lync.com","access_token":"12345678"}'
    discover_response4 = '{"_links":{"self":{"href":"https://webpoolbn11a01.infra.lync.com/Autodiscover/AutodiscoverService.svc/root/oauth/user"},"applications":{"href":"https://webpoolbn11a01.infra.lync.com/ucwa/oauth/v1/applications","revision":"2"},"xframe":{"href":"https://webpoolbn11a01.infra.lync.com/Autodiscover/XFrame/XFrame.html"}}}'
    login_response2 = '{"token_type":"Bearer","scope":"Contacts.ReadWrite Conversations.Initiate Meetings.ReadWrite","expires_in":"3599","expires_on":"1463022257","not_before":"1463018357","resource":"https://webpoolbn11a07.infra.lync.com","access_token":"87654321"}'
    application_response = '{"culture":"en-us","userAgent":"Ruby RestClient","type":"Browser","endpointId":"client_id","_links":{"self":{"href":"/ucwa/oauth/v1/applications/102150809602"},"policies":{"href":"/ucwa/oauth/v1/applications/102150809602/policies"},"batch":{"href":"/ucwa/oauth/v1/applications/102150809602/batch"},"events":{"href":"/ucwa/oauth/v1/applications/102150809602/events?ack=1\u0026key=c2lwOnNtb25jYWRhQG1kbGl2ZS5jb20%3D-102150809602-"}},"_embedded":{"people":{"_links":{"self":{"href":"/ucwa/oauth/v1/applications/102150809602/people"},"presenceSubscriptions":{"href":"/ucwa/oauth/v1/applications/102150809602/people/presenceSubscriptions"},"subscribedContacts":{"href":"/ucwa/oauth/v1/applications/102150809602/people/subscribedContacts"},"presenceSubscriptionMemberships":{"href":"/ucwa/oauth/v1/applications/102150809602/people/presenceSubscriptionMemberships"},"myGroups":{"href":"/ucwa/oauth/v1/applications/102150809602/people/groups","revision":"2"},"myGroupMemberships":{"href":"/ucwa/oauth/v1/applications/102150809602/people/groupMemberships","revision":"2"},"myContacts":{"href":"/ucwa/oauth/v1/applications/102150809602/people/contacts"},"myPrivacyRelationships":{"href":"/ucwa/oauth/v1/applications/102150809602/people/privacyRelationships"},"myContactsAndGroupsSubscription":{"href":"/ucwa/oauth/v1/applications/102150809602/people/contactsAndGroupsSubscription"},"search":{"href":"/ucwa/oauth/v1/applications/102150809602/people/search","revision":"2"}},"rel":"people"},"onlineMeetings":{"_links":{"self":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings"},"myOnlineMeetings":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/myOnlineMeetings"},"onlineMeetingDefaultValues":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/defaultValues"},"onlineMeetingEligibleValues":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/eligibleValues"},"onlineMeetingInvitationCustomization":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/customInvitation"},"onlineMeetingPolicies":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/policies"},"phoneDialInInformation":{"href":"/ucwa/oauth/v1/applications/102150809602/onlineMeetings/phoneDialInInformation"}},"rel":"onlineMeetings"},"communication":{"1d5be7a8-a8f7-47f1-9663-3d129f0a99ca":"please pass this in a PUT request","supportedModalities":[],"supportedMessageFormats":["Plain"],"audioPreference":"PhoneAudio","conversationHistory":"Disabled","_links":{"self":{"href":"/ucwa/oauth/v1/applications/102150809602/communication"},"mediaRelayAccessToken":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/mediaRelayAccessToken"},"mediaPolicies":{"href":"/ucwa/oauth/v1/applications/102150809602/mediaPolicies"},"conversations":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/conversations?filter=active"},"startMessaging":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/messagingInvitations","revision":"2"},"startAudioVideo":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/audioVideoInvitations","revision":"2"},"startOnlineMeeting":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/onlineMeetingInvitations?onlineMeetingUri=adhoc"},"joinOnlineMeeting":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/onlineMeetingInvitations"},"missedItems":{"href":"/ucwa/oauth/v1/applications/102150809602/communication/missedItems"}},"rel":"communication","etag":"3510937197"}},"rel":"application","etag":"680531847","expires":"\/Date(1463047458421)\/"}'

    discover_1 = stub_request(:get, "http://lyncdiscover.domain.com/").
      with(:headers => {'Accept'=>'application/json', 'Host'=>'lyncdiscover.domain.com'}).
      to_return(:status => 200, :body => discover_response, :headers => {})

    discover_2 = stub_request(:get, "https://webdir1a.online.lync.com/Autodiscover/AutodiscoverService.svc/root?originalDomain=domain.com").
      with(:headers => {'Accept'=>'*/*', 'Host'=>'webdir1A.online.lync.com'}).
      to_return(:status => 200, :body => discover_response2, :headers => {})

    discover_3 = stub_request(:get, "https://webdir1a.online.lync.com/Autodiscover/AutodiscoverService.svc/root/oauth/user?originalDomain=domain.com").
      with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json',
                        'Host'=>'webdir1a.online.lync.com'}).
      to_return(:status => 401, :body => discover_response3, :headers => {})

    login_1 = stub_request(:post, "https://login.windows.net/domain.onmicrosoft.com/oauth2/token").
      with(:body => {"client_id"=>"client_id", "grant_type"=>"password", "password"=>"password",
                     "resource"=>"https://webdir1a.online.lync.com", "scope"=>"openid",
                     "username"=>"email@email.com"},
           :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded',
                        'Host'=>'login.windows.net', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => login_response, :headers => {})

    discover_4 = stub_request(:get, "https://webdir1a.online.lync.com/Autodiscover/AutodiscoverService.svc/root/oauth/user?originalDomain=domain.com").
      with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json',
                        'Host'=>'webdir1a.online.lync.com', 'Authorization' => 'Bearer 12345678'}).
      to_return(:status => 200, :body => discover_response4, :headers => {})

    application_1 = stub_request(:post, "https://webpoolbn11a01.infra.lync.com/ucwa/oauth/v1/applications").
      with(:body => "{\"Culture\":\"en-us\",\"EndpointId\":\"client_id\",\"UserAgent\":\"Ruby RestClient\"}",
           :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json',
                        'Host'=>'webpoolbn11a01.infra.lync.com'}).
      to_return(:status => 401, :body => "", :headers => {})

    login_2 = stub_request(:post, "https://login.windows.net/domain.onmicrosoft.com/oauth2/token").
              with(:body => {"client_id"=>"client_id", "grant_type"=>"password", "password"=>"password",
                             "resource"=>"https://webpoolbn11a01.infra.lync.com",
                             "scope"=>"openid", "username"=>"email@email.com"},
                   :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded',
                                'Host'=>'login.windows.net', 'User-Agent'=>'Ruby'}).
              to_return(:status => 200, :body => login_response2, :headers => {})

    application_2 = stub_request(:post, "https://webpoolbn11a01.infra.lync.com/ucwa/oauth/v1/applications").
      with(:body => "{\"Culture\":\"en-us\",\"EndpointId\":\"client_id\",\"UserAgent\":\"Ruby RestClient\"}",
           :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json',
                        'Host'=>'webpoolbn11a01.infra.lync.com', 'Authorization' => 'Bearer 87654321'}).
      to_return(:status => 200, :body => application_response, :headers => {})

    client = SkypeUCWA.new("domain.com", "email@email.com", "password", "client_id")

    assert_requested(discover_1)
    assert_requested(discover_2)
    assert_requested(discover_3, times: 2)
    assert_requested(login_1)
    assert_requested(discover_4)
    assert_requested(application_1, times: 2)
    assert_requested(login_2)
    assert_requested(application_2)
  end
end
