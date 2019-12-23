function [MTF] = GetMTF(LSF)
%��������� ���
% LSF - ������� ���������� ��

LSF = LSF_Rh;

% �������� ���
MTF = abs(fft(LSF));

% ������� �����
f = 1: fix(size(MTF, 2)/ 2) + 1;
MTF = MTF(f);

% ������� ���
MTF = MTF / max(MTF);

plot(f - 1, MTF);
grid on;

end

