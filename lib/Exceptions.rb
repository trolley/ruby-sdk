    class PaymentRailsError < ::StandardError; end
  
    class AuthenticationError < PaymentRailsError; end
  
    class AuthorizationError < PaymentRailsError; end
  
    class DownForMaintenanceError < PaymentRailsError; end
  
    class NotFoundError < PaymentRailsError; end
  
    class ServerError < PaymentRailsError; end
  
    class TooManyRequestsError < PaymentRailsError; end
  
    class UnexpectedError < PaymentRailsError; end

    class MalformedException < PaymentRailsError; end