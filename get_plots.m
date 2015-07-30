function get_plots(simu)

  par = simu.par; % parameters
  E_Hp = par(14);
  K = par(22); 
  Em = par(5) / par(6); % J/cm^3  [Em] = pAm / v

  % time , environmental forcing
  t = simu.tEVHR(:,1);
  
  if simu.envX == 1 
          X = repmat(simu.Xinit, 1, length( t ) );
  else
      X = food(t);
  end
  
  if simu.envT == 1
          T = repmat(simu.Tinit, 1, length( t) ) - 273; % in DegC
  else
          
          T = temp(t) - 273;  
  end
  
  f = X ./ (X + K); %scaled functional response
  
  % state variables
  E = simu.tEVHR(:,2);
  V = simu.tEVHR(:,3);
  E_H = simu.tEVHR(:,4);
  E_R = simu.tEVHR(:,5);
  
  sc_res_dens = E ./ ( V * Em); % -, scaled reserve density e
  
  % spawning date indices
  i_sp = find(and((E_R == 0),(E_H>=E_Hp)));
  i_sp = i_sp - 1 ; % look at the preceding line with E_R value before spawning
  
   
  % observable quantities
  Lw = simu.obs(:,2);
  Ww = simu.obs(:,3);
  Ew = simu.obs(:,4);
  F  = simu.obs(:,5);
  
  
  % graph
  nfig = 7; % number of figures
  for i = 1:nfig
    figure(i)
    set(gcf,'PaperPositionMode','manual');
    set(gcf,'PaperUnits','in');
    %left bottom width height
    set(gcf,'PaperPosition',[0 0 14 10]); 
    %set(gcf,'PaperPosition',[0 0 3.5 3]);
    set(gca,'Fontsize',14)
  end
  
  figure(1)
  subplot(3, 4, 1)
  hold on
  plot( t, T, simu.col, 'Linewidth',1.5)
  title('Temperature')
  xlabel('Time (d)')
  ylabel('T (°C)')
  axis([0 t(end) 0 25])

  subplot(3,4, 2)
  hold on
  plot( t, X , simu.col, 'Linewidth',1.5)
  title('Food')
  xlabel('Time (d)')	
  ylabel( 'Food density (units up to you)')
  
  
  subplot(3,4,4)
  hold on
  plot( t, f, simu.col, 'Linewidth',1.5)
  plot( t, sc_res_dens, [simu.col ':'], 'Linewidth',1.5)
  axis([0 t(end) 0 1.7])
  title('Scaled reserve density')
  xlabel('Time (d)')
  ylabel('e (-)')
  
  % E Reserve energy
  subplot(3, 4, 5)
  hold on
  plot(t, E,  simu.col, 'Linewidth',1.5)
  title('Reserve energy')
  xlabel('Time (d)')
  ylabel('E (J)')
  
  
  % V
  subplot(3, 4, 6)
  hold on
  plot(t, V, simu.col, 'Linewidth',1.5)
  title('Structural volume')
  xlabel('Time (d)')
  ylabel('V (cm^3)')
  
  % E_H
  subplot(3, 4, 7)
  hold on
  plot(t, E_H, simu.col, 'Linewidth',1.5)
  title('Cumulated energy invested into maturation')
  xlabel('Time (d)')
  ylabel('E_H (J)')
  
  % E_R
  subplot(3, 4, 8)
  hold on
  plot(t, E_R, simu.col , 'Linewidth',1.5)
  title('Reproduction buffer (J)')
  xlabel('Time (d)')
  ylabel('E_R (J)')
  
  % Lw
  subplot(3, 4, 9)
  hold on
  plot(t, Lw, simu.col , 'Linewidth',1.5)
  title('Physical length (cm)')
  xlabel('Time (d)')
  ylabel(' Lw (cm)')
  
 
  % Ww_
  subplot(3, 4, 10)
  hold on
  plot(Lw, Ww, simu.col , 'Linewidth',1.5)
  title('Weight-Length')
  xlabel('Lw (cm)')
  ylabel('Ww (g)')
  
   % Ew
  subplot(3, 4, 11)
  hold on
  plot(t, Ew, simu.col , 'Linewidth',1.5)
  title('Weight-specific energy content (J/g)')
  xlabel('Time (d)')
  ylabel('<Ew> (J.g^{-1})')

  % F
  subplot(3, 4, 12)
  hold on
  plot(Lw(i_sp), F(i_sp), [simu.col '+'] , 'Linewidth',1.5)
  title('Fecundity-Length')
  xlabel('Lw (cm)')
  ylabel('F (#)')
 
  saveas(gcf, 'fig_DEB_standard.tiff', 'tiff') 
  % other ways to save the graph
  % saveas(gcf, 'fig_DEB_standard.eps', 'psc2')
  % print -djpeg90 fig_DEB_standard.jpg 

  figure(2) % T
  hold on
  plot( t/365, T, simu.col, 'Linewidth',1.5)
  title('Temperature')
  xlabel('Time (years)')
  ylabel('T (°C)')
  axis([0 t(end)/365 0 25])
  saveas(gcf, 'fig_T.tiff', 'tiff') 
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(a)','Fontsize',12)

  
  figure(3)
  hold on
  plot( t/365, X , simu.col, 'Linewidth',1.5)
  xlabel('Time (years)')	
  ylabel( 'Food density ')
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(b)','Fontsize',12)

   % Lw
  figure(4)
  hold on
  plot(t/365, Lw, simu.col , 'Linewidth',1.5)
  xlabel('Time (years)')
  ylabel(' Length (cm)')
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(a)','Fontsize',12)

 
  % Ww_
  figure(5)
  hold on
  plot(Lw, Ww, simu.col , 'Linewidth',1.5)
  xlabel('Length (cm)')
  ylabel('Wet weight (g)')
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(b)','Fontsize',12)

   % Ew
  figure(6)
  hold on
  plot(t/365, Ew, simu.col , 'Linewidth',1.5)
  xlabel('Time (years)')
  ylabel('Weight-specific energy content (J.g^{-1} ww)')
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(c)','Fontsize',12)

  % F
  figure(7)
  hold on
  plot(Lw(i_sp), F(i_sp), [simu.col '+'] , 'Linewidth',1.5)
  xlabel('Length (cm)')
  ylabel('Fecundity (#)')
  axis([0 max(Lw(i_sp)) 0 max(F(i_sp))])
  v = axis;
  text((v(2)-v(1)) * 0.07 + v(1), (v(4)-v(3)) *.9 + v(3), '(d)','Fontsize',12)
