// Add a form field for uploading a file.
function addFile() {
    document.querySelector('ul').innerHTML +=
        '<li><input name="files[]" type="file" /></li>';
}

// Remove all form fields for uploading files.
function clearFiles() {
    var files = document.querySelectorAll('ul li');
    var victim = files[files.length - 1];
    if(victim) { // victim is undefined if list len == 0
        victim.parentNode.removeChild(victim);
    }
}
