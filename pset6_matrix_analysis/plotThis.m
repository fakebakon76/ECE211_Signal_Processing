% plotThis.m
% Copywrite (C) Noam Schuck <noam.schuck@gmail.com>

function plotThis(svals, evals, name)
    fig = figure;
    fig.Position = [1500, 1500, 1500, 1500];
    sgtitle(name);
    subplot(1,2,1);
    stem(diag(svals));
    title('SVD Plot');

    subplot(1,2,2);
    stem(1:100,evals);
    title('Eigenvalue Plot');
    
    saveas(fig, strcat(name,'.png'));
end
