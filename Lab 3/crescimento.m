function [y] = crescimento(imagem, pixel_inicial,T)
pixel = pixel_inicial
imagem(pixel(1), pixel(2)) = 255;
iteracao = 0;
p = 4*(3+ iteracao);
flag = 4;
while flag>0
    for n=-p/8:p/8
        flag = 0;
        p_atual = pixel+[p, -iteracao]
        if abs(imagem(p_atual(1), p_atual(2))- imagem(pixel(1), pixel(2)))<T
            imagem(pixel+[p, -iteracao]) = imagem(pixel(1), pixel(2));
            flag = flag+1
        else
            imagem(p_atual(1), p_atual(2))=0;
        end
        p_atual = pixel+[p, +iteracao];
        if abs(imagem(p_atual(1), p_atual(2))- imagem(pixel(1), pixel(2)))<T
            imagem(p_atual(1), p_atual(2)) = imagem(pixel(1), pixel(2));
            flag = flag+1
        else
            imagem(p_atual(1), p_atual(2)) =0;
        end                 
        p_atual = pixel+[-iteracao, +p];
        if abs(imagem(p_atual(1), p_atual(2))- imagem(pixel(1), pixel(2)))<T
            imagem(p_atual(1), p_atual(2)) = imagem(pixel(1), pixel(2));
            flag = flag+1
        else
            imagem(p_atual(1), p_atual(2)) =0;
        end
        p_atual = pixel+[+iteracao, +p];
        if abs(imagem(p_atual(1), p_atual(2))- imagem(pixel(1), pixel(2)))<T
            imagem(p_atual(1), p_atual(2)) = imagem(pixel(1), pixel(2));
            flag = flag+1
        else
            imagem(p_atual(1), p_atual(2))=0;            
        end
    end
    iteracao = iteracao+1;
    p = 4*(3+iteracao);
end
y = imagem;
end

