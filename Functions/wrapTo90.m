function wrapped_angle = wrapTo90(angle)
wrapped_angle = mod(angle, 180);


if wrapped_angle > 90
    wrapped_angle = wrapped_angle - 180;
elseif wrapped_angle < -90
    wrapped_angle = wrapped_angle + 180;
end

end