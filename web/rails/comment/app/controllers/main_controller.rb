class MainController < ApplicationController
    layout('base')

    # Create a new comment.
    def create_comment
        redirect_to(:read_comment) #unless request.post?
    end

    # Return a list of all comments.
    def read_comment
        @comments = Comment_.limit(100)
    end

    # Return a specific comment.
    def read_comment_id
        begin
            @comment = Comment_.find(params['id'])
        rescue ActiveRecord::RecordNotFound => err
            @comment = nil
            @id = params['id']
        end
    end
end
