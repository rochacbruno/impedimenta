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
# Produces the following:
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
#         'photos' => 'photos#index',
#         :via => :get
#     )
#
# Produces the following:
#
#     ========= ================ ===============================================
#     HTTP Verb Path             Description
#     ========= ================ ===============================================
#     GET       /photos          Return a list of all photos.
#     ========= ================ ===============================================
#
Comment::Application.routes.draw do
    root :to => 'foo#index'

    # This is a legacy wild controller route that's not recommended for RESTful
    # applications.  This route will make all actions in every controller
    # accessible via GET requests.
    #
    #     match ':controller(/:action(/:id))(.:format)'
    #
end
