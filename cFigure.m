% Parent class
classdef (Abstract) cFigure < handle
    properties (Access = protected)
        availableColors = {'red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black', 'white'}; 
        coordinates % [x, y]
        dimensions % [a, b] 
        faceColor 
        edgeColor 
        area 
        circumference 
        h % Handle of the graphical object
        rotationAngle 
        id % ID of the figure
    end

    methods(Access = private)

        getArea(obj) 
        getCircumference(obj) 
        getValidDimensions(obj, dimensions)

    end

    methods (Abstract)
        draw(obj) % draw object 
        hide(obj) % hide object
        sum(obj1, obj2) % sum dimensions and Coordinates
        setCoordinates(obj, rodzaj, delta) % sets coordiantes of the object
        setDimensions(obj, rodzaj, wartosc) % sets dimiensions of the object
        setRotationAngle(obj, kat) % sets rotational angle
    end

    methods (Access = protected)
        function obj = cFigure() 
            % constructor
            obj.id = cFigure.getNewId(); 
        end

        function validColor = getValidColor(obj, color)
            % validate color
            while (~ismember(color, obj.availableColors))
                 
                fprintf('Podaj poprawny kolor %s\n', strjoin(obj.availableColors, ', '));
                color = input("", 's');
            end
        
            validColor = color;
        end

    end

    methods (Access = private, Static)
        function id = getNewId() 
            % id getter 
            persistent counter; 
            if isempty(counter)
                counter = 0;
            end
            counter = counter + 1;
            id = counter;
        end
    end
end