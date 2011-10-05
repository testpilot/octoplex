module Octoplex
  class Client
    module Root

      # Get a single user
      #
      # API:  GET /user
      #       GET /users/:login
      def user(login=nil)
        if login
          users(login)
        else
          Octoplex::Client::User.new(self, get("/user"))
        end
      end

      # GET /users/:user
      def users(login)
        Octoplex::Client::User.new(self, get("/users/#{login}"))
      end

      # # GET /user
      # # GET /user/repos
      # def user
      #   @user ||= Octoplex::API::User.current
      # end

      # GET /orgs/:org/repos
      def orgs(login)
        Octoplex::API::Organisation.find(login)
      end

      alias_method :organisations, :orgs
      alias_method :organizations, :orgs


      # GET /repos/:user/:repo/contributors
      # GET /repos/:user/:repo/languages
      # GET /repos/:user/:repo/teams
      # GET /repos/:user/:repo/branches

      # GET /repos/:user/:repo
      #
      # Accepts either a user name and repo name as 2 arguments or one.
      # Example:
      #   Octoplex.repo('ivanvanderbyl/cloudist')
      #   Octoplex.repo('ivanvanderbyl', 'cloudist')
      def repos(*user_and_repo)
        if user_and_repo.size == 2
          user = user_and_repo[0]
          repo = user_and_repo[1]
        elsif user_and_repo.first.is_a?(String) && !user_and_repo.first.index('/').nil?
          user, repo = user_and_repo.first.split('/', 2)
        else
          raise ArgumentError, "Unknown arguments: #{user_and_repo.split(', ')}"
        end
        Octoplex::Client::Repository.new(self, get("/repos/#{user}/#{repo}"))
      end

      alias_method :repo, :repos
      alias_method :repositories, :repos
      alias_method :repository, :repos

    end
  end
end
