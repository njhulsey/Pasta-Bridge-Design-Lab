clc;
clear;

load BridgeData1.txt
Bridge1 = BridgeData1;

load BridgeData2.txt
Bridge2 = BridgeData2;

for i = 1: 2004
    Bridge1(i,2) = BridgeData1(i,2) - BridgeData1(1,2);
    if i < 566
        Bridge2(i,2) = BridgeData2(i,2) - BridgeData2(1,2);
    end

end

%plot bridge1 and bridge2
hold on
plot(Bridge1(:,2),Bridge1(:,1),'g');

plot(Bridge2(:,2),Bridge2(:,1),'r');

%set graph variables
title('displacement vs. load');
xlabel('displacement (in)');
ylabel('load (lbs)');
legend('Bridge 1', 'Bridge 2');


%find max on bridge1 
max1 = 1;
for i =  1: 2004
    if Bridge1(i,1) > Bridge1(max1,1)
        max1 = i;
    end
end
scatter(Bridge1(max1,2),Bridge1(max1,1))


%find max on bridge2
max2 = 1;
for i =  1: 565  
    if Bridge2(i,1) > Bridge2(max2,1)
        max2 = i;
    end
end
scatter(Bridge2(max2,2),Bridge2(max2,1))

weight1 = input('Please enter the weight of bridge #1 in lbs: ');
weight2 = input('Please enter the weight of bridge #2 in lbs:');

fprintf('\nPlease examine your plots and determine the displacement \nvalue where you reach catastrophic failure\n');



%where did we fail for bridge1?
failed1 = input('\nPlease enter a failure displacement value for Bridge #1: ');
toughness1 = toughness(Bridge1, failed1);



%where did we fail for bridge2?
failed2 = input('Please enter a failure displacement value for Bridge #2: ');
toughness2 = toughness(Bridge2, failed2);

%fprintf('Sum of all Rectangles : %-.2f\n',toughness2);

%second bridge weight is .225
%first bridge weight is .173


%output all of our data to a .txt file named Hulsey_ML4_results
fileID = fopen('Hulsey_ML4_results.txt','w');

fprintf(fileID, '                                             Bridge #1    Bridge #2\n');
fprintf(fileID, 'Maximum Load (lbs):                          %-.2f         %-.2f\n',Bridge1(max1,1),Bridge2(max2,1));
fprintf(fileID, 'Toughness by catastrophic failure (in-lbs):  %-.2f         %-.2f\n',toughness1, toughness2);
fprintf(fileID, 'Strength to Weight Ratio:                    %-.2f        %-.2f\n',(Bridge1(max1,1) / weight1),(Bridge2(max2,1) / weight2));
fprintf(fileID, 'Toughness to Weight Ratio:                   %-.2f        %-.2f\n',(toughness1/weight1), (toughness2/weight2));

fclose(fileID);