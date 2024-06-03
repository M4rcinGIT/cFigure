% Create objects of the cRectangle class
rectangle1 = cRectangle([0, 0], [-10, 20], 0, 'red', 'blue');
rectangle2 = cRectangle([30, 30], [15, 25], 0, 'green', 'black');

% Create objects of the cTriangle class
triangle1 = cTriangle([50, 50], [-10, 15, 20], 0, 'blue', 'red');
triangle2 = cTriangle([70, 70], [15, 20, 25], 0, 'black', 'green');

% Perform operations on the objects
fprintf("wyrysowanie obiektów na ekranie \n");


rectangle1.draw(); % Draw rectangle1
rectangle2.draw(); % Draw rectangle2
triangle1.draw();  % Draw triangle1
triangle2.draw();  % Draw triangle2

fprintf ("zmiana wymiarów obiektów\n");
pause(5); % Wait for 5 seconds

% Change dimensions
rectangle1.setDimensions('scale', 1.5);
rectangle2.setDimensions('new_dimensions', [20, 30]);
triangle1.setDimensions('scale', 0.5);
triangle2.setDimensions('new_dimensions', [20, 25, 30]);

fprintf('Zmiana położenia obiektów\n')
pause(5); % Wait for 5 seconds

% Change coordinates
rectangle1.setCoordinates('vector', [10, 10]);
rectangle2.setCoordinates('new_location', [40, 40]);
triangle1.setCoordinates('vector', [-10, -10]);
triangle2.setCoordinates('new_location', [80, 80]);

fprintf('Zmiana kąta obrotu\n');
pause(5); % Wait for 5 seconds

% Rotate
rectangle1.setRotationAngle(45);
rectangle2.setRotationAngle(-45);
triangle1.setRotationAngle(30);
triangle2.setRotationAngle(-30);

fprintf('zsumowanie dwóch obiektów\n');

% sum objects
sumRectangle = rectangle1.sum(rectangle2);
sumTriangle = triangle1.sum(triangle2);

fprintf('Rysowanie zsumowanych obiektów na ekranie\n');
pause(5); % Wait for 5 seconds

% Draw the sum of the objects
sumRectangle.draw();
sumTriangle.draw();

fprintf('ukrywanie wszystkich obiektów\n');
pause(5); % Wait for 5 seconds

% Hide objects
rectangle1.hide();
rectangle2.hide();
triangle1.hide();
triangle2.hide();
sumRectangle.hide();
sumTriangle.hide();
