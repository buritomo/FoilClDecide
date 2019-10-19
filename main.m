% •½–ÊŒ`‚©‚çCL‚ðŠ„‚èo‚·
clear all
close all

makeData;
affectiveLift;
loadTheoryCL;

dif_Lift = (Lift).' - Liftmap;
sum_dif = abs(sum(dif_Lift(2:N, 1)));

while sum_dif > 0.01
  clear all
  makeData;
  DataList = (load('OutPut.csv'));
  m = DataList(:, 5);
  affectiveLift;
  loadTheoryCL;
  dif_Lift = (Lift).' - Liftmap;
  sum_dif = abs(sum(dif_Lift(2:N, 1)));
endwhile

