# Use <tt>rake routes<tt> to see all available routes. Remember that route
# priority is based upon order of creation. The first route to match a URL is
# applied, even if multiple routes match a given URL.
#
# Rails pushes you to create RESTful applications using the +resources+ keyword.
# Unfortunately, a single invocation of the +resources+ keyword creates _seven_
# different routes. For example, this:
#
#     resources :photos
#
# Makes the following HTTP calls available:
#
#     ========= ================ ===============================================
#     HTTP Verb Path             Description
#     ========= ================ ===============================================
#     GET       /photos          Return a list of all photos.
#     GET       /photos/new      Return HTML form for creating a new photo.
#     POST      /photos          Create a new photo.
#     GET       /photos/:id      Display a specific photo.
#     GET       /photos/:id/edit Return HTML for for editing a photo.
#     PUT       /photos/:id      Update a specific photo.
#     DELETE    /photos:id       Delete a specific photo.
#     ========= ================ ===============================================
#
# This is overkill in many cases. Thankfully, you can get a bit more surgical
# with +match+. For example, this:
#
#     match(
#         'photos' => 'photos#create',
#         :via => :post
#     )
#
# Makes the following HTTP calls available:
#
#     ========= ================ ===============================================
#     HTTP Verb Path             Description
#     ========= ================ ===============================================
#     POST      /photos          Create a new photo.
#     ========= ================ ===============================================
#
Comment::Application.routes.draw do
    match(''                =>  redirect('/comment'),  :via  =>  :get)
    match('comment'         =>  'main#create',         :via  =>  :post)
    match('comment/create_form'  =>  'main#create',    :via  =>  :get)
    match('comment'         =>  'main#read',           :via  =>  :get)
    match('comment/:id'     =>  'main#read_id',        :via  =>  :get)

    # This is a legacy wild controller route that's not recommended for RESTful
    # applications.  This route will make all actions in every controller
    # accessible via GET requests.
    #
    #     match ':controller(/:action(/:id))(.:format)'
    #
end
