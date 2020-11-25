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
height = size(picture, 1);

% for help
% 2013 - Evaluation of Major Factors Affecting Spatial Resolution of Gamma-Rays Camera
% http://dx.doi.org/10.4236/jasmi.2013.34029
% 2009 - Comparison of different analytical edge spread function models
% for MTF calculation using curve-fitting
% DOI: 10.1117/12.832793
% https://en.wikipedia.org/wiki/Optical_transfer_function

% dapic - data of picture
% 1 - Right pattern
dapic(1, 1) = {'Horizontal'};
dapic(1, 2) = {[height - 2182, 3166; height - 1538, 3388]};
% 2	- Down pattern
dapic(2, 1) = {'Vertical'};
dapic(2, 2) = {[height - 1482, 2469; height - 1261, 3115]};

clear height width chanels;

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

% зазвичай в зображеннях, які створені вручну, RGB комоненти по інтенсивності
% рівні, але так як знімала реальна камера, то можливі варіації (вплив
% шумів, або хроматизму) тобто в чб ці компоненти відрізнятимуться, тому 
% можна взяти якесь значення - наприклад, середнє аврифметичне і т.д.
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
win = 25;
noise = 5;

direction = 'h';
capacity_Rh = GetLength(dataRh, direction, win, noise);
capacity_Gh = GetLength(dataGh, direction, win, noise);
capacity_Bh = GetLength(dataBh, direction, win, noise);

direction = 'v';
capacity_Rv = GetLength(dataRv, direction, win, noise);
capacity_Gv = GetLength(dataGv, direction, win, noise);
capacity_Bv = GetLength(dataBv, direction, win, noise);

clear win noise;

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
LSF_Rh = GetLSF(ESF_Rh);
LSF_Gh = GetLSF(ESF_Gh);
LSF_Bh = GetLSF(ESF_Bh);

LSF_Rv = GetLSF(ESF_Rv);
LSF_Gv = GetLSF(ESF_Gv);
LSF_Bv = GetLSF(ESF_Bv);

% Розраховуємо MTF - модуляційну передавальну функцію
% 2006 - Гонсалес Р., Вудс Р., Эддинс С. Цифровая обработка изображений в 
% среде MATLAB - розрахунок Фур'є перетворення
[MTF_Rh, f_Rh] = GetMTF(LSF_Rh);
[MTF_Gh, f_Gh] = GetMTF(LSF_Gh);
[MTF_Bh, f_Bh] = GetMTF(LSF_Bh);

[MTF_Rv, f_Rv] = GetMTF(LSF_Rv);
[MTF_Gv, f_Gv] = GetMTF(LSF_Gv);
[MTF_Bv, f_Bv] = GetMTF(LSF_Bv);

% Знаходимо PSF - функцію розсіювання точки, це інтеграл від диференціалу LSF


% Graphics - present result

% Горизонтальний патерн
figure('Name','Calculate MTF for R chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataRh, comRh, ESF_Rh, ESFarray_Rh, LSF_Rh, MTF_Rh, f_Rh);
figure('Name','Calculate MTF for G chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataGh, comGh, ESF_Gh, ESFarray_Gh, LSF_Gh, MTF_Gh, f_Gh);
figure('Name','Calculate MTF for B chanel and horizontal',...
    'NumberTitle','off');
PresentInfo(dataBh, comBh, ESF_Bh, ESFarray_Bh, LSF_Bh, MTF_Bh, f_Bh);

% Вертикальний патерн
figure('Name','Calculate MTF for R chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataRv, comRv, ESF_Rv, ESFarray_Rv, LSF_Rv, MTF_Rv, f_Rv);
figure('Name','Calculate MTF for G chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataGv, comGv, ESF_Gv, ESFarray_Gv, LSF_Gv, MTF_Gv, f_Gv);
figure('Name','Calculate MTF for B chanel and vertical',...
    'NumberTitle','off');
PresentInfo(dataBv, comBv, ESF_Bv, ESFarray_Bv, LSF_Bv, MTF_Bv, f_Bv);

% Present different between chanels
% Це можна представити у вигляді 3-х кривих на одному графіку, але краще
% показати це через відхилення
% PresentDiff(ESF_Rh, ESF_Gh, ESF_Bh, ESF_Rv, ESF_Gv, ESF_Bv,...
%     LSF_Rh, LSF_Gh, LSF_Bh, LSF_Rv, LSF_Gv, LSF_Bv,...
%     MTF_Rh, MTF_Gh, MTF_Bh, MTF_Rv, MTF_Gv, MTF_Bv);

clear direction dataRh dataGh dataBh dataRv dataGv dataBv comRh comGh comBh...
    comRv comGv comBv ESFarray_Rh ESFarray_Gh ESFarray_Bh ESFarray_Rv...
    ESFarray_Gv ESFarray_Bv capacity_Rh capacity_Gh capacity_Bh...
    capacity_Rv capacity_Gv capacity_Bv; 

clear ESF_Rh ESF_Gh ESF_Bh ESF_Rv ESF_Gv ESF_Bv...
    LSF_Rh LSF_Gh LSF_Bh LSF_Rv LSF_Gv LSF_Bv...
    MTF_Rh MTF_Gh MTF_Bh MTF_Rv MTF_Gv MTF_Bv...
    f_Rh f_Gh f_Bh f_Rv f_Gv f_Bv;
