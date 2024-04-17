% analyze.m
% Copywrite (C) Noam Schuck <noam.schuck@gmail.com>

function [sval, eigval, U] = analyze(A, R);
    [U, sval, V] = svd(A);
    [eigvec, eigval] = eig(R);
    [eigval, idx] = sort(diag(eigval), 'descend');
    eigvec = eigvec(:,idx);
end
