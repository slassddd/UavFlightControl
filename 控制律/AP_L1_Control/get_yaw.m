function  yawo=get_yaw()
 global reverse
 global yaw
       yawo=yaw;
    if (reverse)  
       yawo=wrap_PI(pi +yaw);
    end
end

