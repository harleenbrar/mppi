figure, set(gcf, 'Color','white')
set(gca, 'nextplot','replacechildren', 'Visible','off');

time   = E.horizon;
mp     = E.mp;
mc     = E.mc;
l      = 2*E.l;

T = 0:dt:horizon;

x_traj(1,:) = x_trajectory(1,1:length(T),1);
x_traj(2,:) = x_trajectory(1,1:length(T),2);
x_traj(3,:) = -1*x_trajectory(1,1:length(T),3);
x_traj(4,:) = x_trajectory(1,1:length(T),4);


name = 'Double Cart Pole Animation';

for k = 1:length(x_traj)
%     figure()
%     h = gca;
%     hold on
%     set([gcf gca],'Visible','off')
    clf
    axes
    axis equal
    hold on
    grid on
    fill(([-.5 .5 .5 -.5 -.5]-x_traj(3,k)), [0 0 .8 .8 0], [0 152/255 153/255])
    
    plot([-x_traj(3,k), -x_traj(3,k) + l*sin(x_traj(1,k))], [0.4, 0.4-l*cos(x_traj(1,k))], 'k', 'LineWidth', 3)
    
    rectangle('Position',[(-x_traj(3,k) + l*sin(x_traj(1,k))-0.25*sin(pi/4)),(0.4-l*cos(x_traj(1,k))-0.25*cos(pi/4)),0.35,0.35],'Curvature',[1,1],...
        'FaceColor',[150/255 0 0])
    
%     rectangle('Position',[(-x_traj(3,k) + l*sin(x_traj(1,k)) - 0.25*sin(pi/4)),(0.4+l*cos(x_traj(1,k))-0.25*cos(pi/4)),0.35,0.35],'Curvature',[1,1],...
%         'FaceColor',[150/255 0 0])
    
    xlim([-6 6])
    ylim([-4 4])
    title({name ;['Time: ' num2str(T(k))]})
    legend(['Cart Mass = ' num2str(mc) ' kg'],['1st Link Mass = ' num2str(mp) ' kg'],'Location','southeast')
    MM(k) = getframe(gcf);
end
figure
axis off
movie(MM,1,length(x_traj)/time)

%Save to an avi file
writerObj = VideoWriter([name '.avi'],'Motion JPEG AVI');
% MM(1) = [];
open(writerObj);
writeVideo(writerObj,MM)
close(writerObj)