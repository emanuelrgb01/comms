testarSNRs = -10:1:10; %valores de SNR em dB
BER = [];
tamanho = 1e6; %tamanho da simulaçao
for SNR = testarSNRs
    sinal = 2*randi(2,tamanho,1)-3;
    ruidoso = sinal*10^(SNR/10) + randn(tamanho,1);
    
    %maximum likelyhood
    filtrado=[sign(ruidoso)];
    BER = [BER nnz(filtrado - sinal)/tamanho];
end
semilogy(testarSNRs,BER)

title("BER em funçao de SNR (dB)")
