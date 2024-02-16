classdef DiscreteVector
    properties
        duration = [0 0];
        data;
        length;
    end
    methods
        function obj = DiscreteVector(start, data)
            obj.duration(1) = start;
            obj.length = sum(size(data))-1;
            obj.duration(2) = start + obj.length-1;
            obj.data = data;
        end
    end
end
