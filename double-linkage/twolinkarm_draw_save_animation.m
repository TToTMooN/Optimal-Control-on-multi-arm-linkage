function twolinkarm_draw_save_animation(q_data, T, isSaveAnimation)
    %% Get q data and time data from simulation data, initialize
    twolinkarm_init;
    l1 = 2*l1;
    l2 = 2*l2;    
    theta1_data = q_data(:,1);
    theta2_data = q_data(:,2);
    xm_data = l1*cos(theta1_data);
    ym_data = l1*sin(theta1_data);
    xee_data = l1*cos(theta1_data)+l2*cos(theta1_data+theta2_data);
    yee_data = l1*sin(theta1_data)+l2*sin(theta1_data+theta2_data);
    mov(1:length(T)) = struct('cdata', [], 'colormap', []);
    %% Draw animation
    figure(1);
    %draw first linkage
    linkage1 = zeros(2,2);
    linkage1(:,1) = [0;0];
    linkage1(:,2) = [xm_data(1);ym_data(1)];
    %draw second linkage
    linkage2 = zeros(2,2);
    linkage2(:,1) = [xm_data(1);ym_data(1)];
    linkage2(:,2) = [xee_data(1);yee_data(1)];
    linkPlot = plot([linkage1(1,:); linkage2(1,:)], ...
                    [linkage1(2,:); linkage2(2,:)], ...
                    '.-', 'MarkerSize', 20, 'LineWidth', 2);
    %Set axis
    axis equal;
    axis([-(l1+l2) (l1+l2) -(l1+l2) (l1+l2)]);
    %set title
    plotTitle = title(sprintf('Time: %0.2f sec', T(1)));
    tic;
    for ii=1:length(T)
       set(linkPlot(1),'XData',[0, xm_data(ii)], 'YData', [0,ym_data(ii)],'Color','Red');
       set(linkPlot(2),'XData',[xm_data(ii), xee_data(ii)], 'YData', [ym_data(ii),yee_data(ii)],'Color','Blue');
       set(plotTitle, 'String', sprintf('Time: %0.2f sec', T(ii)));
       if ii>1
           line([xee_data(ii-1),xee_data(ii)],[yee_data(ii-1),yee_data(ii)],'Color','k','LineWidth',1);
       end
       drawnow;
       mov(ii) = getframe(gcf);
    end
    fprintf('Total time: %0.2f sec', toc);
    %% Save animation
    if isSaveAnimation
        v = VideoWriter('2link_animation.avi');
        open(v);
        writeVideo(v,mov)
        close(v);
    end
    clear mov
end