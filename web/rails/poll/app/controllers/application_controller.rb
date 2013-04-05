# All other controllers in this directory inherit from +ApplicationController+.
# Filters added here apply to all child classes, and all methods here are
# available to all child classes.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details

    # Scrub sensitive parameters from your log
    # filter_parameter_logging :password
end
