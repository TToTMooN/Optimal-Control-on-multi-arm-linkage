function singlePendulum_draw_save_animation(q_data, T, isSaveAnimation, frameRate)
    %% Get q data and time data from simulation data, initialize
    singlePendulum_init;
    l = 2 * l;  
    thetadata = q_data;

    xee_data = l*cos(thetadata);
    yee_data = l*sin(thetadata);
    mov(1:length(T)) = struct('cdata', [], 'colormap', []);
    %% Draw animation
    figure(2);
    %draw first linkage
    linkage = zeros(2,2);
    linkage(:,1) = [0;0];
    linkage(:,2) = [xee_data(1);yee_data(1)];
    linkPlot = plot(linkage(1,:), ...
                    linkage(2,:), ...
                    '.-', 'MarkerSize', 20, 'LineWidth', 2);
    %Set axis
    axis equal;
    axis([-l l -l l]);
    %set title
    plotTitle = title(sprintf('Time: %0.2f sec', T(1)));
    tic;
    for ii=1:length(T)
       set(linkPlot(1),'XData',[0, xee_data(ii)], 'YData', [0,yee_data(ii)],'Color','Red');
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
        v = VideoWriter('single_link_animation.avi');
        v.FrameRate = frameRate;
        open(v);
        writeVideo(v,mov);
        close(v);
    end
    clear mov
end