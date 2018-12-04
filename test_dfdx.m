

df_approx = zeros(12,12) ;  
X0 = zeros(12,1) ; 
delta= 0.01 *ones(12,1) ; 

F_X0 = F(X0,I,g) ; 
F_X0_plus_delta = F(X0+delta,I,g) ; 

for i=1:12
    for j=1:12
        
        df_approx(i,j)= (F_X0_plus_delta(i)-F_X0(i))/delta(j) ; 
    end 
end 

df = dfdx(X0,I,g) ; 

diff = df-df_approx ; 
