if drawfigure==1
    f=figure()
end
blob=[];
for rlabel=1:2
    XF=[];
    if rlabel==1
        XF=data2process.NR_pure_GD;
    else
        XF=data2process.CR_pure_GD;
    end
    lab=XF(:,6);
    densitydraw=XF(:,5)';

    RingA=[];

    RingA(:,3)=XF(:,3);
    RingA(:,1)=XF(:,2);
    RingA(:,2)=XF(:,1);
    %Find te center of each blob
    for i=1:1:8
        blob{rlabel,i}=RingA(find(lab(:)==i),:);
        par=blob{rlabel,i};
        [~,centers(i,:)] = kmedoids(par,1,'replicates',5);
    end
    %A is the ellipse of the ring
    A = fitEllipse(centers(:,1),centers(:,2));        % fit ellipse to the 8 centers
    % if you remove the axis variable f, the elliptical fit is not plotted
    [A.long_axis/A.short_axis A.short_axis/A.long_axis];
    % the ellipticity, in two different conventions
    a=A.long_axis/A.short_axis;
    b=A.short_axis/A.long_axis;
    phi=A.phi;
    cos_phi = cos( phi );
    sin_phi = sin( phi );
    R = [ cos_phi sin_phi; -sin_phi cos_phi ];
    bA=A.b;
    aA=A.a;
    %fit ellipse to each blob
    if drawfigure==1
        nexttile
        scatter(RingA(:,1),RingA(:,2),2,densitydraw,'.')
        colormap(hot);
        colordef black
        zlim([-100 100])
        xlim([-100 100])
        ylim([-100 100])
        axis equal

        %scatter(par(:,1),par(:,2),'k.')
        hold on
        axis equal
        scatter(centers(:,1),centers(:,2),'o','filled')
        hold on
    end

    for i=1:1:8
        x1=[];
        x1=blob{rlabel,i};
        if drawfigure==1
            hold on
            B=fitEllipse(blob{rlabel,i}(:,1),blob{rlabel,i}(:,2),f);
        else
            B=fitEllipse(blob{rlabel,i}(:,1),blob{rlabel,i}(:,2));
        end
        blobE{rlabel,i}=B;
        esave(rlabel,i)=blobE{rlabel,i}.short_axis/ blobE{rlabel,i}.long_axis;

        [TPoint]=R^(-1)*[blobE{rlabel,i}.X0_in;blobE{rlabel,i}.Y0_in];
        Xt=TPoint(1,1);
        Yt=TPoint(2,1);
        bt=B.b;


        tan_line= [ [Xt-10 Xt+10]; [-bA^2*Xt/aA^2/Yt*(Xt-bt-Xt)+Yt -bA^2*Xt/aA^2/Yt*(Xt+bt-Xt)+Yt] ];%[bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt-10) bA^2/Yt-bA^2*Xt/aA^2/Yt*(Xt+10)]
        % Calculate the length of the original line

        % original endpoints
        end1 = [Xt-10, -bA^2*Xt/aA^2/Yt*(Xt-bt-Xt)+Yt];
        end2 = [Xt+10, -bA^2*Xt/aA^2/Yt*(Xt+bt-Xt)+Yt];
        % calculate midpoint
        midpoint = (end1 + end2) / 2;
        % calculate vector between midpoint and end1
        vec = end1 - midpoint;
        % normalize vector to have length 20
        vec = vec / norm(vec) * 20;
        % calculate new endpoints using normalized vector
        new_end1 = midpoint + vec;
        new_end2 = midpoint - vec;
        % apply rotation matrix to new endpoints
        new_end1 = R * new_end1';
        new_end2 = R * new_end2';

        new_tan_line= R*tan_line;

        angled=angle_between_lines(blobE{rlabel,i}.longaxisline,new_tan_line);
        angle_degrees=wrapTo90(angled);
        blobE{rlabel,i}.Angle=angle_degrees;
        asave(rlabel,i)=blobE{rlabel,i}.Angle;

        if drawfigure==1
            hold on
            % draw new line
            line([new_end1(1), new_end2(1)], [new_end1(2), new_end2(2)],'color','g','LineWidth',2);
            txtangle=[num2str(blobE{rlabel,i}.Angle,'%.2f') '^o'];
            text(centers(i,1)+2,centers(i,2),txtangle,'Color',[0,0.5,0],'FontWeight','bold')
            axis equal
            ma=roundn(mean(asave(rlabel,:)),-2);
            title(['R:' num2str(rlabel) 'L:' num2str(size(XF,1)) 'A:' num2str(ma)])

        end


        %         Ad(rlabel,i)=angle_degrees;
        %         Adc(rlabel,i)= blobE{rlabel,i}.Angle;

    end



end
AnglesMean=roundn(mean(asave'),-2);
AnglesStd=roundn(std(asave'),-2);
EsMean=roundn(mean(esave'),-2);
EsStd=roundn(std(esave'),-2);