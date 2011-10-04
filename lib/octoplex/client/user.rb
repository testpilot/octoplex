module Octoplex
  class Client
    class Users < Base



      # class << self
      #   def find(client, login)
      #     new(client.get("/users/#{login}"))
      #   end
      #
      #   def current(client)
      #     new(client.get("/user"))
      #   end
      # end

      # GET /users/:user/[repos]
      # def repos
      #   Octoplex::API::Repository.all
      #   # get("/user/#{login}/repos")
      # end

      def repos
        Octoplex::API::Repository.new(login, self, get("/users/repos"))
      end

    end
  end
end
