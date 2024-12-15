#!/usr/bin/env groovy
#
#   get_jira_tickets
#   Tooling
#   Created by Duncan Wallace 12/08/2024
#   Copyright © 2024. Duncwa LLC.  All rights reserved

require 'httparty'
api_token = ENV["JIRA_API_TOKEN"]
def get_tickets(api_token)
  project_id = ENV["PROJECT_ID"]
  ticket_status = ENV["TICKET_STATUS"]
  params = {
    :site               => 'https://dw4workonly.atlassian.net/rest/api/3',
    :context_path       => ''
  }

  url = "/search?jql=project%20=%20"+"BETA_READY"

  # project.issues.each do |issue|
  #   puts "#{issue.id} - #{issue.summary} - #{issue.status}"


  request_payload = {
      query: params, # URL Parameters
      headers: {
        'Authorization' => 'Basic #{api_token}',
        'User'          => 'dw4workonly@gmail.com',
        'Content-Type'  => 'application/json'
      }
  }
  response = HTTParty.send(:get, url, request_payload)
  puts response
end

get_tickets(api_token)