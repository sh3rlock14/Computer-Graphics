classdef vertex3D
    %VERTEX3D Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        y;
        z;
    end
    
    methods
        function obj = vertex3D(varargin)
            %VERTEX3D Construct an instance of this class
            %  costruisco l'oggetto con i parametri che passo
            if nargin>0
                obj.x = varargin{1};
                obj.y = varargin{2};
                obj.z = varargin{3};
            else
                
                obj.x = randi([0 100],1); 
                obj.y = randi([0 100],1);
                obj.z = randi([0 100],1);
            end
            
            
            
        end
        
      
            
        
       
    end
end

