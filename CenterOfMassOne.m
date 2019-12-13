function [center] = CenterOfMass(data)
% ����� ��� ����������
% data - ������� ����� ����������

% for warning
str = 'Input format of component is failed.';

% ���������� �������
data = abs(diff(double(data), 1, 2));

% ���� ��� ��������� 25% �� ������������ ��������
noise = 0.25 * max(max(data));

% ��� �� ����� ����������� ������� ���������
data = data .* (data >= noise);

clear noise

% ��������� ����� ���, ���� ����� ���� � ����� ��������, ��� ��������
% ������������ ���� ��� ������ �������� (���� ������/�����������)
array = 1 : size(data, 2);
center = zeros(1, size(data, 1));

for i = 1 : size(data, 1)
    line = data(i, :);
    center(i) = sum(line .* array) / sum(line);
end

clear line array i;

% ��������� ����� � ������������ (X, Y)
temp = zeros(2, size(center, 2));

temp(1, :) = round(center);
temp(2, :) = 1 : size(center, 2);

center = temp;

clear temp ;

end

