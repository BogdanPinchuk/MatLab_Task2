script 
% base realization

% clear all
clc, clear;

% Виявлення ColorChecker на зображені
% Load picture
picture = imread('picture.jpg');

% Show picture
% imshow(picture);
% image(picture);

% Size
% heigth - висота
% width - ширина
% chanels - кількість каналів (3 - RGB)
[height, width, chanels] = size(picture);

% for help
% 2013 - Evaluation of Major Factors Affecting Spatial Resolution of Gamma-Rays Camera
% http://dx.doi.org/10.4236/jasmi.2013.34029
% 2009 - Comparison of different analytical edge spread function models
% for MTF calculation using curve-fitting
% DOI: 10.1117/12.832793
% https://en.wikipedia.org/wiki/Optical_transfer_function

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

% находимо центр мас для рожного із рядків
i = 1;
% для горизонтального шаблону
data = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :);
dataRh = data(:, :, 1);
dataGh = data(:, :, 2);
dataBh = data(:, :, 3);

i = 2;
% для вертикального шаблону
data = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :);
dataRv = data(:, :, 1);
dataGv = data(:, :, 2);
dataBv = data(:, :, 3);

clear dapic data i;

% зазвичай в зображеннях створених вручну, RGB комоненти по інтенсивності
% рівні, але так як знімала реальна камера, то можливі варіації (вплив
% шумів) тобто в чб ці компоненти відрізнятимуться, тому можна взяти якесь
% значення - наприклад, середнє аврифметичне і т.д.
% але можна обрахувати і порівняти 3 компоненти між собою, що покаже як
% впливає на результуюче зображення кожен із фільтів, або покаже вплив
% довжини хвилі на МПФ, дана тема потребує дослідження...
% data = GetColorComponent(picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :), 'AM');

direction = 'h';
comRh = CenterOfMass(dataRh, direction);
comGh = CenterOfMass(dataGh, direction);
comBh = CenterOfMass(dataBh, direction);

direction = 'v';
comRv = CenterOfMass(dataRv, direction);
comGv = CenterOfMass(dataGv, direction);
comBv = CenterOfMass(dataBv, direction);

% знаходимо необхідну емність - кількість пікселів за яими можна описати
% ESF (крайову функцію)
direction = 'h';
capacity_Rh = GetLength(dataRh, direction, 25, 5);
capacity_Gh = GetLength(dataGh, direction, 25, 5);
capacity_Bh = GetLength(dataBh, direction, 25, 5);

direction = 'v';
capacity_Rv = GetLength(dataRv, direction, 25, 5);
capacity_Gv = GetLength(dataGv, direction, 25, 5);
capacity_Bv = GetLength(dataBv, direction, 25, 5);

% Знаходимо крайову функцію
direction = 'h';
[ESF_Rh, ESFarray_Rh] = GetESF(dataRh, comRh, direction, capacity_Rh);
[ESF_Gh, ESFarray_Gh] = GetESF(dataGh, comGh, direction, capacity_Gh);
[ESF_Bh, ESFarray_Bh] = GetESF(dataBh, comBh, direction, capacity_Bh);

direction = 'v';
[ESF_Rv, ESFarray_Rv] = GetESF(dataRv, comRv, direction, capacity_Rv);
[ESF_Gv, ESFarray_Gv] = GetESF(dataGv, comGv, direction, capacity_Gv);
[ESF_Bv, ESFarray_Bv] = GetESF(dataBv, comBv, direction, capacity_Bv);

% Знаходимо LSF - функцію розсіювання лінії, це диференціал від ESF
% LSF(x) = d(ESF(x))/dx
LSF_Rh = diff(ESF_Rh);
LSF_Gh = diff(ESF_Gh);
LSF_Bh = diff(ESF_Bh);

LSF_Rv = diff(ESF_Rv);
LSF_Gv = diff(ESF_Gv);
LSF_Bv = diff(ESF_Bv);

% Graphics - present result

% Горизонтальний патерн
figure('Name','Calculate MTF for R chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataRh, comRh, ESF_Rh, ESFarray_Rh, LSF_Rh);
figure('Name','Calculate MTF for G chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataGh, comGh, ESF_Gh, ESFarray_Gh, LSF_Gh);
figure('Name','Calculate MTF for B chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataBh, comBh, ESF_Bh, ESFarray_Bh, LSF_Bh);

% Вертикальний патерн
figure('Name','Calculate MTF for R chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataRv, comRv, ESF_Rv, ESFarray_Rv, LSF_Rv);
figure('Name','Calculate MTF for G chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataGv, comGv, ESF_Gv, ESFarray_Gv, LSF_Gv);
figure('Name','Calculate MTF for B chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataBv, comBv, ESF_Bv, ESFarray_Bv, LSF_Bv);

% Present different beatween chanels
% figure(1);
% hold on;
% plot(ESF_R);
% plot(ESF_G);
% plot(ESF_B);
% 
% figure(2);
% hold on;
% plot(LSF_R);
% plot(LSF_G);
% plot(LSF_B);

clear direction dataRh dataGh dataBh dataRv dataGv dataBv comRh comGh comBh...
    comRv comGv comBv ESFarray_Rh ESFarray_Gh ESFarray_Bh ESFarray_Rv...
    ESFarray_Gv ESFarray_Bv capacity_Rh capacity_Gh capacity_Bh...
    capacity_Rv capacity_Gv capacity_Bv; 

clear ESF_Rh ESF_Gh ESF_Bh ESF_Rv ESF_Gv ESF_Bv...
    LSF_Rh LSF_Gh LSF_Bh LSF_Rv LSF_Gv LSF_Bv 
