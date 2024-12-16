require 'httparty'

module Fastlane
  module Actions
    module SharedValues
    end

    class CreateRetrieveDisplayTagsAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
     

        api_token = ENV["GITHUB_PAT_TOKEN"]
       
        repository_url = "https://api.github.com/repos/dw4workonly/DecoderThing/tags/protection"

        UI.message("Create Retrieve Display Tags from repository #{repository_url}.")
  
        sh("""git describe --tags `git rev-list --tags --max-count=1` > fastlane/temp/tags.txt""")
  
        #sh("curl -L -H", "Accept: application/vnd.github+json", "-H 'Authorization: Bearer $GITHUB_PAT_TOKEN'",  "-H 'X-GitHub-Api-Version: 2022-11-28'", "https://api.github.com/repos/dw4workonly/DecoderThing/tags")
        # url = repository_url
        # request_payload = {
        #     headers: {
        #         "Authorization" => "Basic #{api_token}",
        #         "Content-Type"  => "application/json"
        #     }
        # }
        # response = HTTParty.send(:get, url, request_payload)

        # file_dir = "fastlane/temp/tags.json"
        # File.open(file_dir, 'w') { |file| file.write(response.parsed_response) }
        # UI.message("Completed:  Tickets saved to file #{file_dir}.")
        # Actions.lane_context[SharedValues::CURRENT_TAG_CUSTOM_VALUE] = "my_val"
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
                                       env_name: 'GITHUB_API_TOKEN',
                                       # a short description of this parameter
                                       description: 'API Token for Github API',
                                       verify_block: proc do |value|
                                         unless value && !value.empty?
                                           UI.user_error!("No API token for Github given, pass using `api_token: 'token'`")
                                         end
                                         # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: 'GITHUB_API_TOKEN_DEVELOPMENT',
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
          ['CURRENT_TAG_CUSTOM_VALUE', 'A description of what this value contains']
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
