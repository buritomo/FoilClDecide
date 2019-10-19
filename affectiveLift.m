% 揚力線理論に基づき揚力分布を計算する

meu = zeros(N+1, 1);

for i = 1:N+1
    meu(i, 1) = m(i, 1) * c(i, 1) / 4 / b;
end

A = zeros(N+1, N+1);
Y = zeros(N+1, 1);

for i = 1:N+1
   for j = 1:N+1
        A(i, j) = (j * meu(i, 1) + sin(theta(i, 1))) * sin(j * theta(i, 1));
   end
end

for i = 1:N+1
    Y(i, 1) = meu(i, 1) * alpha(i, 1) * sin(theta(i, 1));
end

X = A\ Y;


for i = 1:N+1
	delta_alpha(i)=0;
    for j = 1:N+1
		delta_alpha(1, i) = delta_alpha(1, i) + j * X(j, 1) * sin(theta(i, 1) * j) / sin(theta(i, 1));
    end
end

figure(1)
plot(x, delta_alpha * 180 / pi);
title("delta alpha(deg)");

Cl = zeros(N-1,1);
for i = 1:N+1
    Cl(i) = m(i) * (alpha(i) - delta_alpha(i));
end

figure(2)
plot(x,Cl);
title("Cl");

Lift = zeros(N-1,1);
for i = 1:N+1
    Lift(i) = 1 / 2 * row * speed * speed * c(i)/1000/1000 * Cl(i);
end

figure(3)
plot(x,Lift);
title("Lift");
