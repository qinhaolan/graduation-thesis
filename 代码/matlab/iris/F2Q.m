function U=F2Q(A)
[m, n] = size(A);
U=zeros(m,n);
for j=1:n
    tmp=max(A(:,j));
    for i=1:m
        if A(i,j)==tmp
            U(i,j)=1;
        else 
            U(i,j)=0;
        end
    end
end
end
        