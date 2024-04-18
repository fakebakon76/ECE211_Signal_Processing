% generateA.m
% Copywrite (C) Noam Schuck <noam.schuck@gmail.com>

function A = generateA(M, N, thetas, const, PdB, PndB)
    S = exp(-j*2*pi*const*(0:M-1)'.*cos(thetas))/sqrt(M); % Steering Matrix
    [tmp, L] = size(thetas);

    varS = (ones([L,1])*10).^(PdB'/10) + zeros(1,N);
    B = sqrt(varS).*(randn(L, N)+j*randn(L, N))/sqrt(2);
    
    varN = (ones(M,N)*10).^(PndB/10) + zeros(1, N);
    V = sqrt(varN).*(randn(M, N)+j*randn(M, N))/sqrt(2);
    A = S*B + V/sqrt(M);
end
