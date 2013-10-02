// Make all `section` elements on the page reveal themselves with a "slide"
// animation over 400 ms.

function reveal() {
    var sections = $('section');
    sections.each(function() {
        $(this).css('display', 'none');
    });
    sections.each(function() {
        $(this).slideDown('slow');
    });
}

$(document).ready(function() {
    reveal();
})
