function [ESF] = GetESF(data, center, direction, length)
% Отримання функції розсіювання краю
% data - частина даних зображення
% center - центр мас кожноъ ESF в рядку
% direction - напрямок визначення функції розсіювання лінії
% 1 / H - горизонтально
% 2 / V - вертикально
% length - кількість пікселів, які описують функцію розсіювання краю
% ESF - функція розсіювання краю, крайова функція

% for warning
str = 'Input format of component is failed.';

% change unit of direction
if ischar(direction)
    if (upper(direction) == 'H')
        direction = 1;
    elseif (upper(direction) == 'V')
        direction = 2;
    else
        warning(str);
        return;
    end
elseif ~isnumeric(direction)
    warning(str);
    return;
end

% масив із набору ESF в кожному рядку
array = zeros(size(center, 2), length);

if (direction == 1)
    % за умови коли обрано визначення середної ESF по горизонталі
    
    % отримуємо набір ESF
    for i = 1 : size(array, 1)
        array(i, :) = GetWinArray(data(i, :), length, center(1, i));
    end
elseif (direction == 2)
    % за умови коли обрано визначення середної ESF по вертикалі
    
    % отримуємо набір ESF
    for i = 1 : size(array, 1)
        array(i, :) = GetWinArray(data(:, i), length, center(2, i));
    end
end

% отримуємо спільну ESF, де кожна точка є мат-сподіванням
ESF = mean(array);

% for analysis information
figure(1);
clf;
hold on;
for i = 1 : size(array, 1)
    plot(array(i, :), '.');
    pause(1/250);
end
plot(array(i, :), 'LineWidth', 3);

end

