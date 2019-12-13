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
i = 2;
dataR = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 1);
dataG = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 2);
dataB = picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
    dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), 3);

clear dapic i;

% зазвичай в зображеннях створених вручну, RGB комоненти по інтенсивності
% рівні, але так як знімала реальна камера, то можливі варіації (вплив
% шумів) тобто в чб ці компоненти відрізнятимуться, тому можна взяти якесь
% значення - наприклад, середнє аврифметичне і т.д.
% але можна обрахувати і порівняти 3 компоненти між собою, що покаже як
% впливає на результуюче зображення кожен із фільтів, або покаже вплив
% довжини хвилі на МПФ, треба досліджувати...
% data = GetColorComponent(picture(dapic{i, 2}(1, 1) : dapic{i, 2}(2, 1),...
%     dapic{i, 2}(1, 2) : dapic{i, 2}(2, 2), :), 'AM');
% figure(1);
% imshow(data);
% figure(1);
% imshow(dataR);
% figure(2);
% imshow(rot90(dataR));
% figure(3);
% imshow(rot90(dataR, -1));

figure(1);
data = rot90(dataR, 2);
% data = dataR;
hold off;
imshow(data);
% image(data);

COM = CenterOfMassOne(data);
% COM = CenterOfMass(data, 'h');
% COM = CenterOfMass(data, 'v');
hold on;
plot(COM(1, :), COM(2, :));
% plot(COM(2, :), COM(1, :));




