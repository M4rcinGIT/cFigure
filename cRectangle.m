% Child Class
classdef cRectangle < cFigure 
    
    methods(Access = private)

        function getArea(obj)

            obj.area = obj.dimensions(1) * obj.dimensions(2);

        end

        function getCircumference(obj)

            obj.circumference = 2 * (obj.dimensions(1) + obj.dimensions(2));

        end

        function dimensions = getValidDimensions(obj, dimensions)
            % Validate the dimesions of the created rectangle
            while (dimensions(1) <= 0 || dimensions(2) <= 0) 
                dimensions = input('Podaj poprawne wymiary prostokata, większe od 0 ([a, b]): ');
            end

        end  
       
    end
    
    methods
    
        function obj = cRectangle(coordinates, dimensions, rotationAngle, faceColor, edgeColor) 
            % Constructor 
            
            obj@cFigure(); % Call the constructor of the parent class

            obj.coordinates = coordinates; % [x, y] - center of the figure
            obj.dimensions = obj.getValidDimensions(dimensions); % [a, b] - dimensions of the rectangle
            obj.faceColor = obj.getValidColor(faceColor);
            obj.edgeColor = obj.getValidColor(edgeColor);
            obj.rotationAngle = rotationAngle; % initial rotation angle
            obj.h = []; % handle of the graphical object
            obj.getArea() 
            obj.getCircumference() 

        end

        function draw(obj) 
            % method to draw rectangle
            if ~isempty(obj.h) 
                % Hide the object if it is already drawn
                obj.hide()
            end
        
            % Coordinates of the rectangle vertices before rotation
            x = [obj.coordinates(1) - obj.dimensions(1)/2, obj.coordinates(1) + obj.dimensions(1)/2, obj.coordinates(1) + obj.dimensions(1)/2, obj.coordinates(1) - obj.dimensions(1)/2, obj.coordinates(1) - obj.dimensions(1)/2];
            y = [obj.coordinates(2) - obj.dimensions(2)/2, obj.coordinates(2) - obj.dimensions(2)/2, obj.coordinates(2) + obj.dimensions(2)/2, obj.coordinates(2) + obj.dimensions(2)/2, obj.coordinates(2) - obj.dimensions(2)/2];
            
            % Calculate the coordinates after rotation
            x_rot = obj.coordinates(1) + (x - obj.coordinates(1)) * cosd(-obj.rotationAngle) + (y - obj.coordinates(2)) * sind(-obj.rotationAngle);
            y_rot = obj.coordinates(2) - (x - obj.coordinates(1)) * sind(-obj.rotationAngle) + (y - obj.coordinates(2)) * cosd(-obj.rotationAngle);
            
            % Draw the rectangle
            obj.h = patch('XData',x_rot,'YData',y_rot,'FaceColor',obj.faceColor,'EdgeColor',obj.edgeColor, 'FaceAlpha', 0.3);    
        
        end

        function disp(obj) 
            % Display the basic properties of the rectangle
            fprintf(['Prostokat nr.%f o polozeniu: [%f, %f],\n ' ...
                'wymiarach: [%f, %f],\n kolorze wypelnienia: %s,\n ' ...
                'kolorze krawedzi: %s,\n polu: %f,\n obwodzie: %f\n' ...
                ''], obj.id, obj.coordinates(1), obj.coordinates(2), obj.dimensions(1), obj.dimensions(2), obj.faceColor, obj.edgeColor, obj.area, obj.circumference);
        
        end

        function obj = sum(obj1, obj2)
            % Sum of two rectangles, adding their location and dimensions
            obj = cRectangle(obj1.coordinates + obj2.coordinates, obj1.dimensions + obj2.dimensions, obj1.rotationAngle + obj2.rotationAngle, obj1.faceColor, obj1.edgeColor);
        
        end

        function obj = setCoordinates(obj, type, delta)
            % Change the location of the object by a vector delta = [deltaX, deltaY],
            % or change the location of the figure to the value given by the user
            switch type
                case 'wektor'
                    obj.coordinates = obj.coordinates + delta;
                case 'nowe_polozenie'
                    obj.coordinates = delta;
            end
            if ~isempty(obj.h)
                % Draw again if the object was already drawn
                obj.draw(); 
            end
        
        end

        function obj = setDimensions(obj, type, value)
            % Change the dimensions of the object, scaling them by a given factor or setting new dimensions
            switch type
                case 'skala'
                    while (value <= 0)
                        value = input("Skala musi być większa od 0, podaj poprawną wartość: ");
                    end
                    obj.dimensions = obj.dimensions * value;
                case 'nowe wymiary'
                    obj.getValidDimensions(value);
            end
            if ~isempty(obj.h)
                % Draw again if the object was already drawn
                obj.draw(); 
            end
        
        end

        function setRotationAngle(obj, newAngle)
            % Method to rotate the figure on the drawing
            obj.rotationAngle = newAngle;
            if ~isempty(obj.h)
                % Draw again if the object was already drawn
                obj.draw();
            end
        
        end

        function hide(obj)
            % Method to hide objects in the figure window
            delete(obj.h);
        
        end
    end
end
