#!/usr/bin/env groovy
#
#   get_jira_tickets
#   Tooling
#   Created by Duncan Wallace 12/08/2024
#   Copyright © 2024. Duncwa LLC.  All rights reserved

require 'httparty'
api_token = ENV["DW4WORKONLY_API_TOKEN_BASE64"]
def get_tickets(api_token)
    project_id = ENV["PROJECT_ID"]
    ticket_status = ENV["TICKET_STATUS"]
    params = {
        :site               => 'https://dw4workonly.atlassian.net/rest/api/3',
        :context_path       => ''
    }

    url = "https://dw4workonly.atlassian.net/rest/api/3/search?jql=project=DecoderThing%20AND%20status="+"BETA_READY"
    # url = "https://dw4workonly.atlassian.net/rest/api/3/issue/DT-1"
    request_payload = {
        headers: {
            "Authorization" => "Basic #{api_token}",
            "Content-Type"  => "application/json"
        }
    }
    response = HTTParty.send(:get, url, request_payload)
    puts "============================="
    puts "============================="
    puts "=============================> "
    puts response
    puts " <============================="
    puts "============================="
end

get_tickets(api_token)