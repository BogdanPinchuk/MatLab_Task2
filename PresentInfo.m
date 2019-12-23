function PresentInfo(data, com, ESF, ESFarray, LSF)
% ����������� ���������� �� �������
% data - ��� ����������
% com - ����� ��� ��� ���������� ������������ ��������
% ESF - ������� ������� ��� ������� ����
% ESFarray - ����� ������ ������� � ����� ����������� ESF
% LSF - ������� ���������� ��

% ³���������� ����������
% figure(1);
% ������� ����������, ��� ����������
subplot(2, 2, 1);
hold off;
imshow(data);
hold on;
plot(com(1, :), com(2, :), 'r', 'LineWidth', 2);

title('Pattern');

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

subplot(2, 2, 3);
hold on;
plot(LSF, 'LineWidth', 2);

xlim([1 size(LSF, 2)]);
% ylim([0 max(LSF)]);

yticks(0 : 0.2 : 1);

grid on;

title('LSF');
xlabel('Pixels');
ylabel('Intensity');



end

