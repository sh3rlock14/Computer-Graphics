classdef triangle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % sono i vertici del triangolo
        v1;
        v2;
        v3;
        area;
        
    end
    
    methods
        function obj = triangle(varargin)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            if nargin>0
                obj.v1 = varargin{1};
                obj.v2 = varargin{2};
                obj.v3 = varargin{3};
            else
                obj.v1 = vertex3D();
                obj.v2 = vertex3D();
                obj.v3 = vertex3D();
            end
            %calcArea(obj);
                
        end
       
         function  outputArg =  calcArea(obj)
            %METHOD1 Summary of this method goes here
             %computes the area for each triangle
             M = [obj.v1.x obj.v1.y 1;...
                 obj.v2.x obj.v2.y 1;...
                 obj.v3.x obj.v3.y 1];
             
             obj.area = abs(det(M))*0.5;
            outputArg = obj.area;
         end
        
         function outputArg = calcolaArea(v1,v2,v3)
             M = [v1.x v1.y 1;...
                 v2.x v2.y 1;...
                 v3.x v3.y 1];
             
             areaTriangolo = abs(det(M))*0.5;
            outputArg = areaTriangolo;
         end
         
    end
end

