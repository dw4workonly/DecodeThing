require 'octokit'
require 'json'

module Fastlane
  module Actions
    module SharedValues
    end

    class GithubPullRequestsListAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
     

        api_token = ENV["GITHUB_PAT_TOKEN"]
        repo_name = ENV["REPOSITORY_NAME"]
        pr_status = "OPEN"

        UI.message("Retrieve PullRequests in status #{pr_status} from repository #{repo_name}.")
        client = Octokit::Client.new(access_token: api_token)
        response = client.pull_requests(repo_name, :state => 'open')
        file_dir = "fastlane/temp/pullrequests.json"
        File.open(file_dir, 'w') { |file| file.write(response) }
        UI.message("Completed:  Pull Requests saved to file #{file_dir}.")
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
                                       env_name: 'FL_PULL_REQUESTS_LIST_API_TOKEN',
                                       # a short description of this parameter
                                       description: 'API Token for PullRequestsListAction',
                                       verify_block: proc do |value|
                                         unless value && !value.empty?
                                           UI.user_error!("No API token for PullRequestsListAction given, pass using `api_token: 'token'`")
                                         end
                                         # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: 'FL_PULL_REQUESTS_LIST_DEVELOPMENT',
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
          ['PULL_REQUESTS_LIST_CUSTOM_VALUE', 'A description of what this value contains']
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