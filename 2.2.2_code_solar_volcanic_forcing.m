%  IPCC plot volcanic and solar RF
%  Author: Matthew Toohey
%  Created February 2019

%% definitions
volc_rf_file='D:\work\Projects\IPCC\IPCC_AR6_volcanic_SAOD_RF.xls';
solar_tsi_file='D:\work\Projects\IPCC\IPCC_AR6_solar_TSI.xls';

rf_factor=-25; % from AR5, hansen et al, 2005 for a 1/3 Pinatubo eruption. For Pinatubo, the value is -24.

% colors
orange = [0.8500    0.3250    0.0980];
blue   = [0.3010    0.7450    0.9330];


%% load data from saved xls files
%  all data are global mean annual mean values
%  Volcanic RF to be plotted here based on AOD in files and rf_factor given above, not on RF
%  included in file. 

[cm6_ndata, cm6_text, cm6_alldata] = xlsread(volc_rf_file,'CMIP6_hist');
cm6_year=cm6_ndata(:,1);
cm6_aod=cm6_ndata(:,2);
cm6_rf=rf_factor*cm6_aod;

[evo_ndata, evo_text, evo_alldata] = xlsread(volc_rf_file,'eVolv2k');
evo_year=evo_ndata(:,1);
evo_aod=evo_ndata(:,2);
evo_rf=rf_factor*evo_aod;

[sato_ndata, sato_text, sato_alldata] = xlsread(volc_rf_file,'Sato_2002');
sato_year=sato_ndata(:,1);
sato_aod=sato_ndata(:,2);
sato_rf=rf_factor*sato_aod;

[pmip_ndata, pmip_text, pmip_alldata] = xlsread(solar_tsi_file,'C14_TSI_PMIP4');
pmip_year=pmip_ndata(:,1);
pmip_tsi=pmip_ndata(:,2);

[cm6_solar_ndata, cm6_solar_text, cm6_solar_alldata] = xlsread(solar_tsi_file,'CMIP6_TSI');
cm6_solar_year=cm6_solar_ndata(:,1);
cm6_solar_tsi=cm6_solar_ndata(:,2);

[cm5_solar_ndata, cm5_solar_text, cm5_solar_alldata] = xlsread(solar_tsi_file,'CMIP5_TSI');
cm5_solar_year=cm5_solar_ndata(:,1);
cm5_solar_tsi=cm5_solar_ndata(:,2);


%% Figure
ind=find(cm6_solar_year<2015); % only solar data before 2015 is based on observations

figure

% Solar -500 to present
ax1= axes('Position',[0.1100    0.5838    0.49    0.36]);

plot(pmip_year,pmip_tsi)
hold on
plot(cm6_solar_year(ind),cm6_solar_tsi(ind),'k')
xlim([-500 2020])
ylabel('Total Solar Irradiance (W m^{ -2})')
xlabel('Year')
subplot_label('a',0.2);
ax1.XMinorTick='on';
ax1.XAxis.MinorTickValues = -500:100:2020;
ax1.YMinorTick='on';
ax1.YAxis.MinorTickValues = 1360:0.25:1362.5;

% Solar historical (1850-2014)
ax2= axes('Position',[0.7257    0.5838    0.1793    0.36]);

plot(cm5_solar_year,cm5_solar_tsi-5,'Color',orange)
hold on
plot(cm6_solar_year(ind),cm6_solar_tsi(ind),'k')
xlim([1850 2020])
ylabel('Total Solar Irradiance (W m^{ -2})')
xlabel('Year')
subplot_label('b',0.3);
ax2.XMinorTick='on';
ax2.XAxis.MinorTickValues = 1850:10:2020;
ax2.TickLength=[0.02 0.05];
ax2.YMinorTick='on';
ax2.YAxis.MinorTickValues = 1360:0.25:1362.5;

% Volcanic -500 to present
ax3= axes('Position',[0.1100    0.1100    0.49    0.36]);

[AX,H1,H2]=plotyy(evo_year,evo_rf,0,0);
hold on
plot(AX(1),cm6_year,cm6_rf,'k')
xlim(AX,[-500 2020])
set(AX(1),'YColor',[0 0 0],'YTick',[-12:2:0])
ylabel('Radiative Forcing (W m^{ -2})')
ylim(AX(1),[-12 0.2])
ylim(AX(2),-[-12 0.2]/rf_factor)
set(AX(2),'YTick',[-0.4:0.1:0],'YTickLabel',[0.4:-0.1:0],'YColor',[0 0 0])
ylabel(AX(2),'Stratospheric Aerosol Optical Depth')
box(AX(1),'off')
set(AX(2),'xaxisloc','top','xticklabel',[]);
AX(2).XAxis.Visible = 'on';
xlabel('Year')
subplot_label('c',0.175);
ax3.XMinorTick='on';
ax3.XAxis.MinorTickValues = -500:100:2020;
AX(2).XMinorTick='on';
AX(2).XAxis.MinorTickValues=-500:100:2020;
AX(2).YMinorTick='on';
AX(2).YAxis.MinorTickValues=-0.5:0.025:0;
AX(1).YMinorTick='on';
AX(1).YAxis.MinorTickValues=-12:0.5:0.1;

% Volcanic historical (1850-2016)
ax4= axes('Position',[0.7257    0.1100    0.1793    0.36]);

[AX,H1,H2]=plotyy(sato_year,sato_rf,0,0);
set(H1,'Color',orange);
hold on
plot(AX(1),cm6_year,cm6_rf,'k')
xlim(AX(1),[1850 2020]);
xlim(AX(2),[1850 2020]);
set(AX(1),'YColor',[0 0 0],'YTick',[-4:0.5:0])
ylabel(AX(1),'Radiative Forcing (W m^{ -2})')
ylim(AX(1),[-4 0.2]);
ylim(AX(2),-[-4 0.2]/rf_factor)
set(AX(2),'YTick',[-0.2:0.05:0],'YTickLabel',[0.2:-0.05:0],'YColor',[0 0 0])
ylabel(AX(2),'Stratospheric Aerosol Optical Depth')
box(AX(1),'off')
set(AX(2),'xaxisloc','top','xticklabel',[]);
AX(2).XAxis.Visible = 'on';
xlabel('Year')
subplot_label('d',0.3);
ax4.XMinorTick='on';
ax4.XAxis.MinorTickValues = 1850:10:2020;
AX(2).XMinorTick='on';
AX(2).XAxis.MinorTickValues = 1850:10:2020;
AX(1).TickLength=[0.02 0.05];
AX(2).TickLength=[0.02 0.05];
AX(2).YMinorTick='on';
AX(2).YAxis.MinorTickValues=-0.16:0.01:0.02;
AX(1).YMinorTick='on';
AX(1).YAxis.MinorTickValues=-4:0.25:0.1;

set(findall(gcf,'-property','FontSize'),'FontSize',7)
axes(ax1)
subplot_label('a',0.175)
set(findall(gcf,'-property','FontSize'),'FontSize',7)
set(gcf,'WindowStyle','normal','PaperPosition',[0 0 18 10])
print(gcf,'-r200','-dpng',['D:\work\Projects\IPCC\Forcing_figure_4panel_v2']);

print(gcf,'-depsc2',['D:\work\Projects\IPCC\Forcing_figure_4panel_v2']);
