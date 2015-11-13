function [w] = generate_w(range,x,t,m,lambda)
    aMatrix = zeros(m+1);
    for or=0:m
        for k=0:m
            aMatrix(or+1,k+1) = sum(x(range).^(or+k));
        end
    end
    
    bMatrix = zeros(m+1,1);
    for a=0:m
        bMatrix(a+1,1) = sum((x(range).^(a)).*t(range) );
    end
    
    lamda_array=lambda*eye(m+1);
    lamda_array(1)=0;
    w=(aMatrix'*aMatrix+lamda_array)\(aMatrix')*bMatrix;
    %w = aMatrix \ bMatrix;
    %w = inv(aMatrix)*bMatrix;
    %w = inv(aMatrix'*aMatrix)*aMatrix'*bMatrix;
end