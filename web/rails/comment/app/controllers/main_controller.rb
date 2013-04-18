class MainController < ApplicationController
    layout('base')

    # Create a new comment.
    def create
        redirect_to(:read) #unless request.post?
    end

    # Return a list of all comments.
    def read
        @comments = Comment_.limit(100)
    end
end
