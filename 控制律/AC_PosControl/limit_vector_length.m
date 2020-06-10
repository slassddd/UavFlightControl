function [bool,vector_x,vector_y]=limit_vector_length( vector_x,  vector_y,   max_length)
 
%      limit vector to a given length, returns true if vector was limited
    vector_length = norm([vector_x, vector_y],2);
    bool=0;
    if ((vector_length > max_length)&&vector_length>0)  
        vector_x =vector_x* (max_length / vector_length);
        vector_y =vector_y*(max_length / vector_length); 
        bool=1;
    end
  
end

