%% Machine Learning:HW1
clear all; clc; close all;
%% options
x_input = load('x2.mat');
t_target = load('t2.mat');
%load mydata2.mat;
%t = y;
x = x_input.x2;
t = t_target.t2;
x_training = x(1:80);
t_training = t(1:80);
x_testing = x(81:100);
t_testing = t(81:100);
opt_range_train  = 1:80; % CHANGE TRAINING RANGE HERE!
opt_range_test   = 1:20; 
opt_M  = 0:9;
opt_lambda = [0, 0.001, 0.1];
figure; 
plot(x_training,t_training,'bx',... 
    x_testing(opt_range_test),t_testing(opt_range_test),'go'); 
legend('train set','test set','regression','Location','southwest');
title('Original Data');
saveas(gcf, sprintf('Original-Data'), 'jpg');
figure_counter =1;

err_training = double([]);
err_testing = double([]);
%% start regression
for lambda=opt_lambda
    best = Inf;
    best_M = 0;
    figure(figure_counter);
    figure_counter = figure_counter +1;
    for M=opt_M
    %% generate w
    w = generate_w(opt_range_train,x_training,t_training,M, lambda);
    
    fname = strcat('M_',num2str(M),'_Lambda_',num2str(lambda),'_Train_',num2str(numel(opt_range_train)),'.txt');
    fileID = fopen(fname,'w');
    fprintf(fileID,'%.3f \n',w);
    fclose(fileID);
    %y =  w(1) + w(2)*sort_x + w(3)*sort_x.^2;
    %% prediction
    y_train = generate_y(w,x_training,opt_range_train,M);
    y_test = generate_y(w,x_testing,opt_range_test,M);
    %y = cat(1,y_train,y_test);
    %% error calculation
    err_training(M+1) = calculate_erms(y_train,t_training(opt_range_train),opt_range_train);
    err_testing(M+1) = calculate_erms(y_test,t_testing(opt_range_test),opt_range_train);
    if err_testing(M+1) < best 
        best = err_testing(M+1);
        best_M = M;
    end
    fname = strcat('RSME_M',num2str(M),'data_',num2str(numel(opt_range_train)),'_lambda_',num2str(lambda),'.txt');
    fileID = fopen(fname,'w');
    fprintf(fileID,' \n','Traing');
    fprintf(fileID,'%.3f %6s',err_training(M+1));
    fprintf(fileID,' \n','Testing');
    fprintf(fileID,'%.3f %6s',err_testing(M+1));
    fclose(fileID);
    %% plot regression
    %[sort_x_train new_index_train]=sort(x_training(opt_range_train));
    %[sort_x_test new_index_test]=sort(x_testing(opt_range_test));
    ax = linspace(min(x_training(opt_range_train)),max(x_training(opt_range_train)),300 );
    %ax = linspace(0,2,300);
    ay = generate_y(w,ax,1:300,M);
    %sort_x = cat(1,sort_x_train,sort_x_test);
    % disp('M = ');disp(M);
    % disp('W* = ');disp(w');
    subplot(2,5,M+1);
    plot(x_training(opt_range_train),t_training(opt_range_train),'bx',... 
    x_testing(opt_range_test),t_testing(opt_range_test),'go',...
    ax,ay,'r-'); 
    legend('train set','test set','regression','Location','southwest');
% plot(x_training(opt_range_train),t_training(opt_range_train),'bx',... 
%     ax,ay,'r-'); 
%     legend('train set','regression','Location','southwest');
    title(['data=' num2str(numel(opt_range_train)) ' lambda=' num2str(lambda) ' M= ' num2str(M)]);
    end
    
    %% plor errors
figure(figure_counter);
figure_counter = figure_counter +1;
axis = [0 1 2 3 4 5 6 7 8 9];
plot(axis,err_training,'-ob',axis,err_testing,'-sr');
legend('Error training','Error testing','Location','northwest');
title(['data=' num2str(numel(opt_range_train)) ' lambda=' num2str(lambda)]);
% best
% best_M
end






