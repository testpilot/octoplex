module Octoplex
  module API
    class Base < Hashr

      attr_reader :client

      def initialize(client, data)
        @client = client

        super(data)
      end

    end
  end
end
