function [y] = generate_y(w,x,range,m)
    %temp = zeros(numel(sort_x),1);    
%     for i=0:m
%        temp = w(i+1)*sort_x.^i;
%     end
    %y = double(range);
    p = poly2sym(flipud(w));
    x = x(range);
    y = eval(p);
    
    %y =  w(1) + w(2)*sort_x + w(3)*sort_x.^2;
    %     aMatrix = zeros(m+1);
    %     for or=0:m
    %         for k=0:m
    %             aMatrix(or+1,k+1) = sum(sort_x.^(or+k));
    %         end
    %     end
    %     y = aMatrix*w;
end