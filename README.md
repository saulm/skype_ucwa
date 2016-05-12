# Ruby Skype UCWA API client

This is a Skype UCWA API client implemented in ruby.

It currently supports a basic flow to generate an application resource, and create online meetings

---

## Usage

Add the following to your Gemfile:

```
gem "skype_ucwa", :git => "git://github.com/saulm/skype_ucwa.git"
```

Then:

```
bundle install
```

A client can be created as follows:

```
client = SkypeUCWA.new("domain.com", "email@email.com", "password", "client_id")
```

It's important to notice that the client_id is an application created on your azure instance, the email and password are users of that domain.

The only call supported from the UCWA API is the Schedule Online Meetings call, used as follow:

```
response = client.schedule_meeting("Meeting Subject")
```
