function [center] = CenterOfMassOne(data)
% Центр мас зображення
% data - частина даних зображення

% for warning
str = 'Input format of component is failed.';

% заноходимо похідну (так краще виділяє сходинку)
if (size(data, 1) > size(data,  2))
    data = abs(diff(double(data), 1, 2));
else
    data = abs(diff(double(data)));
end

% якщо шум становить 25% від максималного значення
noise = 0.25 * max(max(data));

% все що нижче необхідного сигналу зануляємо
data = data .* (data >= noise);

clear noise

% знаходимо центр мас, хоча можна було б взяти максимум, але максимум
% справедливий лише для крутих сходинок (різко змінних/контрастних)
array = 1 : size(data, 2);
center = zeros(1, size(data, 1));

for i = 1 : size(data, 1)
    line = data(i, :);
    center(i) = sum(line .* array) / sum(line);
end

clear line array i;

% створюємо масив з координатами (X, Y)
temp = zeros(2, size(center, 2));

temp(1, :) = round(center);
temp(2, :) = 1 : size(center, 2);

center = temp;

clear temp ;

end

