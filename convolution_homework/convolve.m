function h = convolve(x, y)
    data = conv(x.data, y.data);
    start_time = x.duration(1)+y.duration(1);
    h = DiscreteVector(start_time, data);
end
