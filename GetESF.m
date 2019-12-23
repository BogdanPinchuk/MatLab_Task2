function [ESF, array] = GetESF(data, center, direction, length)
% ��������� ������� ���������� ����
% data - ������� ����� ����������
% center - ����� ��� ������ ESF � �����
% direction - �������� ���������� ������� ���������� ��
% 1 / H - �������������
% 2 / V - �����������
% length - ������� ������, �� �������� ������� ���������� ����
% ESF - ������� ���������� ����, ������� �������

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

% ����� �� ������ ESF � ������� �����
array = zeros(size(center, 2), length);

if (direction == 1)
    % �� ����� ���� ������ ���������� ������� ESF �� ����������
    
    % �������� ���� ESF
    for i = 1 : size(array, 1)
        array(i, :) = GetWinArray(data(i, :), length, center(1, i));
    end
elseif (direction == 2)
    % �� ����� ���� ������ ���������� ������� ESF �� ��������
    
    % �������� ���� ESF
    for i = 1 : size(array, 1)
        array(i, :) = GetWinArray(data(:, i), length, center(2, i));
    end
end

% �������� ������ ESF, �� ����� ����� � ���-����������
ESF = mean(array);

% ������� ��������
array = array ./  255;
ESF = ESF ./ 255;

% for analysis information
% figure(1);
% clf;
% hold on;
% for i = 1 : size(array, 1)
%     plot(array(i, :), '.');
%     pause(1/250);
% end
% plot(ESF, 'LineWidth', 3);

end
