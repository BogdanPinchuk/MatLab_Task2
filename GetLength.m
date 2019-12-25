function [capacity] = GetLength(data, direction, win, noise)
%���������� ��������� ������ ��� ����� ������� �������
% data - ������� ����� ����������
% win - ������ ����
% noise - �������� ���� � %, ��� ����� ������
% direction - �������� ���������� ������� ���������� ��
% 1 / H - �������������
% 2 / V - �����������

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

% lines - ������� ������ ��� ��� ������ 
% count - ������� ����� � ����� ��������� ������� �������
if (direction == 1)
    [lines, count] = size(data);
else
    [count, lines] = size(data);
end

% ����� ��� �������������� �����
dataAverage = zeros(size(data, 1), size(data, 2));
capacity = zeros(lines, 1);

% ���������� ����� - ����������� � ������� ���� win
if (direction == 1)
    for i = 1 : lines
        line = double(data(i, :));
       
        % ����������� ���������, ��� ��������� �������� - ��������
        % �������� ������������, � ���� ������� ������� ������������ �
        % �������� ��� ����������� ������ ESF
        for j = 1 : count
            dataAverage(i, j) = std(GetWinArray(line, win, j), 1);
        end
        
        line = dataAverage(i, :);
        
        % ���� ��� ��������� 5% �� ������������ ��������, (�������� ���� ����������)
        lim = noise * max(line) / 100;
    
        % ���������� �������, ���� ��������� ������� �� 0, � ���� �������
        % ����� ��������� �������� ����, �� 1
        line = line >= lim;
        
        % ���������� ������� ���������� ����� ��� ����� ������� �������
        capacity(i) = sum(line);
    end
else
    for i = 1 : lines
        line = double(data(:, i));
       
        % ����������� ���������, ��� ��������� �������� - ��������
        % �������� ������������, � ���� ������� ������� ������������ �
        % �������� ��� ����������� ������ ESF
        for j = 1 : count
            dataAverage(j, i) = std(GetWinArray(line, win, j), 1);
        end
        
        line = dataAverage(:, i);
        
        % ���� ��� ��������� 5% �� ������������ ��������, (�������� ���� ����������)
        lim = noise * max(line) / 100;
    
        % ���������� �������, ���� ��������� ������� �� 0, � ���� �������
        % ����� ��������� �������� ����, �� 1
        line = line >= lim;
        
        % ���������� ������� ���������� ����� ��� ����� ������� �������
        capacity(i) = sum(line);
    end
end

% �������. ��������, ���� �������� ������ �������� �� ��� �������� � �
% ��������� �� �������� ������������ � �������� �������; ����� ���
% �������������� ������� �� ���� ��������� ���������� ����� ���� �
% �������� ����, ��� �� ����������� �������� ������� ���� � ���� � ����
% �� �����������, � � ������ ������� ��� �������� ��� ���� ���� ����
% ����� ���� ��� ����� ������� �������; ������� �� ������� ���� ��
% �������� ������ �����, � �� �� ���

% �������� ����������� ��������
capacity = max(capacity);

end

