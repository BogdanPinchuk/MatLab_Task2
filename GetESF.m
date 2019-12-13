function [center] = GetESF(data, direction)
% Отримання функції розсіювання краю
% data - частина даних зображення
% direction - напрямок визначення функції розсіювання лінії
% 0 / N - по нормалі
% 1 / H - горизонтально
% 2 / V - вертикально

% for warning
str = 'Input format of component is failed.';

% change unit of direction
if ischar(direction)
    if (upper(direction) == 'N')
        direction = 0;
    elseif (upper(direction) == 'H')
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

% за умови коли обрано визначення середної ESF по нормалі до кривої
if (direction == 0)
    
end


end

