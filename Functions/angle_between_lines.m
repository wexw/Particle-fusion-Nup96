function angle = angle_between_lines(startline, endline)
    % Calculate the direction vector of each line
    start_dir = startline(:, 2) - startline(:, 1);
    lend_dir = endline(:, 2) - endline(:, 1);

    % Calculate the dot product and cross product
    dot_product = dot(start_dir, lend_dir);
    cross_product = cross([start_dir; 0], [lend_dir; 0]);

    % Calculate the signed angle between the two lines
    angle = atan2(norm(cross_product), dot_product);

    % Convert the angle to degrees
    angle = rad2deg(angle);

    % Determine the sign of the angle using the cross product
    if cross_product(3) < 0
        angle = -angle;
    end
end