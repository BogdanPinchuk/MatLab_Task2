function PresentInfo(data, com, ESF, ESFarray, LSF, MTF, f)
% Презентація інформації на графіку
% data - дані зображення
% com - центр мас або координати розташування сходинки
% ESF - крайова функція або функція краю
% ESFarray - масив краєвих функцій з якого визначається ESF
% LSF - функція розсіювання лінії
% MTF - модуляційна передавальна функція
% f - частота, роздільна здатність

% Відображення результатів

% Частина зображення, яке аналізується
subplot(2, 2, 1);
hold off;
imshow(data);
hold on;
plot(com(1, :), com(2, :), 'r', 'LineWidth', 2);

title('Pattern');

% ESF - крайова функція
subplot(2, 2, 2);
hold on;
for i = 1 : size(ESFarray, 1)
    plot(ESFarray(i, :), '.');
%     pause(1/250);
end
plot(ESF, 'LineWidth', 2);

xlim([1 size(ESF, 2)]);
ylim([0 1]);

% xticks(1 : 5 : size(ESF, 2));
yticks(0 : 0.2 : 1);

grid on;

title('ESF');
xlabel('Pixels');
ylabel('Intensity');

% LSF - функція розсіювання лінії
subplot(2, 2, 3);
hold on;
plot(LSF, 'LineWidth', 2);

xlim([1 size(LSF, 2)]);
ylim([0 1]);

yticks(0 : 0.2 : 1);

grid on;

title('LSF');
xlabel('Pixels');
ylabel('Intensity');

% MTF - модуляційна передавальна функція
subplot(2, 2, 4);
hold on;
plot(f, MTF, 'LineWidth', 2);

xlim([0 max(f)]);
ylim([0 1]);

yticks(0 : 0.2 : 1);

grid on;

title('MTF');
xlabel('lw/ph');
ylabel('Contrast');

end

