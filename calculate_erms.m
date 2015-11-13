function [erms] = calculate_erms(y,t,range)
    erms = sqrt((y - t)'*(y - t)/length(range));
end