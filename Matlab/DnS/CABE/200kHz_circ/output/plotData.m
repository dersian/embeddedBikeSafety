%#!/usr/bin/octave -qf
function plotData()
      figure;
      data = dlmread('./srp.csv',';',6,1);
      X = 0:1:358;
      Y = 25:25:20000;
      [grX,grY] = meshgrid(X,Y);
  	  h = surf(grX,grY,20*log10((data)));	
      set(h, 'edgecolor','none');
      colormap jet
end

