%% ave_plot.m
% Plot average data for a specific mouse strain along with appropriate postmortem comparisons. 
% This replicates most panels in Figures 3-6 of Dewey et al. (2018).
% The input argument 'mouse' should be one of the following: 'C57BL6J','salsa','Triobp','CBACaJ', or 'Tecta'

function [] = ave_plot(mouse)

    %% Plotting parameters
    conds=[{'live'};{'dead'}]; % measurement conditions
    locs=[{'BM'};{'RL'};{'TM'}]; % measurement locations
    n_min = 2/3; % required fraction of mice with data above noise floor for plotting the average value.

    switch mouse
        case 'C57BL6J'
            % Plot 1. Live vibrations
            plt1(1).mouse = mouse; % mouse
            plt1(1).cond = 'live'; % condition
            plt1(1).levels = 10:10:80; % stimulus levels to plot
            plt1(1).clr = 'k'; % line color
            plt1_truncate = 0; % truncate axes? 1=yes

            % Plot 2. Live vs. dead vibrations
            plt2(1).mouse = mouse;
            plt2(1).cond = 'live';
            plt2(1).levels = 80;
            plt2(1).clr = 'k';

            plt2(2).mouse = mouse;
            plt2(2).cond = 'dead';
            plt2(2).levels = 50:10:80;
            plt2(2).clr = [0.75 0.75 0.75];
            plt2_truncate = 1;

        case 'salsa'
            % Plot 1. Live vibrations
            plt1(1).mouse = mouse;
            plt1(1).cond = 'live';
            plt1(1).levels = 50:10:80;
            plt1(1).clr = 'r';
            plt1_truncate = 1;

            % Plot 2. Dead vibrations compared with wild type        
            plt2(1).mouse = 'C57BL6J';
            plt2(1).cond = 'dead';
            plt2(1).levels = 80;
            plt2(1).clr = [0.75 0.75 0.75];

            plt2(2).mouse = mouse;
            plt2(2).cond = 'dead';
            plt2(2).levels = 80;
            plt2(2).clr = 'r';
            plt2_truncate = 1;

        case 'Triobp'
            % Plot 1. Live vibrations
            plt1(1).mouse = mouse;
            plt1(1).cond = 'live';
            plt1(1).levels = 50:10:80;
            plt1(1).clr = [10 118 230]/255;
            plt1_truncate = 1;

            % Plot 2. Dead vibrations compared with wild type
            plt2(1).mouse = 'C57BL6J';
            plt2(1).cond = 'dead';
            plt2(1).levels = 80;
            plt2(1).clr = [0.75 0.75 0.75];

            plt2(2).mouse = mouse;
            plt2(2).cond = 'dead';
            plt2(2).levels = 80;
            plt2(2).clr = [10 118 230]/255;
            plt2_truncate = 1;

        case 'CBACaJ'
            % Plot 1. Live vibrations
            plt1(1).mouse = mouse;
            plt1(1).cond = 'live';
            plt1(1).levels = 10:10:80;
            plt1(1).clr = 'k';
            plt1_truncate = 0;

            % Plot 2. Live vs. dead vibrations
            plt2(1).mouse = mouse;
            plt2(1).cond = 'live';
            plt2(1).levels = 80;
            plt2(1).clr = 'k';

            plt2(2).mouse = mouse;
            plt2(2).cond = 'dead';
            plt2(2).levels = 50:10:80;
            plt2(2).clr = [0.75 0.75 0.75];
            plt2_truncate = 1;

        case 'Tecta'
            % Plot 1. Live vibrations
            plt1(1).mouse = mouse;
            plt1(1).cond = 'live';
            plt1(1).levels = 50:10:80;
            plt1(1).clr = [253 171 42]/255;
            plt1_truncate = 1;

            % Plot 2. Dead vibrations compared with wild type
            plt2(1).mouse = 'CBACaJ';
            plt2(1).cond = 'dead';
            plt2(1).levels = 80;
            plt2(1).clr = [0.75 0.75 0.75];

            plt2(2).mouse = mouse;
            plt2(2).cond = 'dead';
            plt2(2).levels = 80;
            plt2(2).clr = [253 171 42]/255;
            plt2_truncate = 1;
    end

    % Plot dimensions (normalized units)
    pltW = 0.26; % panel width
    pltxMarg = 0.05; % panel margins (x-dimension)
    pltyMarg = 0.05; % panel margins (y-dimension)
    fntSz = 16; % font size for axis tick labels
    xlims = [1.8 12.8]; % frequency limits (x-axis)

    gainH = 0.5; % gain panel height
    gain_lims = [.08 4000]; % gain limits
    gain_lims_trunc = [0.08 20]; % truncated gain limits
    gain_trunc_scale = (20*log10(gain_lims_trunc(2)/gain_lims_trunc(1))) / (20*log10(gain_lims(2)/gain_lims(1))); % truncation scaling factor

    phiH = 0.32; % phase panel height
    phi_lims = [-4.75 0.25]; % phi limits (cycles)
    phi_lims_trunc = [-3.5 0.25]; % truncated phi limits
    phi_trunc_scale = (phi_lims_trunc(2)-phi_lims_trunc(1)) / (phi_lims(2)-phi_lims(1)); % truncation scaling factor


    %% PLOT 1. Live vibrations
    h1 = figure('units','normalized','position',[.1 .1 .6 .6]);

    if plt1_truncate % truncate axes?
        plt_gainH = gainH * gain_trunc_scale; % magnitude axis height
        plt_phiH = phiH * phi_trunc_scale; % phase axis height
    else
        plt_gainH = gainH;
        plt_phiH = phiH;
    end

    % Make panels for each measurement location (BM, RL, TM)
    for loc_i = 1:length(locs)
        loc = locs{loc_i};
        gain(loc_i).ax = axes('Position',[((loc_i-1)*(pltW+pltxMarg)+pltxMarg) .46 pltW plt_gainH]); hold all;
        phi(loc_i).ax = axes('Position',[((loc_i-1)*(pltW+pltxMarg)+pltxMarg) .46-plt_phiH-pltyMarg pltW plt_phiH]); hold all;

        % Gain
        axes(gain(loc_i).ax);
        set(gca,'FontSize',fntSz,'LineWidth',1, 'Xtick',[2 5 10],'Xticklabel',{'2','5','10'},'Xscale','log','Ytick', 10.^(-1:1:5),'Yscale','log','TickLength',[0.03 0.03]);
        ax1=gca;
        ax1.XRuler.MinorTickValues = [3 4 6 7 8 9 10 11 12 13 14];
        xlim(xlims);

        if plt1_truncate
            ylim(gain_lims_trunc);
        else
            ylim(gain_lims);
        end

        % Phase
        axes(phi(loc_i).ax);
        set(gca,'FontSize',fntSz,'LineWidth',1,'Xtick',[2 5 10],'Xticklabel',{'2','5','10'},'Xscale','log','TickLength',[0.03 0.03],'Ytick', -5:1:0,'Yticklabel',{'-5','-4','-3','-2','-1','0'});    
        ax2=gca;
        ax2.XRuler.MinorTickValues = [3 4 6 7 8 9 10 11 12 13 14];
        ax2.YAxis.MinorTick = 'on';
        ax2.YAxis.MinorTickValues = -5.5:0.5:.5;
        xlim(xlims);

        if plt1_truncate
            ylim(phi_lims_trunc);
        else
            ylim(phi_lims);
        end
    end

    % Plot data for each location
    for loc_i = 1:length(locs)
        loc = locs{loc_i}; % location

        for plt_i = 1:length(plt1)
            mouse = plt1(plt_i).mouse; % mouse
            cond = plt1(plt_i).cond; % condition
            clr = plt1(plt_i).clr; % color
            levels = plt1(plt_i).levels; % stimulus levels to plot

            load([mouse '.mat']); % load data

            d = data.(genvarname(cond)).(genvarname(loc)); % get data
            sz = size(d.gain_all);
            n=sz(3); % # of mice
            [~,amp_i] = ismember(levels,d.amp); % get indices of plotted stimulus levels 

            % Plot data starting at highest stimulus level
            for a_i = amp_i(end):-1:amp_i(1)
                % Set line width
                linesc = .5 + a_i*.25;
                if linesc < 0
                    linesc=.2;
                end

                % Organize/clean data
                gain_ave = d.gain_ave(:,a_i); % average gain
                gain_se = d.gain_se(:,a_i); % standard error
                gain_n = d.gain_n(:,a_i); % # mice contributing to average
                gain_ave(gain_n < n_min*n) = NaN; % only show average values when data are above noise floor in a sufficient # of mice

                phi_ave = d.phi_ave(:,a_i); % average phase
                phi_se = d.phi_se(:,a_i); % standard error
                phi_n = d.phi_n(:,a_i); % # mice contributing to average
                phi_ave(phi_n < n_min*n) = NaN; % only show average values when data are above noise floor in a sufficient # of mice

                % Plot gain
                axes(gain(loc_i).ax);
                errorbar(d.freq/1000,gain_ave,gain_se,'-','LineWidth',0.6,'color',clr, 'MarkerFaceColor',clr,'MarkerSize',1,'CapSize',2.5); hold all;
                plot(d.freq/1000,gain_ave,'-','LineWidth',linesc,'color',clr,'MarkerSize',8,'MarkerFaceColor','w'); hold all;

                % Plot phase
                axes(phi(loc_i).ax);
                errorbar(d.freq/1000,phi_ave/(2*pi),phi_se/(2*pi),'LineWidth',0.6,'color',clr, 'MarkerFaceColor',clr,'MarkerSize',1,'CapSize',2.5); hold all;
                plot(d.freq/1000,phi_ave/(2*pi),'LineWidth',linesc,'color',clr,'MarkerSize',8,'MarkerFaceColor','w'); hold all;
            end
        end
    end

    %% PLOT 2. Postmortem comparisons
    h2 = figure('units','normalized','position',[.1 .1 .6 .6]);

    if plt2_truncate
        plt_gainH = gainH * gain_trunc_scale; % magnitude axis height
        plt_phiH = phiH * phi_trunc_scale; % phase axis height
    else
        plt_gainH = gainH;
        plt_phiH = phiH;
    end

    % Make panels for each measurement location (BM, RL, TM)
    for loc_i = 1:length(locs)
        loc = locs{loc_i};
        gain(loc_i).ax = axes('Position',[((loc_i-1)*(pltW+pltxMarg)+pltxMarg) .46 pltW plt_gainH]); hold all;
        phi(loc_i).ax = axes('Position',[((loc_i-1)*(pltW+pltxMarg)+pltxMarg) .46-plt_phiH-pltyMarg pltW plt_phiH]); hold all;

        % Gain
        axes(gain(loc_i).ax);
        set(gca,'FontSize',fntSz,'LineWidth',1, 'Xtick',[2 5 10],'Xticklabel',{'2','5','10'},'Xscale','log','Ytick', 10.^(-1:1:5),'Yscale','log','TickLength',[0.03 0.03]);
        ax1=gca;
        ax1.XRuler.MinorTickValues = [3 4 6 7 8 9 10 11 12 13 14];
        xlim(xlims);

        if plt2_truncate
            ylim(gain_lims_trunc);
        else
            ylim(gain_lims);
        end

        % Phase
        axes(phi(loc_i).ax);
        set(gca,'FontSize',fntSz,'LineWidth',1,'Xtick',[2 5 10],'Xticklabel',{'2','5','10'},'Xscale','log','TickLength',[0.03 0.03],'Ytick', -5:1:0,'Yticklabel',{'-5','-4','-3','-2','-1','0'});    
        ax2=gca;
        ax2.XRuler.MinorTickValues = [3 4 6 7 8 9 10 11 12 13 14];
        ax2.YAxis.MinorTick = 'on';
        ax2.YAxis.MinorTickValues = -5.5:0.5:.5;
        xlim(xlims);

        if plt2_truncate
            ylim(phi_lims_trunc);
        else
            ylim(phi_lims);
        end
    end

    % Plot data for each location
    for loc_i = 1:length(locs)
        loc = locs{loc_i}; % location

        for plt_i = 1:length(plt2)
            mouse = plt2(plt_i).mouse; % mouse
            cond = plt2(plt_i).cond; % condition
            clr = plt2(plt_i).clr; % color
            levels = plt2(plt_i).levels; % stimulus levels to plot

            load([mouse '.mat']); % load data

            d = data.(genvarname(cond)).(genvarname(loc)); % get data
            [~,amp_i] = ismember(levels,d.amp); % get indices of plotted stimulus levels 

            % Plot data starting at highest stimulus level
            for a_i = amp_i(end):-1:amp_i(1) 
                % Set line width
                linesc = .5 + a_i*.25;
                if linesc < 0
                    linesc=.2;
                end

                % Organize/clean data
                gain_ave = d.gain_ave(:,a_i); % average gain
                gain_se = d.gain_se(:,a_i); % standard error
                gain_n = d.gain_n(:,a_i); % # mice contributing to average
                gain_ave(gain_n < n_min*n) = NaN; % only show average values when data are above noise floor in a sufficient # of mice

                phi_ave = d.phi_ave(:,a_i); % average phase
                phi_se = d.phi_se(:,a_i); % standard error
                phi_n = d.phi_n(:,a_i); % # mice contributing to average
                phi_ave(phi_n < n_min*n) = NaN; % only show average values when data are above noise floor in a sufficient # of mice

                % Eliminate lone data points
                for freq_i = 1:length(d.freq)
                    if freq_i > 1 && freq_i < length(d.freq)
                        if isnan(gain_ave(freq_i-1)) && isnan(gain_ave(freq_i+1))
                            gain_ave(freq_i) = NaN;
                            phi_ave(freq_i) = NaN;
                        end
                    elseif freq_i==1
                        if isnan(gain_ave(freq_i+1))
                            gain_ave(freq_i) = NaN;
                            phi_ave(freq_i) = NaN;
                        end
                    elseif freq_i==length(d.freq)
                        if isnan(gain_ave(freq_i-1))
                            gain_ave(freq_i) = NaN;
                            phi_ave(freq_i) = NaN;
                        end
                    end
                end

                % Plot gain
                axes(gain(loc_i).ax);
                errorbar(d.freq/1000,gain_ave,gain_se,'-','LineWidth',0.6,'color',clr, 'MarkerFaceColor',clr,'MarkerSize',1,'CapSize',2.5); hold all;
                plot(d.freq/1000,gain_ave,'-','LineWidth',linesc,'color',clr,'MarkerSize',8,'MarkerFaceColor','w'); hold all;

                % Plot phase
                axes(phi(loc_i).ax);
                errorbar(d.freq/1000,phi_ave/(2*pi),phi_se/(2*pi),'LineWidth',0.6,'color',clr, 'MarkerFaceColor',clr,'MarkerSize',1,'CapSize',2.5); hold all;
                plot(d.freq/1000,phi_ave/(2*pi),'LineWidth',linesc,'color',clr,'MarkerSize',8,'MarkerFaceColor','w'); hold all;
            end
        end
    end
end
