function occupancy_grid(data_file)

%create large 2D array of cells to act as map
%initialize every cell to value of 0 (l) since probability is 0.5
%log(0.5/0.5) = 0

grid_size = 300;
alpha = .2;
l_0 = 0;
l_occ = 2;
l_free = -2;

%initialize every cell to 0
grid = zeros(grid_size, grid_size);

%read the data file into a matrix to make easy to split up
data = dlmread(data_file);
length_data = size(data);

%read through the text file line by line
for p = 1:length_data(1)
    
    %split data into appropriate variables
    %positiona and location of the robot at time of data
    line = data(p, :);
    x = line(1);
    y = line(2);
    theta = line(3);
    %angles from the robots center line of sight that the range of the sensor extends to
    angle_min = line(4);
    angle_max = line(5);
    %the increment through the range of vision (MIN_ANGLE through MAX_ANGLE) at which range measurements are taken
    angle_inc = line(6);
    %the minimum and maximum detected distances of the sensor 
    range_min = line(7);
    range_max = line(8);
    %the distances to the nearest obstacle taken at a given increment
    ranges = line(9:end);
    
    %set beta constant
    beta = angle_inc;
    
    %find percepetual field range of robot at current location
    min_angle_range = theta + angle_min;
    max_angle_range = theta + angle_max;

    %loop through all cells in grid
    for i = 1:grid_size %rows
        for j = 1:grid_size %columns
            
            %calculate angle between robot and grid cell
            angle2 = atan2((i-90)/30 - y, (j-90)/30 - x);
            
            %fix the angle orientation to work with the robots
            if (angle2 > pi && angle2 < 2*pi)
                angle2 = angle2 - 2*pi;
            end
            
            %if angle is between the perceptual field of the robot
            if (angle2 > min_angle_range && angle2 < max_angle_range)
                %update the probability value of the cell accordingly
                
                %calculate the distance between robot and current cell
                r = sqrt((x - (j-90)/30)^2 + (y - (i-90)/30)^2);
                phi = angle2 - theta;
                
                %find index of theta closest to phi
                k = abs(round((phi - angle_min)/angle_inc));
                %edge case
                if (k == 0)
                    k = 1;
                end
                
                %if our range is Inf or Nan ignore it
                if (ranges(k) > range_max || ranges(k) < range_min)
                    grid(i,j) = grid(i,j);
                
                %if we are beyond the scope of our laser range then we
                %ignore it
                elseif (r > range_max || r < range_min)
                    grid(i,j) = grid(i,j);
                    
                %proceed based on the inverse_range algorithm
                elseif (r > min(range_max, ranges(k) + alpha/2) || abs(phi - k*angle_inc - angle_min) > beta/2)
                    %return 0
                    grid(i,j) = grid(i,j);
                
                elseif (ranges(k) < range_max && abs(r - ranges(k)) < alpha/2)
                   %return locc = 2
                   grid(i,j) = grid(i,j) + l_occ - l_0;
                
                elseif (r <= ranges(k))
                   %return lfree = -2  
                   grid(i,j) = grid(i,j) + l_free - l_0;
                end
            end
        end
    end
    
    %display current progress
    imagesc(grid)
    pause(0.1);
    
    %make note of what the grid looks like before we have run through all
    %of the data
    if (p == round(length_data(1)/2.5))
        grid_half_way = grid;
    end
end

%initialize final grid
final_grid = zeros(grid_size, grid_size);

%convert the log odds
for m = 1:grid_size
    for n = 1:grid_size
        final_grid(m,n) = 1 - (1/(1 + exp(grid(m,n))));
    end
end


%modify mappings so they have the correct orientation
final_grid = final_grid';
final_grid = rot90(final_grid, 2);
grid = grid';
grid = rot90(grid, 2);
grid_half_way = grid_half_way';
grid_half_way = rot90(grid_half_way, 2);

%create a new figure
figure
%plot all images side by side for comparison
subplot(1,3,1)
imagesc(grid_half_way);
title('Map Half-Way Through Calculating Log Odds');

subplot(1,3,2)
imagesc(grid);
title('Map before Log Odd Conversion');

subplot(1,3,3)
imagesc(final_grid);
title('Final Occupancy Map');

%end function
end
