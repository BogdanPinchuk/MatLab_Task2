function [outputA] = GetWinArray(inputA, win, num)
% отримання масиву для аналізу
% inputA - вхідний масив
% win - ширина вікна
% num - позиція в якій вибрати вікно

% вихід за межі масиву
if ((num < 1) || (num > size(inputA(:), 1)))
    error('Failed input data, out of range.');
end

% якщо вікно більше від вхідного масиву даних
if ((size(inputA(:), 1) < win))
    outputA = inputA;
    warning(['Width of window is: ' num2str(size(inputA(:), 1))]);
    return;
end

% вибір необхідних даних 
if (round(win/2) >= num)
    outputA = inputA(1 : win);
elseif (size(inputA(:), 1) - round(win/2) + 1 <= num)
    outputA = inputA(size(inputA(:), 1) - win + 1: size(inputA(:), 1));
else
    left = num - round(win/2);
    outputA = inputA(left + 1 : left + win);
end

end

