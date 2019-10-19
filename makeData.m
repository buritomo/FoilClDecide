%　入力されたデータからalpha分布，Chord分布等を求める
InputData = csvread('data.csv');
field = size(InputData);
data.y = InputData(2:field(1,1), 1);
data.chord = InputData(2:field(1,1), 2);
data.alpha_inf = InputData(2:field(1,1), 4);
data.m_inf = InputData(2:field(1,1), 5);

sz = size(data);
max = sz(1,1);
N = 1024;
b = 27500;
row = 1.165;
speed = 7.6;

theta = (linspace(0, pi, N+1)).';
x = -1 * b *cos(theta) / 2;

c = zeros(N+1, 1);
alpha = zeros(N+1, 1);
m = zeros(N+1, 1);

j=1;
for i = N / 2 + 2 : N + 1
    while x(i, 1) > data.y(j, 1)
        j = j + 1;
    end
    c(i, 1) = data.chord(j-1, 1) * (data.y(j, 1) - x(i, 1)) + data.chord(j, 1) * (x(i, 1) - data.y(j-1, 1));
    c(i ,1) = c(i, 1) / (data.y(j, 1) - data.y(j-1, 1));
    alpha(i, 1) = data.alpha_inf(j-1, 1) * (data.y(j, 1) - x(i, 1)) + data.alpha_inf(j, 1) * (x(i, 1) - data.y(j-1, 1));
    alpha(i ,1) = alpha(i, 1) / (data.y(j, 1) - data.y(j-1, 1));
    alpha(i, 1) = alpha(i, 1) * pi / 180;
    m(i, 1) = data.m_inf(j-1, 1) * (data.y(j, 1) - x(i, 1)) + data.m_inf(j, 1) * (x(i, 1) - data.y(j-1, 1));
    m(i ,1) = m(i, 1) / (data.y(j, 1) - data.y(j-1, 1))/ pi * 180;
    j = 1;
end

c(N / 2 + 1, 1) = data.chord(1, 1);
alpha(N / 2 + 1, 1) = data.alpha_inf(1, 1) * pi / 180;
m(N / 2 + 1, 1) = data.m_inf(1, 1) / pi * 180;

for i = 1: N / 2
    c(N / 2 + 1 - i, 1) = c(N / 2 + 1 + i, 1);
    alpha(N / 2 + 1 - i, 1) = alpha(N / 2 + 1 + i, 1);
    m(N / 2 + 1 - i, 1) = m(N / 2 + 1 + i, 1);
end

