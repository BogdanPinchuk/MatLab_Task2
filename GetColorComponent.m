function [matrix] = GetColorComponent(picture, component)
% Отримання кольорової компоненти
% 1 - R - червона, RGB
% 2 - G - зелена, RGB
% 3 - B - синя, RGB
% 4 - C - блакитний, CMYK
% 5 - M - пурпурний, CMYK
% 6 - Y - жовтий, CMYK
% 7 - K - чорний, CMYK
% 8 - Min - мінімальне, RGB
% 9 - Med - медіана, RGB
% 10 - Max - максимальна, RGB
% 11 - HM - середнє гармонійне "-1"
% 12 - GM - середнє геометричне "0"
% 13 - AM - середня арифметичне "1"
% 14 - RMS - середнє квадратичне "2"
% 15 - CM - середнє кубічне (степеневе) "3"
% help https://uk.wikipedia.org/wiki/Середнє_степеневе

% for warning
str = 'Input format of component is failed.';

% Size
% heigth - висота
% width - ширина
[width, height, chanels] = size(picture);

if (isnumeric(component))
    % out of the range
    if (component < 1 || 15 < component)
        warning(str);
        return;
    end
elseif (ischar(component))
    switch (upper(component))
        case 'R'
            component = 1;
        case 'G'
            component = 2;
        case 'B'
            component = 3;
        case 'C'
            component = 4;
        case 'M'
            component = 5;
        case 'Y'
            component = 6;
        case 'K'
            component = 7;
        case 'MIN'
            component = 8;
        case 'MED'
            component = 9;
        case 'MAX'
            component = 10;
        case 'HM'
            component = 11;
        case 'GM'
            component = 12;
        case 'AM'
            component = 13;
        case 'RMS'
            component = 14;
        case 'CM'
            component = 15;
        otherwise
            warning(str);
            return;
    end
else
    warning(str);
    return;
end

% for better speed
matrix = zeros(width, height);

% calculate of component
switch (component)
    case 1
        matrix = picture(:, :, 1);
    case 2
        matrix = picture(:, :, 2);
    case 3
        matrix = picture(:, :, 3);
    case 4
        matrix = 255 - picture(:, :, 1);
    case 5
        matrix = 255 - picture(:, :, 2);
    case 6
        matrix = 255 - picture(:, :, 3);
    case 7
        for i = 1 : width
            for j = 1 : height
                % this is own formula and it isn`t real; real color = case 8
                matrix(i, j) = 255 - median(picture(i, j, :));
            end
        end
    case 8
        matrix = min(min(picture(:, :, 1), picture(:, :, 2)), picture(:, :, 3));
%         for i = 1 : width
%             for j = 1 : height
%                 matrix(i, j) = min(picture(i, j, :));
%             end
%         end
    case 9
        for i = 1 : width
            for j = 1 : height
                matrix(i, j) = median(picture(i, j, :));
            end
        end
    case 10
        matrix = max(max(picture(:, :, 1), picture(:, :, 2)), picture(:, :, 3));
%         for i = 1 : width
%             for j = 1 : height
%                 matrix(i, j) = max(picture(i, j, :));
%             end
%         end
    case 11
        for i = 1 : width
            for j = 1 : height
                if (prod(picture(i, j, :)) == 0)
                    matrix(i, j) = 0;
                else
                    matrix(i, j) = chanels / sum(1 ./ picture(i, j, :));
                end
            end
        end
    case 12
        for i = 1 : width
            for j = 1 : height
                matrix(i, j) = nthroot(prod(picture(i, j, :)), chanels);
            end
        end
    case 13
        for i = 1 : width
            for j = 1 : height
                matrix(i, j) = sum(picture(i, j, :)) / chanels;
            end
        end
    case 14
        for i = 1 : width
            for j = 1 : height
                matrix(i, j) = sqrt(sum(picture(i, j, :) .^ 2) / chanels);
            end
        end
    case 15
        for i = 1 : width
            for j = 1 : height
                matrix(i, j) = nthroot(sum(picture(i, j, :) .^ 3) / chanels, 3);
            end
        end
end

% convert to unit8
matrix = uint8(matrix);

end

