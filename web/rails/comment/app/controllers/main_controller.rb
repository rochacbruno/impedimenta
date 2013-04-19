class MainController < ApplicationController
    layout('base')

    # Either return a form for creating a new comment or create a new comment.
    def create
        if request.get?
            # return a form for creating a new comment
            @comment = Comment_.new
        elsif request.post?
            # if user clicked 'Submit'
                # create new comment
                # if comment is valid
                    # save it
                # else
                    # allow user to edit form again
            # else
                # redirect_to(:action => :read)
            redirect_to(:action => :read)
        else
            redirect_to(:action => :read)
        end
    end

    # Return a list of all comments.
    def read
        @comments = Comment_.limit(100)
    end

    # Return a specific comment.
    def read_id
        @id = params['id']
        begin
            @comment = Comment_.find(@id)
        rescue ActiveRecord::RecordNotFound => err
            @comment = nil
        end
    end
end
