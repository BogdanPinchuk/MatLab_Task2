function [center] = CenterOfMass(data, direction)
% ����� ��� ����������
% data - ������� ����� ����������
% direction - �������� ���������� ������� ���������� ��, true / H -
% �������������, false / V - �����������

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

% ���������� �������
if direction
    k = 2;
else
    k = 1;
end

data = abs(diff(double(data), 1, k));

% ���� ��� ��������� 25% �� ������������ ��������, (�������� ����� ����������)
noise = 0.25 * max(max(data));

% ��� �� ����� ����������� ������� ���������
data = data .* (data >= noise);

clear noise

% ��������� ����� ���, ���� ����� ���� � ����� ��������, ��� ��������
% ������������ ���� ��� ������ �������� (���� ������/�����������)
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

% ��������� ����� � ������������ (X, Y)
temp = zeros(2, size(center, 2));

temp(1, :) = 1 : size(center, 2);
temp(2, :) = round(center);
if direction
    temp = flip(temp, 1);
end

center = temp;

clear temp ;

end

