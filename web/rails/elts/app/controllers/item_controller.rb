class ItemController < ApplicationController
    layout('base')

    def create_form
        if session.has_key?(:item)
            @item = session.delete(:item)
        else
            @item = Item.new()
        end
    end

    def create
        @item = Item.new(params[:item])
        if @item.save
            redirect_to(:action => 'id_read', :id => @item.id)
        else
            session[:item] = @item
            redirect_to(:action => 'create_form')
        end
    end

    def read
        @items = Item.all
    end

    def id_read
        @item = Item.find(params[:id])
    end

    def id_update_form
    end

    def id_update
    end

    def id_delete
    end
end
