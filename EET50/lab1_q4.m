testarSNRs = 0:1:20; %valores de SNR
BER = [];
size = 1e5; %tamanho da simulaçao
for SNR = testarSNRs
    sinal = 2*randi(2,size,1)-3;
    ruidoso = sinal*10^(SNR/10) + randn(size,1);
    
    %maximum likelyhood
    filtrado=[sign(ruidoso)];
    BER = [BER nnz(filtrado - sinal)/size];
end
semilogy(testarSNRs,BER)
