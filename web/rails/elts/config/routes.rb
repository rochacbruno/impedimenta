# /
#     GET returns a home page containing a summary of information in ELTS,
#     such as which items are due back on that day.
#
# item/
#     POST creates a new item. If any arguments are invalid, the user is
#     redirected to GET item/create-form/.
#
#     GET returns a list of all items. One argument may be given: tag. If
#     tag=xyz, a list of all items who have the tag with "xyz" is returned.  tag
#     may be specified more than once, in order to narrow the search. If the tag
#     given does not exist, TODO: clarify this
#
# item/create-form/
#     GET returns a form for creating an item.
#
# item/:id/update-form/
#     GET returns a form for updating an item. If item id does not exist,
#     user is redirected to item/<id>/
Elts::Application.routes.draw do
    match('' => 'dashboard#read', :via => :get)

    match('item/create-form'     => 'item#create_form',    :via => :get)
    match('item'                 => 'item#create',         :via => :post)
    match('item'                 => 'item#read',           :via => :get)
    match('item/:id'             => 'item#id_read',        :via => :get)
    match('item/:id/update-form' => 'item#id_update_form', :via => :get)
    match('item/:id'             => 'item#id_update',      :via => :put)
    match('item/:id'             => 'item#id_delete',      :via => :delete)
end
