class ItemController < ApplicationController
    layout('base')

    # Give user a form for creating a new item.
    def create_form
        if session.has_key?(:item)
            @item = session.delete(:item)
        else
            @item = Item.new()
        end
    end

    # Create a new item.
    def create
        @item = Item.new(params[:item])
        if @item.save
            redirect_to(:action => 'id_read', :id => @item.id)
        else
            session[:item] = @item
            redirect_to(:action => 'create_form')
        end
    end

    # Display a list of existing items.
    def read
        @items = Item.all
    end

    # Display details about a specific item.
    def id_read
        @item = Item.find(params[:id])
    end

    # Give user a form for updating a specific item.
    def id_update_form
        @item = Item.find(params[:id])
    end

    # Update a specific item.
    def id_update
        @item = Item.find(params[:id])
        if @item.update_attributes(params[:item])
            redirect_to(:action => 'id_read', :id => @item.id)
        else
            redirect_to(:action => 'id_update_form', :id => params[:id])
        end
    end

    # Delete a specific item.
    def id_delete
        Item.find(params[:id]).destroy
        redirect_to(:action => 'read')
    end

    def id_update_delete
        if params.has_key?(:method)
            if 'put' == params[:method]
                id_update
            elsif 'delete' == params[:method]
                id_delete
            else
                redirect_to(:action => 'id_read', :id => params[:id])
            end
        else
            redirect_to(:action => 'id_read', :id => params[:id])
        end
    end
end
