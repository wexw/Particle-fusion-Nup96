%F_measure_E_and_A
clc
clear
addpath('functions')
load('E_Rings_NGD.mat')
color=[252 41 30
    250 200 205
    219 249 244
    54 195 201
    0 70 222
    92 158 173
    255 170 50
    124 187 0
    ]./255;
for type=1:6
    for rlabel=1:2
        X=[];
        X=Rings_NGD{type,rlabel};
        densitydraw=X(:,5)';
        XF=[];
        XF=X;
        itera=0;
        itera=itera+1;

        RingA=XF(:,1:3);
        densityA=XF(:,5);

        par =RingA;
        
        [lab,centers] = kmedoids(par,8,'replicates',5);     % cluster the localizations of 8 blobs (using the medians)
        
        for i=1:1:8
            blob{1,i}=RingA(find(lab(:)==i),:);

        end
         f=figure()
        A = fitEllipse(centers(:,1),centers(:,2),f);        % fit ellipse to the 8 centers
        % if you remove the axis variable f, the elliptical fit is not plotted
        [A.long_axis/A.short_axis A.short_axis/A.long_axis]
        % the ellipticity, in two different conventions
        a=A.long_axis/A.short_axis;
        b=A.short_axis/A.long_axis;
        
        phi=A.phi;
        cos_phi = cos( phi );
        sin_phi = sin( phi );
        R = [ cos_phi sin_phi; -sin_phi cos_phi ];
        bA=A.b;
        aA=A.a;
        X0A=A.X0_in;
        Y0A=A.Y0_in;
        
        for i=1:1:8
            x1=[];
            x1=blob{1,i};
            scatter(x1(:,1),x1(:,2),1,color(i,:))
            hold on
            B=fitEllipse(blob{1,i}(:,1),blob{1,i}(:,2),f);
            blobEllipseRing{1,i}=fitEllipse(blob{1,i}(:,1),blob{1,i}(:,2),f);
            blobEllipseRing{1,i}.area=pi*blobEllipseRing{1,i}.a* blobEllipseRing{1,i}.b;
            blobEllipseRing{1,i}.c=abs(blobEllipseRing{1,i}.a^2-blobEllipseRing{1,i}.b^2)^0.5;
            txtangle=[num2str(blobEllipseRing{1,i}.area,'%.4f') 'nm^2'];
            text(centers(i,1)+2,centers(i,2),txtangle)
            [TPoint]=R^(-1)*[blobEllipseRing{1,i}.X0_in;blobEllipseRing{1,i}.Y0_in];
            Xt=TPoint(1,1);
            Yt=TPoint(2,1);
            bt=B.b;
            
            [Xtt]=R*TPoint;
            %-bA^2*Xt/aA^2/Yt*(Xt-10-Xt)+Yt
            tan_line= [ [Xt-10 Xt+10]; [-bA^2*Xt/aA^2/Yt*(Xt-bt-Xt)+Yt -bA^2*Xt/aA^2/Yt*(Xt+bt-Xt)+Yt] ];%[bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt-10) bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt+10)]
            new_tan_line= R*tan_line;
            
            tanline=new_tan_line(:,1)-new_tan_line(:,2);
            longaxis=blobEllipseRing{1,i}.longaxisline(:,1)-blobEllipseRing{1,i}.longaxisline(:,2);
            testtanline=tanline;
            testlongaxis=longaxis;
            if tanline(2,1)<0
                testtanline=-tanline;
            end
            if longaxis(2,1)<0
                testlongaxis=-longaxis;
            end
            blobEllipseRing{1,i}.Angle=(atan2(testlongaxis(2,1),testlongaxis(1,1))-atan2(testtanline(2,1),testtanline(1,1)))*180/pi;
            angleTest(i)=(atan2(testlongaxis(2,1),testlongaxis(1,1))-atan2(testtanline(2,1),testtanline(1,1)))*180/pi;
        end
%         averageangle(itera,:)=[effectiveParticlesNumber,scaled,Densityboundary,mean(angleTest),std(angleTest)];
%         
%         
        f=figure()
        %title('Figures for bottom ring')
        tiledlayout(2,2,'TileSpacing','Compact');
        % t.Units = 'inches';
        % t.OuterPosition = [0.25 0.25 10 10];
        nexttile
        scatter(X(:,1),X(:,2),2,densitydraw,'.')
        colormap(hot);
        colordef black
        zlim([-100 100])
        xlim([-100 100])
        ylim([-100 100])
        axis equal
        title(['ring of' num2str(type) ' datasets;' num2str(size(X,1)) ' localizations'])
        
        nexttile
        %scatter(par(:,1),par(:,2),'k.')
        hold on
        axis equal
        scatter(centers(:,1),centers(:,2),'o','filled')
        hold on
        for i=1:1:8
            x1=[];
            x1=blob{1,i};
            scatter(x1(:,1),x1(:,2),1,color(i,:))
            B=fitEllipse(blob{1,i}(:,1),blob{1,i}(:,2),f);
        end
        axis equal
        hold off
%         title([num2str(size(Ring,1)) ' remaining localizations,Density threshold=' num2str(Densityboundary,'%.4f') ])
%         
%         
        
        nexttile
        %scatter(x1(:,1),x1(:,2),'b.')
        %scatter(par(:,1),par(:,2),'k.')
        
        hold on
        scatter(centers(:,1),centers(:,2),'o','filled')
        hold on
        for i=1:1:8
            x1=[];
            x1=blob{1,i};
             hold on
            blobEllipseRing{1,i}=fitEllipse(blob{1,i}(:,1),blob{1,i}(:,2),f);
            blobEllipseRing{1,i}.area=pi*blobEllipseRing{1,i}.a* blobEllipseRing{1,i}.b;
            blobEllipseRing{1,i}.c=abs(blobEllipseRing{1,i}.a^2-blobEllipseRing{1,i}.b^2)^0.5;
            txtangle=[num2str( roundn(blobEllipseRing{1,i}.short_axis/ blobEllipseRing{1,i}.long_axis,-2))];
            esave(i)=blobEllipseRing{1,i}.short_axis/ blobEllipseRing{1,i}.long_axis;
            text(centers(i,1)+2,centers(i,2),txtangle)
        end
        hold on
        axis equal
        
        A = fitEllipse(centers(:,1),centers(:,2),f);        % fit ellipse to the 8 centers
        % if you remove the axis variable f, the elliptical fit is not plotted
        [A.long_axis/A.short_axis A.short_axis/A.long_axis];
        % the ellipticity, in two different conventions
        a=A.long_axis/A.short_axis;
        b=A.short_axis/A.long_axis;
        hold on
        %figure()
        title(['Ellipticity of each ellipse, ' num2str(roundn(mean(esave),-2)) '\pm' num2str(roundn(std(esave),-2))])
        
        
        
        
        nexttile
        %f=figure()
        
        phi=A.phi;
        cos_phi = cos( phi );
        sin_phi = sin( phi );
        R = [ cos_phi sin_phi; -sin_phi cos_phi ];
        bA=A.b;
        aA=A.a;
        X0A=A.X0_in;
        Y0A=A.Y0_in;
        scatter(centers(:,1),centers(:,2),'o','filled')
        hold on
        for i=1:1:8
            hold on
            B=fitEllipse(blob{1,i}(:,1),blob{1,i}(:,2),f);
            [TPoint]=R^(-1)*[blobEllipseRing{1,i}.X0_in;blobEllipseRing{1,i}.Y0_in];
            Xt=TPoint(1,1);
            Yt=TPoint(2,1);
            bt=B.b;
            
            [Xtt]=R*TPoint;
            %-bA^2*Xt/aA^2/Yt*(Xt-10-Xt)+Yt
            tan_line= [ [Xt-10 Xt+10]; [-bA^2*Xt/aA^2/Yt*(Xt-bt-Xt)+Yt -bA^2*Xt/aA^2/Yt*(Xt+bt-Xt)+Yt] ];%[bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt-10) bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt+10)]
            new_tan_line= R*tan_line;
            plot( new_tan_line(1,:),new_tan_line(2,:),'y','LineWidth',2);
            tanline=new_tan_line(:,1)-new_tan_line(:,2);
            longaxis=blobEllipseRing{1,i}.longaxisline(:,1)-blobEllipseRing{1,i}.longaxisline(:,2);
            %  blobEllipseBottom{1,i}.Angle=acos(abs(dot(tanline,longaxis))/(norm(tanline)*norm(longaxis)))/pi*180;
            %txt=['\leftarrow Area:' num2str(blobEllipse{1,i}.area,'%.2f') ' Angle:' num2str(blobEllipse{1,i}.Angle,'%.2f') '^o'];
            %blobEllipseBottom{1,i}.Angle=acos(dot(tanline,longaxis)/(norm(tanline)*norm(longaxis)))/pi*180;
            % anglerecord(i)=acos(dot(tanline,longaxis)/(norm(tanline)*norm(longaxis)))/pi*180;
            testtanline=tanline;
            testlongaxis=longaxis;
            if tanline(2,1)<0
                testtanline=-tanline;
            end
            if longaxis(2,1)<0
                testlongaxis=-longaxis;
            end
            blobEllipseRing{1,i}.Angle=(atan2(testlongaxis(2,1),testlongaxis(1,1))-atan2(testtanline(2,1),testtanline(1,1)))*180/pi;
            if blobEllipseRing{1,i}.Angle>90
                blobEllipseRing{1,i}.Angle=blobEllipseRing{1,i}.Angle-180;
            end
                 if blobEllipseRing{1,i}.Angle<-90
                blobEllipseRing{1,i}.Angle=blobEllipseRing{1,i}.Angle+180;
            end
            txtangle=[num2str(blobEllipseRing{1,i}.Angle,'%.2f') '^o'];
            text(centers(i,1)+2,centers(i,2),txtangle)
            asave(i)=blobEllipseRing{1,i}.Angle;
        end
        axis equal
        title(['Angles, ' num2str(roundn(mean(asave),-2)) '\pm' num2str(roundn(std(asave),-2)) '^o'])
        AnglesMean(type,rlabel)=roundn(mean(asave),-2);
        AnglesStd(type,rlabel)=roundn(std(asave),-2);
        EsMean(type,rlabel)=roundn(mean(esave),-2);
        EsStd(type,rlabel)=roundn(std(esave),-2);
        %saveas(f,'-djpg',filenameFigurep)
    end
end
save("F_AandE.mat","EsMean","EsStd","AnglesMean","AnglesStd")