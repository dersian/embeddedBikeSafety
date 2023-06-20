%#!/usr/bin/octave -qf
function plotData()
      figure;
      data = dlmread('./srp.csv',';',6,1);
      X = 0:1:358;
      Y = 25:25:20000;
      %% normalize responses here pre frequency, optional
      % This is done for visualisatiopn purposes only 
      for i=1:length(Y)
        max_val = max(data(i,:));
        data(i,:)=data(i,:)./max_val;
      end
      %%      
      [grX,grY] = meshgrid(X,Y);
  	  h = surf(grX,grY,20*log10((data)));	
      set(h, 'edgecolor','none');
      colormap jet
end

