function [center] = GetESF(data, direction)
% ��������� ������� ���������� ����
% data - ������� ����� ����������
% direction - �������� ���������� ������� ���������� ��
% 0 / N - �� ������
% 1 / H - �������������
% 2 / V - �����������

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

% �� ����� ���� ������ ���������� ������� ESF �� ������ �� �����
if (direction == 0)
    
end


end

