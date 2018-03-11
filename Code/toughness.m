function [ toughness ] = toughness( Bridge, failed )
  
    %add up toughness for each data set until the estimated failed point
    for i = 1: 2004
        if Bridge(i,2) > failed
            break; %exit the for loop
        end

        toughness = toughness + (Bridge(i+1,2) - Bridge(i,2)) * ((Bridge(i+1,1) + Bridge(i,1))/2);
    end
    %fprintf('Sum of all Rectangles: %-.2f\n',toughness1);

end