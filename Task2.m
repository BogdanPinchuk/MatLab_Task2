script 
% base realization

% clear all
clc, clear;

% ��������� ColorChecker �� ��������
% Load picture
picture = imread('picture.jpg');

% Show picture
% imshow(picture);
% image(picture);

% Size
% heigth - ������
% width - ������
% chanels - ������� ������ (3 - RGB)
[height, width, chanels] = size(picture);

% for help
% 2013 - Evaluation of Major Factors Affecting Spatial Resolution of Gamma-Rays Camera
% http://dx.doi.org/10.4236/jasmi.2013.34029
% 2009 - Comparison of different analytical edge spread function models
% for MTF calculation using curve-fitting
% DOI: 10.1117/12.832793

% dapic - data of picture

%%%%%%
% First calculate
%%%%%%
% 1 - Right pattern
dapic(1, 1) = {'Horizontal'};
dapic(1, 2) = {[height - 2182, 3166; height - 1538, 3388]};
% 2	- Down pattern
dapic(2, 1) = {'Vertical'};
dapic(2, 2) = {[height - 1482, 2469; height - 1261, 3115]};

clear height width chanels;

% show pacher
% i = 1;
% patcher0 = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :);
% imshow(patcher0);
% image(patcher0);

% �������� ����� ��� ��� ������� �� �����
i = 2;
dataR = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 1);
% dataG = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 2);
% dataB = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 3);

clear dapic;

% �������� � ����������� ��������� ������, RGB ��������� �� ������������
% ���, ��� ��� �� ������ ������� ������, �� ������ ������� (�����
% ����) ����� � �� �� ���������� ��������������, ���� ����� ����� �����
% �������� - ���������, ������ ������������ � �.�.
% ��� ����� ���������� � �������� 3 ���������� �� �����, �� ������ ��
% ������ �� ����������� ���������� ����� �� ������, ��� ������ �����
% ������� ���� �� ���, ���� ���� ������� ����������...
% data = GetColorComponent(picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :), 'AM');

if (i == 1)
    direction = 'h';
else
    direction = 'v';
end

comR = CenterOfMass(dataR, direction);
% comG = CenterOfMass(dataG, direction);
% comB = CenterOfMass(dataB, direction);

clear i;

% figure(1);
% % data = rot90(dataR, 2);
% data = dataR;
% hold off;
% imshow(data);
% % image(data);
% hold on;
% plot(comR(1, :), comR(2, :), 'LineWidth', 2);

% ��������� ��������� ������ - ������� ������ �� ���� ����� �������
% ESF (������� �������)

% ��������� ������� �������
ESF = GetESF(dataR, comR, direction, GetLength(dataR, direction, 25, 3));

clear direction comR dataR;


