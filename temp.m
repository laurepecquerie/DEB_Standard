function T = temp(t)
%---------------------------------------------------------------
  % Determine temperature at time t, 
  % Here we compute it as a sinus function to simulate a seasonal
  % temperature cycle
  %
  % t : scalar or n-vector of time points
  %
  % T : scalar or n-vector with temperature
  %
  % called by : main.m
  % 
  % 2013/03/15 - Laure Pecquerie
  %--------------------------------------------------------------
  
  T = 288 + 6 * sin(2 * pi * (t + 207)/ 365);

