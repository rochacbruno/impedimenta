// Toggle the visibility of page elements.
//
// When pressed, `#control` causes the `#toggle` page element to either hide or
// become visible.

function toggle_visibility() {
    var toggle = $('#toggle');
    var control = $('#control');
    if(toggle.hasClass('hidden')) {
        toggle.removeClass('hidden');
        control.text("Visible \u25BD");
    } else {
        toggle.addClass('hidden');
        control.text('Hidden \u25B7');
    }
}

$(document).ready(function() {
    $('#control').bind('click', toggle_visibility);
})
