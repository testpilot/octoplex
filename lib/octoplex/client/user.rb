module Octoplex
  class Client
    class User < Base

      # GET /repos/:user/:repo
      def repos(repo)
        Octoplex::Client::Repository.new(client, "/repos/#{login}/#{repo}")
      end

    end
  end
end
