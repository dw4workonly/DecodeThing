require 'httparty'

module Fastlane
  module Actions
    module SharedValues
      JIRA_TICKETS_LIST_CUSTOM_VALUE = :JIRA_TICKETS_LIST_CUSTOM_VALUE
    end

    class JiraTicketsListAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
     

        api_token = ENV["DW4WORKONLY_API_TOKEN_BASE64"]
       
        project_id = ENV["PROJECT_ID"]
        ticket_status = ENV["TICKET_STATUS"]

        UI.message("Retrieve JiraTickets in status #{ticket_status} from project #{project_id}.")
        options = {
            :site               => 'https://dw4workonly.atlassian.net/rest/api/3',
            :context_path       => ''
        }

        url = "https://dw4workonly.atlassian.net/rest/api/3/search?jql=project=#{project_id}%20AND%20status="+"#{ticket_status}"
        request_payload = {
            headers: {
                "Authorization" => "Basic #{api_token}",
                "Content-Type"  => "application/json"
            }
        }
        response = HTTParty.send(:get, url, request_payload)

        file_dir = "fastlane/temp_output/tickets.json"
        File.open(file_dir, 'w') { |file| file.write(response.json) }
        UI.message("Completed:  Tickets saved to file #{file_dir}.")
        # Actions.lane_context[SharedValues::JIRA_TICKETS_LIST_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'A short description with <= 80 characters of what this action does'
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        'You can use this action to do cool things...'
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       # The name of the environment variable
                                       env_name: 'FL_JIRA_TICKETS_LIST_API_TOKEN',
                                       # a short description of this parameter
                                       description: 'API Token for JiraTicketsListAction',
                                       verify_block: proc do |value|
                                         unless value && !value.empty?
                                           UI.user_error!("No API token for JiraTicketsListAction given, pass using `api_token: 'token'`")
                                         end
                                         # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: 'FL_JIRA_TICKETS_LIST_DEVELOPMENT',
                                       description: 'Create a development certificate instead of a distribution one',
                                       # true: verifies the input is a string, false: every kind of value
                                       is_string: false,
                                       # the default value if the user didn't provide one
                                       default_value: false)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['JIRA_TICKETS_LIST_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ['Your GitHub/Twitter Name']
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
