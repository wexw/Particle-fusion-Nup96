load('data2save416.mat')
for figtype=1:3
    for type=1:6
        figure()
        for iter=1:10

            %Pure
            if figtype==1
                NRs{type,iter}=data2save{type,iter}.NR_pure_GD;
                CRs{type,iter}=data2save{type,iter}.CR_pure_GD;
                filename = ['ProjectionOfNPCWithNoOutliers' num2str(type) '.pdf']; % 设定导出文件名
                sgtitle('Projections of NPC with no outliers')
            end
            if figtype==2
                %%Filter Outliers Only with GMM
                filename = ['ProjectionOfNPCfilteredbyGMM' num2str(type) '.pdf'];
                NRs{type,iter}=data2save{type,iter}.NR_pure_G;
                CRs{type,iter}=data2save{type,iter}.CR_pure_G;
                sgtitle('Projections of NPC filtered by GMM')
            end
            %Original Reconstructions
            if figtype==3
                filename = ['ProjectionOfNPCOriginal' num2str(type) '.pdf'];
                NRs{type,iter}=data2save{type,iter}.NRall';
                CRs{type,iter}=data2save{type,iter}.CRall';
                sgtitle('Projections of Original NPC')
            end
            % %
            NPC=[];
            NPC=[NRs{type,iter};CRs{type,iter}]';


            for j=1:2
                data2c=[];
                if j==1
                    data2c=NRs{type,iter};
                else
                    data2c=CRs{type,iter};
                end


                size(data2c,2)
                % colordef white
                % set(0,'defaultfigurecolor','white')


                beta=0;

                renderprojection(data2c(:,1),data2c(:,2), -data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1);
                xlim([0, 160])
                ylim([0, 160])
                axis equal
                %     drawnow;
                axis off

                if j==1
                    title('NR')
                else
                    title('CR')
                end

                % copyobj(get(figure(2),'children'),gca)
                % title('Figure 2')
                %     f = getframe(gcf);



            end
            data2c=NPC(1:3,:)';

            % colordef white
            % set(0,'defaultfigurecolor','white')

            beta=90;

            renderprojection(data2c(:,1),data2c(:,2), -data2c(:,3), 0,beta,[-80 80],[-80 80],1,1, 1);
            xlim([0, 160])
            ylim([0, 160])
            zlim([0, 160])
            %axis equal
            axis off
            title(['D' num2str(type) ',Iter' num2str(iter)])
        end

        % % zHist(data2c(:,3),150);
        % % ylength=0.06*yline;
        % % line([xmax1,xmax2],[yline,yline],'color','k','linestyle','--','LineWidth',1)
        % % txt = [num2str(round(deltaxz,1)) '\pm' num2str(round(uncertainty,1)) ' nm'];
        % %
        % % text(33,yline,txt,'FontSize',20,'FontName','Arial','Color','k')
        % % line([xmax1,xmax1],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)
        % % line([xmax2,xmax2],[yline-ylength,yline+ylength],'color','k','linestyle','-','LineWidth',1)
        % %
        % % title(['\Deltaz=' num2str(round(deltaxz,1)) 'nm'])
        %     % % %     title(['\Deltaz=48.0 nm'])
        set(gcf,'position',[200,200,1100,1000])
        set(gcf,'Units','Inches');
        % set(gcf, 'InvertHardCopy', 'off');
        pause(3)
        pos = get(gcf,'Position');

        set(gcf,'PaperPositionMode','Auto','PaperUnits','inches','PaperSize',[pos(3), pos(4)-0.7])
        %
        print(gcf,filename,'-dpdf','-r0')

    end
end