module Octoplex
  class Client
    class Repository < Base

      attr_reader :owner

      def initialize(owner, client, data)
        super(client, data)
        @owner = owner
      end



      # GET /repos/:user/:repo

      # GET /repos/:user/:repo/contributors
      def contributors

      end

      # GET /repos/:user/:repo/languages
      def languages

      end

      # GET /repos/:user/:repo/teams
      def teams

      end

      # GET /repos/:user/:repo/branches
      def branches

      end

      # Commits:
      # GET /repos/:user/:repo/commits
      # GET /repos/:user/:repo/commits/:sha
      # GET /repos/:user/:repo/comments
      # GET /repos/:user/:repo/commits/:sha/comments
      # POST /repos/:user/:repo/commits/:sha/comments
      # GET /repos/:user/:repo/comments/:id
      # PATCH /repos/:user/:repo/comments/:id
      # GET /repos/:user/:repo/compare/:base...:head

    end
  end
end