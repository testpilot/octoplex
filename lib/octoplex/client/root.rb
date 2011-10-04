module Octoplex
  class Client
    module Root

      # GET /users/:user
      # GET /users/:user/repos
      def users(login)
        (@users ||= {})[login] ||= Octoplex::API::User.new(self, get("/users/#{login}"))
      end

      # GET /user
      # GET /user/repos
      def user
        @user ||= Octoplex::API::User.current
      end

      # GET /orgs/:org/repos
      def orgs(login)
        Octoplex::API::Organisation.find(login)
      end

      alias_method :organisations, :orgs
      alias_method :organizations, :orgs

      # GET /repos/:user/:repo
      # GET /repos/:user/:repo/contributors
      # GET /repos/:user/:repo/languages
      # GET /repos/:user/:repo/teams
      # GET /repos/:user/:repo/branches

      def repos(user, repo)
        (@repos ||= {})[user] ||= Octoplex::API::Repository.new(user, self, get("/repos/#{user}"))
      end

    end
  end
end
