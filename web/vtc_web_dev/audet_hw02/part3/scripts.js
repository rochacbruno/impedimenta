// Draw a grid on an arbitrary <canvas> element.
//
// From "HTML5: Up and Running", by Mark Pilgrim:
//
//     Q: Why did you start x and y at 0.5? Why not 0?
//
//     A: Imagine each pixel as a large square. The whole-number coordinates (0,
//     1, 2...) are the edges of the squares. If you draw a one-unit-wide line
//     between whole-number coordinates, it will overlap opposite sides of the
//     pixel square, and the resulting line will be drawn two pixels wide. To
//     draw a line that is only one pixel wide, you need to shift the
//     coordinates by 0.5 perpendicular to the line's direction.
//
function drawGridOnCanvas() {
    // Find an arbitrary <canvas> element and get a 2d context.
    var canvas = document.querySelectorAll('canvas')[0];
    var context = canvas.getContext('2d');

    // Define some useful coordinates.
    var north = 0.5;
    var east = canvas.width - 0.5;
    var south = canvas.height - 0.5;
    var west = 0.5;

    // Draw a grid on the context.
    var block_size = 20;
    for(var x = west; x <= east; x += block_size) {
        context.moveTo(x, north);
        context.lineTo(x, south);
    }
    for(var y = north; y <= south; y += block_size) {
        context.moveTo(west, y);
        context.lineTo(east, y);
    }
    context.strokeStyle = 'grey';
    context.stroke();

    // Draw a border.
    context.beginPath();
    context.moveTo(west, north);
    context.lineTo(east, north);
    context.lineTo(east, south);
    context.lineTo(west, south);
    context.lineTo(west, north);
    context.strokeStyle = 'blue';
    context.stroke();
}

window.onload = drawGridOnCanvas;
