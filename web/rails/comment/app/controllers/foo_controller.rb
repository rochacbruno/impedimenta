class FooController < ApplicationController
    layout('base')

    # A simple landing page which displays a static message to the user.
    def index
        @message = 'Hello!'
    end

    # Allows user to enter text into a form, which is then echoed back to them.
    def echo
    end
end
