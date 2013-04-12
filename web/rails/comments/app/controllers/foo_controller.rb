class FooController < ApplicationController
    layout('base')

    def index
        @message = 'Hello!'
        @count = 3
    end
end
