module Trolley
    class TrolleyError < ::StandardError
        attr_reader :validation_errors

        def initialize(message, validation_errors)
            super(message)
            @validation_errors = validation_errors
        end
    end

    class AuthenticationError < TrolleyError; end

    class AuthorizationError < TrolleyError; end

    class DownForMaintenanceError < TrolleyError; end

    class NotFoundError < TrolleyError; end

    class ServerError < TrolleyError; end

    class TooManyRequestsError < TrolleyError; end

    class UnexpectedError < TrolleyError; end

    class MalformedRequestError < TrolleyError; end
end
