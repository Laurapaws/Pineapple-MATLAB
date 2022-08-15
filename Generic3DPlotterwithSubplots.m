   % Prior to using this, three column vectors must be imported as x, y, and z
   % x represents frequency, y is your independant variable, and z should
   % be the impedance
   
[xx,yy]=meshgrid(0:0.9:max(x),0:1.25:max(y));   % Create grid to display heightmap on (min:step-size:max)
zz = griddata(x,y,z,xx,yy);                     % Something to do with applying this data to the meshgrid
figure(1);                                      % Create a window to display figure
subplot(3,2,[1 4])
s = surf(xx,yy,zz);                             % Create surface from meshgrid
set(gca,'ZScale','log');                        % Set the axis scale to be logarithmic
%set(gca,'XScale','log');                 
%set(gca,'YScale','log');                 
colorbar                                        % Display a colour bar legend
ax = gca;                                       % Simply setting a variable
ax.CLim = [0 950];                              % Set the colourbar to display min and max colours
set(gcf,'color','w');
xlabel('Frequency (MHz)');               
ylabel('Foil Width (cm)');                      % Add x y and z labels
zlabel('Impedance ({\Omega})');

            fSlice = 200;                       % Selected frequency
            lSlice = 10;                        % Distance through independant variable
            zSlice = 5;                         % Height of impedance cut-through
            sliceHeight = 300;                  % Height of vertical slices

intercept = interp2(xx,yy,zz,fSlice,lSlice);

mainTitle = 'Impedance of Aluminium Foil by Width';
title({
    [mainTitle] 
    [fSlice + "MHz, " + lSlice + "cm, and " + zSlice + "{\Omega} Slices" ] 
    ["Intercept: " + intercept + "{\Omega}"]
    });

map=    [0         0    0.5333
             0         0    0.7667
             0         0    1.0000
             0    0.1250    1.0000
             0    0.2500    1.0000
             0    0.3750    1.0000
             0    0.5000    1.0000
             0    0.6250    1.0000
             0    0.7500    1.0000
             0    0.8750    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
             0    1.0000    1.0000
        0.2000    1.0000    0.8000
        0.4000    1.0000    0.6000
        0.6000    1.0000    0.4000
        0.8000    1.0000    0.2000
        1.0000    1.0000         0
        1.0000    0.9444         0
        1.0000    0.8889         0
        1.0000    0.8333         0
        1.0000    0.7778         0
        1.0000    0.7222         0
        1.0000    0.6667         0
        1.0000    0.6111         0
        1.0000    0.5556         0
        1.0000    0.5000         0
        1.0000    0.4444         0
        1.0000    0.3889         0
        1.0000    0.3333         0
        1.0000    0.2778         0
        1.0000    0.2222         0
        1.0000    0.1667         0
        1.0000    0.1111         0
        1.0000    0.0556         0
        1.0000         0         0
        0.9767         0         0
        0.9533         0         0
        0.9300         0         0
        0.9067         0         0
        0.8833         0         0
        0.8600         0         0
        0.8367         0         0
        0.8133         0         0
        0.7900         0         0
        0.7667         0         0
        0.7433         0         0
        0.7200         0         0
        0.6967         0         0
        0.6733         0         0
        0.6500         0         0
        0.6267         0         0
        0.6033         0         0
        0.5800         0         0
        0.5567         0         0
        0.5333         0         0];

colormap(map)                           % set the colours that appear
shading interp                          % Interpolates the shading to make it smooth
hold on                                 % Enables the graph to be displayed with other elements
light;
lightangle(40,30);
lighting gouraud;

patch([(min(x)+1),max(x),max(x),(min(x)+1)],[(min(y)+1),(min(y)+1),max(y),max(y)],[zSlice,zSlice,zSlice,zSlice],[0.5 1 0.5],'FaceAlpha',0.5); %Impedance (z) slice
patch([fSlice,fSlice,fSlice,fSlice],[(min(y)+1),(min(y)+1),max(y),max(y)],[sliceHeight,(min(z)+1),(min(z)+1),sliceHeight],[0.5 1 0.5],'FaceAlpha',0.5); %Freq (x) slice
patch([(min(x)+1),(min(x)+1),max(x),max(x)],[lSlice,lSlice,lSlice,lSlice],[sliceHeight,1,1,sliceHeight],[0.5 1 0.5],'FaceAlpha',0.5); %Length/Other (y) slice


%%% Variable %%%
hold on;
%figure(2);
subplot(3,2,5)
[M1,c1] = contour(xx,zz,yy,[lSlice lSlice]);
%set(gca,'YScale','log');
c1.LineWidth = 1.7;
title({ ["Impedance vs Frequency at " + lSlice + "cm wide"]});
xlabel('Frequency (MHz)');               
ylabel('Impedance ({\Omega})');


%%% FREQUENCY %%%
hold on;
%figure(3);
subplot(3,2,6)
[M2,c2] = contour(zz,yy,xx,[fSlice fSlice]);
%set(gca,'XScale','log');
set ( gca,'ydir','reverse');
c2.LineWidth = 1.7;
title({ ["Impedance vs Width at " + fSlice + "MHz"]});
xlabel('Impedance ({\Omega})');
ylabel('Width (cm)');               
camroll(90);
