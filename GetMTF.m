function [MTF] = GetMTF(LSF)
%Отримання МПФ
% LSF - функція розсіювання лінії
% MTF - модуляційна пеердавальна функція

% Отримаємо МПФ
MTF = abs(fft(LSF));

% змінюємо розмір
f = 1: fix(size(MTF, 2)/ 2) + 1;
MTF = MTF(f);

% Нормуємо МПФ
MTF = MTF / max(MTF);

% plot(f - 1, MTF);
% grid on;
% ylim([0 1]);

end

