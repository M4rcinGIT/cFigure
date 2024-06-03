% Child Class
classdef cTriangle < cFigure 
    
    methods (Access = private)

        
        function getArea(obj)
            
            p = sum(obj.dimensions)/2; % half of circumference of the triangle
            obj.area = sqrt(p*(p-obj.dimensions(1))*(p-obj.dimensions(2))*(p-obj.dimensions(3)));
        
        end

        
        function getCircumference(obj)

            obj.circumference = sum(obj.dimensions);
        
        end

        
        function dimensions = getValidDimensions(obj, dimensions)
            % Method to validate the dimensions of the triangle
            while (dimensions(1) <= 0 || dimensions(2) <= 0 || dimensions(3) <= 0 || ...
                dimensions(1) >= dimensions(2) + dimensions(3) || ...
                dimensions(2) >= dimensions(1) + dimensions(3) || ...
                dimensions(3) >= dimensions(1) + dimensions(2))
                dimensions = input('Podaj poprawne wartości, większe od 0 oraz takie z których można złożyć trójkąt([a, b, c]): ');
            end
        
        end
        

    end
    
    methods
        
        function obj = cTriangle(coordinates, dimensions, rotationAngle, faceColor, edgeColor)
            % Constructor for the cTriangle class 
            obj@cFigure(); % Call the constructor of the parent class cFigure
 
            % Initialize the properties of the object
            obj.coordinates = coordinates; % [x, y] - center of the figure
            obj.dimensions = obj.getValidDimensions(dimensions); % [a, b, c] - dimensions of the triangle
            obj.faceColor = obj.getValidColor(faceColor);
            obj.edgeColor = obj.getValidColor(edgeColor);
            obj.rotationAngle = rotationAngle; % initial rotation angle
            obj.h = []; % handle of the graphical object
            obj.getArea()
            obj.getCircumference()
        
        end


        
        function draw(obj) 
            % Method to draw the triangle
            if ~isempty(obj.h) 
                % Hide the object if it is already drawn
                obj.hide()
            end
        
            % Calculate the coordinates of the triangle vertices
            a = obj.dimensions(1);
            b = obj.dimensions(2);
            c = obj.dimensions(3);
            x = [0, a, b*cos(acos((a^2+b^2-c^2)/(2*a*b)))];
            y = [0, 0, b*sin(acos((a^2+b^2-c^2)/(2*a*b)))];
        
            % Calculate the coordinates after rotation
            x_rot = (x - mean(x)) * cosd(-obj.rotationAngle) + (y - mean(y)) * sind(-obj.rotationAngle);
            y_rot = (x - mean(x)) * sind(-obj.rotationAngle) + (y - mean(y)) * cosd(-obj.rotationAngle);
        
            % Shift the triangle so that its center is at the point obj.coordinates
            x_rot = x_rot + obj.coordinates(1);
            y_rot = y_rot + obj.coordinates(2);
        
            % Draw the triangle
            obj.h = patch('XData',x_rot,'YData',y_rot,'FaceColor',obj.faceColor,'EdgeColor',obj.edgeColor, 'FaceAlpha', 0.3);    
        
        end

        % Display the basic properties of the triangle
        function disp(obj) 
            fprintf(['Triangle no.%f at location: [%f, %f],\n ' ...
                'dimensions: [%f, %f, %f],\n face color: %s,\n ' ...
                'edge color: %s,\n area: %f,\n circumference: %f\n' ...
                ''], obj.id, obj.coordinates(1), obj.coordinates(2), obj.dimensions(1), obj.dimensions(2), obj.dimensions(3), obj.faceColor, obj.edgeColor, obj.area, obj.circumference);
        
        end

        
        function obj = sum(obj1, obj2)
            % Sum of two triangles, adding their location and dimensions
            obj = cTriangle(obj1.coordinates + obj2.coordinates, obj1.dimensions + obj2.dimensions, obj1.rotationAngle + obj2.rotationAngle, obj1.faceColor, obj1.edgeColor);
        
        end

        
        function obj = setCoordinates(obj, type, delta)
            % Change the location of the object by a vector delta = [deltaX, deltaY],
            % or change the location of the figure to the value given by the user
            switch type
                case 'vector'
                    obj.coordinates = obj.coordinates + delta;
                case 'new_location'
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
            % Method to hide objects on the drawing 
            if ~isempty(obj.h)
                % Draw again if the object was already drawn
                delete(obj.h);
            end
            
        end
    end
end
