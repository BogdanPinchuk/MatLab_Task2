function PresentDiff(ESF_Rh, ESF_Gh, ESF_Bh, ESF_Rv, ESF_Gv, ESF_Bv,...
    LSF_Rh, LSF_Gh, LSF_Bh, LSF_Rv, LSF_Gv, LSF_Bv)
% Презентація відмінності між каналами
% за допомогою: ESF, LSF, MTF

% Відображення відмінності на крайових функціях
figure('Name','ESF show different between chanels',...
    'NumberTitle','off');
ESF_h = [ESF_Rh; ESF_Gh; ESF_Bh];
ESF_v = [ESF_Rv; ESF_Gv; ESF_Bv];
RMS_ESF_h = std(ESF_h, 1);
RMS_ESF_v = std(ESF_v, 1);
hold on;
grid on;
plot(RMS_ESF_h, 'LineWidth', 2, 'DisplayName', 'horizontal');
plot(RMS_ESF_v, 'LineWidth', 2, 'DisplayName', 'vertical');
legend('show');

title('ESF: RMS for RGB chanel');
xlabel('Pixels');
ylabel('Intensity');
xlim([1 max(size(RMS_ESF_h, 2), size(RMS_ESF_v, 2))]);

clear ESF_h ESF_v RMS_ESF_h RMS_ESF_v; 

% Відображення відмінності на функціях розсіювання лінії
figure('Name','LSF show different between chanels',...
    'NumberTitle','off');
LSF_h = [LSF_Rh; LSF_Gh; LSF_Bh];
LSF_v = [LSF_Rv; LSF_Gv; LSF_Bv];
RMS_LSF_h = std(LSF_h, 1);
RMS_LSF_v = std(LSF_v, 1);
hold on;
grid on;
plot(RMS_LSF_h, 'LineWidth', 2, 'DisplayName', 'horizontal');
plot(RMS_LSF_v, 'LineWidth', 2, 'DisplayName', 'vertical');
legend('show');

title('LSF: RMS for RGB chanel');
xlabel('Pixels');
ylabel('Intensity');
xlim([1 max(size(RMS_LSF_h, 2), size(RMS_LSF_v, 2))]);

clear LSF_h LSF_v RMS_LSF_h RMS_LSF_v; 

end

