% plotFilter.m
% Copywrite (C) 2024 Noam Schuck <noam.schuck@gmail.com>
% Plots filters

function fig = plotFilters(a, b, p, z, digital, name)
    if digital
        [h, w] = freqz(b, a, 1e3);
    else
        [h, w] = freqs(b, a, 1e3);
    end

    mag   = 20*log10(abs(h));
    phase = unwrap(angle(h))*180/pi;

    fig = figure;

    subplot(2, 2, 2);
    if max(w) > 1e6
        w=w./1e6;
    end
    plot(w, mag);
    grid on;
    title('Magnitude Response');
    if min(mag) > -400
        ylim([min(mag), 10]);
    else
        ylim([-400, 10]);
    end
    xlim([0,3]);
    xlabel('Frequency [MHz]');
    ylabel('Magnitude [dB]')

    subplot(2, 2, 4);
    plot(w, phase);
    grid on;
    title('Phase Response');
    if max(w) > 5
        xlim([0, 3]);
    end
    xlabel('Frequency [MHz]');
    ylabel('Phase [dB]')

    subplot(2, 2, [1,3]);
    zplane(z, p);
    title('Pole Zero Plot');

    sgtitle(name);
end
