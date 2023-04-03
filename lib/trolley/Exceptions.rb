module Trolley
    class TrolleyError < ::StandardError; end

    class AuthenticationError < TrolleyError; end

    class AuthorizationError < TrolleyError; end

    class DownForMaintenanceError < TrolleyError; end

    class NotFoundError < TrolleyError; end

    class ServerError < TrolleyError; end

    class TooManyRequestsError < TrolleyError; end

    class UnexpectedError < TrolleyError; end

    class MalformedRequestError < TrolleyError; end
end
