function [center] = CenterOfMass(data, direction)
% Центр мас зображення
% data - частина даних зображення
% direction - напрямок визначення функції розсіювання лінії, true / H -
% горизонтально, false / V - вертикально

% for warning
str = 'Input format of component is failed.';

% change unit of direction
if ischar(direction)
    if (upper(direction) == 'H')
        direction = true;
    elseif (upper(direction) == 'V')
        direction = false;
    else
        warning(str);
        return;
    end
elseif ~islogical(direction)
    warning(str);
    return;
end

% animation for exam
% for i = 1 : size(data, 2)
%     line = data(:, i);
%     plot(line);
%     ylim([0 255]);
%     xlim([1 size(data, 1)]);
%     pause(1/100);
% end

% заноходимо похідну
if direction
    k = 2;
else
    k = 1;
end

data = abs(diff(double(data), 1, k));

% якщо шум становить 25% від максималного значення, (величину задає користувач)
noise = 0.25 * max(max(data));

% все що нижче необхідного сигналу зануляємо
data = data .* (data >= noise);

clear noise

% знаходимо центр мас, хоча можна було б взяти максимум, але максимум
% справедливий лише для крутих сходинок (різко змінних/контрастних)
if direction
    array = 1 : size(data, 2);
    center = zeros(1, size(data, 1));
else
    array = (1 : size(data, 1))';
    center = zeros(1, size(data, 2));
end

if direction
    for i = 1 : size(data, 1)
        line = data(i, :);
        center(i) = sum(line .* array) / sum(line);
    end
else
    for i = 1 : size(data, 2)
        line = data(:, i);
        center(i) = sum(line .* array) / sum(line);
    end
end

clear line array i;

% створюємо масив з координатами (X, Y)
temp = zeros(2, size(center, 2));

temp(1, :) = 1 : size(center, 2);
temp(2, :) = round(center);
if direction
    temp = flip(temp, 1);
end

center = temp;

clear temp ;

end

