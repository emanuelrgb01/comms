function plt=plotFFT(x,fs)
    N = length(x); 
    X = fft(x); 
    X_mag = abs(fftshift(X))/N; 
    f = (-N/2:N/2-1)*(fs/N);
    plt = plot(f, X_mag);
end

