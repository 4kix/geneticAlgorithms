function func = fitnessFunc2(x)
    for i = 1:size(x,1)
        func(i)=(1+((x(i,1)+x(i,2)+1).^2).*(19-14*x(i,1)+3*x(i,1).^2-14*x(i,2)+6*x(i,1).*x(i,2)+3*x(i,2).^2)).*...
            (30+((2*x(i,1)-3*x(i,2)).^2).*(18-32*x(i,1)+12*x(i,1).^2+48*x(i,2)-36*x(i,1).*x(i,2)+27*x(i,2).^2));
    end
end