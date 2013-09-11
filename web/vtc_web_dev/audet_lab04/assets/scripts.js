ANSWERS = new Array('Edgar Allan Poe', 'Karl Marx');

/* Check whether `name` is the correct answer or not.
 *
 * `name` is a string such as 'Edgar Allan Poe' or 'Buster Keaton'.
 *
 * If `name` is in `ANSWERS`, inform the user that their choice is incorrect.
 * Otherwise, inform the user that their choice is incorrect.
 */
function checkAnswer(name) {
    // Remove class 'incorrect' from all choices (`p.choices img` elements)..
    var choices = document.querySelectorAll('p.choices img');
    for(var i = 0; i < choices.length; i++) {
        choices[i].classList.remove('correct');
        choices[i].classList.remove('incorrect');
    }

    // Add class 'correct' or 'incorrect' to user's choice and give textual
    // feedback to the user.
    var choice = document.querySelector('p.choices img[alt="' + name + '"]');
    var feedback = document.getElementById('feedback');
    if(ANSWERS.indexOf(name) == -1) {
        // incorrect choice
        choice.classList.add('incorrect');
        feedback.innerHTML = name + ' is incorrect';
        feedback.classList.remove('correct');
        feedback.classList.add('incorrect');
    } else {
        // correct choice
        choice.classList.add('correct');
        feedback.innerHTML = name + ' is correct';
        feedback.classList.remove('incorrect');
        feedback.classList.add('correct');
    }
}
