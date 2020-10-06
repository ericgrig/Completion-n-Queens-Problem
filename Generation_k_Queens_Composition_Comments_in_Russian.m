%Generation_kQueens_Composition
 
%{ 
 ��������� ������ ��� ������������ ���������� �� k ������, �������
 ������������ �� ��������� ����� ������� n x n. ��� ����������� ��
 �������� ��������� ������������ k ������ �� ������������ ��������� �����
 � �������� n x n, ����� �������, ��� ����������� ��� ������� ������:
 - � ������ ������,
 - � ������ �������,
 - � ����� �� ����� � ������ ����������, ���������� ���� �������,
 ��� ���������� �����, �� ������������� ����� ������ �����.
%}

%{
 License: Attribution-NonCommercial-ShareAlike
 CC BY-NC-SA � �This license lets others remix, adapt, and build upon your
 work non-commercially, as long as they credit you and license their new
 creations under the identical terms�.
%}

%{
 ����� ������� � ����������� � �������� ���� (EricGrig), 2020

 ���� ���, ���� �����-���� ������� ����, ��� ��� ��������� � �����,
 ����� �������������� ��� ������� �����, ��� ��� �����������. ��� ����,
 ���� ����������, ���� ������� ��������� ��������� �� ��� ����������.
 ��� ������� �������� � ���� ��������� ��������.

 ��� ������������� � ������������ ����� ������ ������� ���� ���������,
 ��� ���� ��������� � �����, ���������� ���������� �������� ������.
%}
 
% ��� ������ ��������� ���������� ������� ������ ������� ��������� ����� (n)

n=1000;


tStr = sprintf(' The size of a chessboard = %d',n);
disp(tStr);
 
nx=n-1;    % nx � ������������ ������ ����������

% n2 - ������ ����������� ��������
 
n2=2*n;
 
%{
nFix - ������������� �������� ������� ������� �������. ���� n<nFix ��
���������� ������� ���������� � ����-3, ����� ����-1 � ����-2
%}

nFix=17;
 
%{
bound_1_Ar, bound_2_Ar - ������� �������� ��� eventBound1 � eventBound2
��� n <30. ��� �������� ���������� �� ������ �������������� �������������
%}
 
bound_1_Ar =[2 2 2 3 3 3 3 3 4 4 4 4 5 5 5 6 6 7];
bound_2_Ar =[4 4 5 5 5 6 6 7 7 8 8 9 10 10 11 11 12 13];
 
%{
���������� �������� eventBound1 � eventBound2 �� ������ ���������
���������. ��� ���������� �������� �� ������ �������������� �������������
%}

 
if n<nFix
    
    if n<9
        eventBound1=1;
        eventBound2=2;
    elseif n<12
        eventBound1=2;
        eventBound2=3;
        
    elseif n<14
        eventBound1=3;
        eventBound2=4;
    else       
        eventBound1=3;
        eventBound2=6;
        
    end
    
    sameRepeatBound=10;
else
    sameRepeatBound=5;
    
    if n<30

        nInd=n-12;
        eventBound1=bound_1_Ar(nInd);
        eventBound2=bound_2_Ar(nInd);
    else

        u=log10(n);
        w=u*u;

        if n<100
            
            b1=293.898676*w*u-1495.491673*w+2578.130423*u-1470.692935;
            b2=91.458481*w*u-474.647556*w+849.173904*u-497.393064;

        elseif n<30000
            
            b1=12.749568*w*u -46.535838*w + 120.011829*u -89.600272;
            b2=9.717958*w*u -46.144187*w + 101.296409*u -50.669273;
             
        else

            b1=-0.886344*w*u+56.136743*w-146.486415*u+227.967782;
            b2=14.959815*w*u-253.661725*w+1584.711376*u-3060.691342;
        end

        eventBound1=n-round(b1);
        eventBound2=n-round(b2);        
    end
end
 
%{
���������� simBound1, simBound2 � simBound4 ����������
������������ ����� ��������� ���������� � �������� ������ 1,2 � 4
%}
 
simBound1=3;
simBound2=5;
simBound4=10;
 
%{
totSimBound - ��������� �������� ��� ����� ������ ���������� ����
��������� ����������
%}
 
totSimBound=1000;
 
% ��������� ��������� ������ ���������� nComp=(1, ... ,n-1)
 
    nComp=randi(nx);     
%{
������� ������� ����� ������������ �� ��� ���, ���� �� ����� �����������
����� � nComp �������    
%}
 
%������� ������� ������ Q(1:n)
        
    Q=zeros(1,n,'uint32');
 
% ��� ������ ������� ������� �������
% A(1:n) - ��� �������� �������� ��������� �����
 
    A=zeros(1,n,'uint8');
        
% B(1:n) - ��� �������� �������� ��������� ��������        
        
    B=zeros(1,n,'uint8');
        
% C(1:n2), D(1:n2) - ��� �������� ��������� ������������ ��������
 
    C=zeros(1,n2,'uint8');
    
    D=zeros(1,n2,'uint8');
    
% totPos - ������� ���������� ����� ���� ��������� ����������

    totPos=0;
 
%{
������� �������� ����� ���������� simCount ��� ������� �������
simCount1, simCount2, simCount2, simCount4 - �������� ����� ���������� 
� �������� ������ 1,2 � 4
totSimCount - ������� ���������� ����� ���� ����������
%} 
    simCount1=0;
    simCount2=0;
    simCount3=0;
    simCount4=0;
    
    totSimCount=0;
 
% eventInd=1 -- � ��������� ��������� ������� ���������� � 1-�� �����
 
    eventInd=1;
    
% swiInd (switch Index) - "�������������" ��� ������ �� �����
 
    processInd =1;
    
%{
��� ������� ��������������� ������ ����� while swiInd==1, ���� �� �����
�������� �������.
%}
  tic

  while processInd ==1
 
% ���������� eventInd ������ � �������� ������������� ����� 4-�� ���������
 
    switch eventInd
        
        case 1
        
% �������� rand_set & rand_set. ������������ ���������� �� ������� simBound1            
 
            simCount1=simCount1+1;
                        
            if nComp<eventBound1   
                xEvent=nComp;
            else
                xEvent=eventBound1;
            end
            
            while totPos < xEvent
 
                xInd=find(A==0);
                nRow=length(xInd);
                aInd=uint32(randperm(nRow));
 
                yInd=find(B==0);
                bInd=uint32(randperm(nRow));
             
                for k=1:nRow
                    i1=aInd(k);
                    i=xInd(i1);
 
                    j1=bInd(k);
                    j=yInd(j1);
                    
                    r=n+j-i;
                    t=j+i;                    
                    if C(r)==0 && D(t)==0
                        C(r)=1;
                        D(t)=1;
                        Q(i)=j;
                        A(i)=1;
                        B(j)=1;
                        totPos=totPos+1;
                    end
 
                    if totPos==xEvent
                        break
                    end
 
                end
            end
 
        if nComp<= eventBound1
            processInd =0;
        else            
 
% ������ �������� ������� ���������� ��������� ����� � ������� �������.
 
            A=find(A==0);
            nFreeRow=length(A);
 
% ������ �������� ������� ���������� ��������� �������� � ������� �������.
 
            B=find(B==0);           
%{
�������� ������ L(1:nFreeRow,1:nFreeRow) � �������� ��� ������ ��������.
�����, ���� ������ L(p,q) �������� ���������, �� � ��� ������ ������
������� ������� ����.
%} 

            L=ones(nFreeRow,nFreeRow,'uint8');
%{
�������� ������� ������� rAr � tAr ��� ���������� �������� ������������
����������� ��������
%} 

            rAr=zeros(nFreeRow,nFreeRow,'uint32');
            tAr=zeros(nFreeRow,nFreeRow,'uint32');                
%{
�� ������ ���������� �� ���������� ��������� ������� � ���������
��������, ������� ���� � ��������������� ��������� ������ ������� L 
��������� ������� ����� rAr, tAr
%}
 
            for p=1:nFreeRow
                i=A(p);
                for q=1:nFreeRow
                    j=B(q);
                    r=n+j-i;
                    t=j+i;
                    if C(r)==0 && D(t)==0
                        L(p,q)=0;
                        rAr(p,q)=r;
                        tAr(p,q)=t;
                    end
                end
            end            
%{
�������� ��������� ����� ���� �������� ��������. ��� ��� ����� �����,
���� ��������� ������������� ��������� � ������ ������� 2 ��� ���������
��������
%} 
            Ay=A;
            By=B;
            Cy=C;
            Dy=D;
            Qy=Q;
            Ly=L;
            rAr_y=rAr;
            tAr_y=tAr;
            
            yPos=totPos;
 
            eventInd=2;
        
        end
        
        case 2 
 
% � ������ ����� ����� ������������ �� ������ ���������  rand & rand
 
            simCount2=simCount2+1;            
%{
�����, ��������� ������������ ����� ������ ������� �� ������ ������,
��������� � ������� L
%} 

  		if nComp<eventBound2   
                xEvent=nComp;
            else
                xEvent=eventBound2;
            end

            
            while totPos < xEvent
                
% ��������� ���������� ��������� ����� � ������� �� ������ ������� A
 
                freeRowInd=find(A>0);
                freeRow=length(freeRowInd);
 
% ������� ��������� ������ �� ������ ��������� �����
 
                selectRowInd=randi(freeRow);
                iInd=freeRowInd(selectRowInd);            
  
% ���������� ������ �������� ��������� ������� � ������ i ������� L
 
                freePosAr=find(L(iInd,:)==0);
                freePos=length(freePosAr);
 
                if freePos>0                    
%{
���� � ��������� ������ ������� ��������� �������, �� ���������� �������                    
�����, ������� ����� � ������ �������� ��������� �������
%} 
                    selectPosInd=randi(freePos);
                    
                    jInd=freePosAr(selectPosInd);
                    
                    j=B(jInd);
 
% �������� j-������ ������� ����� � ������� �������
 
                    i=A(iInd);
                    
                    Q(i)=j;
 
% �������������� ������� ����� ���������� �������, ������� ������
 
                    totPos=totPos+1;
 
% ������� 0 � ������ iInd ������� A,����� �������������, ��� ������ i ������
 
                    A(iInd)=0;
 
% ������� 0 � ������ jInd ������� B,����� �������������, ��� ������ i ������
 
                    B(jInd)=0; 
%{
������� ��������������� ������ ��������� �������� C � D, ���������
�������� �������� �������� (i,j) (��� ��������� "��������" �������)
%} 

                    rx=n+j-i;
                    tx=j+i;
                    
                    C(rx)=1;
                    D(tx)=1; 
%{
������� ��������������� ������ ������� L, ��������� ������������� �������,
����������� � �������� rAr � tAr
%} 
                       
                    rxInd=find(rAr==rx);
 
                    L(rxInd)=1;
                        
                    txInd=find(tAr==tx);
 
                    L(txInd)=1;
 
                    L(freeRowInd,jInd)=1;
 
                else  % if freePos>0
 
%{
���� � ��������������� ������ ��� ��������� �������,�� �� �������� ������,
������� ������ ������� ������ ����� ������ � ��������� �����, � ������
����� while totPos < simBound2 � ��������� ������������ ����� ����� ������
�� ����� ����, �� ������ ������������ ��� ����������� ������� �� ������
��������� �����. ������ � ����� ��������� �� ������� � ������� 2
%} 
                    if simCount2 < simBound2
 
                        A=Ay;
                        B=By;
                        C=Cy;
                        D=Dy;
                        Q=Qy;
                        
                        L=Ly;
                        rAr=rAr_y;
                        tAr=tAr_y;
                        
                        totPos=yPos;
                        eventInd=2; 
                        
                    else 

% ������� ������� ������� � ��������� ���������� ������� 1 
 
                        A=zeros(1,n,'uint8');
                        B=zeros(1,n,'uint8');
                        C=zeros(1,n2,'uint8');
                        D=zeros(1,n2,'uint8');
                        Q=zeros(1,n,'uint32');
                        totPos=0;
                        
                        simCount2=0;
                        
                        eventInd=1;
                        break
                    end
 
                end   % if freePos>0 
     
            end    % while totPos < simBound2
            
            if nComp<= eventBound2
                processInd=0;
            else
                
                if totPos>=xEvent
                    eventInd=3;
                end
  
            end 
                       
%{
�� ��������� ������ ����� ������������ ����� ������ � ��������  ������,
����� � ������� ������� ��������� ������������ simBound2 ������. ��������
� �������� �����
%} 

        case 3  
 
            simCount3=simCount3+1;
%{
����� �������� �� ����������� ������� ������ � ������� �������. ����������
���� ���������� ������� L ��� ����������� ����� ���������� ����� � �����
���������� ��������. ��� �����, ������ ������� ���������� ��������� �����,
�������� ������� ����� ������� ����� A
%}
 
            T=find(A>0);
            A=A(T);
            
            nRow=length(T);
 
% ���������� ��������� ������ �������� ��������� ��������.
 
            T=find(B>0);
            B=B(T); 

%{
����� ������ L(1:m,1:m) � �������� ��� ������ ��������. �����, ����
������ L(p,q) �������� ���������, �� � ��� ������ ������ ������� �������
����.
%}

            L=ones(nRow,nRow,'uint32'); 
%{
�������� ������� ������� ��� ���������� �������� ������������ �����������
��������
%}
            rAr=zeros(nRow,nRow,'uint32');
            tAr=zeros(nRow,nRow,'uint32');
 
% �������� ������� ��� ����� �������������� ������ �����������
 
            Cs=zeros(1,n2,'uint32');
            Ds=zeros(1,n2,'uint32');
            Bs=zeros(1,n,'uint32');                
%{
�� ������ ���������� �� ���������� ��������� ������� � ���������
��������, ������� zero � ��������������� ��������� ������ ������� L 
��������� ������� Cs, Ds, Bs, � ����� ������� ����� rAr, tAr
��� ���� m ����� �, ��������������, ��� ���������� ���������
������� � ���� ������� ���������� ������������� ������ ����������� ��� 
����� Cs � ������ Ds ������������ ��������, � ����� ��� �������� �������
%} 

            for p=1:nRow
                i=A(p);
                for q=1:nRow
                    j=B(q);
                    r=n+j-i;
                    t=j+i;
                    if C(r)==0 && D(t)==0
                        L(p,q)=0;
                        rAr(p,q)=r;
                        tAr(p,q)=t;
                        Cs(r)=Cs(r)+1;
                        Ds(t)=Ds(t)+1;
                        Bs(j)=Bs(j)+1;
                    end
                end
            end   
 
% �������� ����� ��������� ������ ������ ������� L
 
            rowSum=sum(L==0,2); 
%{
��������� �������� ����� � ������� ����������� ����� ��������� �������
� ������ ������
%} 
            [sumSort,rowRangInd]=sort(rowSum); 
%{
�����, � ������� rowRangInd ��������������� ��������� ������� ����� �
������������ ������ ��������� ������� � ������. ���� ��������, ���
��� �� ���� ���������� �������, "���������" � ������ L ���� ���������
�������, �� ������ rowRangInd ����� �������������� �����, � ����� 4
%}
 
            if sumSort(1)>0 
%{
����� sumSort(1) -����������� ����� ��������� ������� � ������ ���� �����
������� L(m,m). ���� ����������� ����� ��������� ������� > 0, �� ��
���������� ���������� ����� ������, �.�. �� ������� ���� �����������
����� ���������� �������������
 
�������� ����������� ������ ����� E ������� nRow x nRow, � ������ ������
�������� �������� ���������� �������� ������������� �������� �����������
%}
 
            E=zeros(nRow,nRow,'uint32');        
%{
 �������� � �������� � E ���������� �������� ������������� ��������
 �����������
%} 
            for p=1:nRow
                for q=1:nRow
                    r=rAr(p,q); %������ r ��� ������� Cs
                    t=tAr(p,q); %������ t ��� ������� Ds
                    j=B(q);     %������ j ��� ������� Bs
                    if r>0 && t>0
                        E(p,q)=Cs(r)+Ds(t)+Bs(j);
                    end
                end
            end
 
%{
 �����, ������ �������� Cs,Ds,Bs �� ����� ������������ �������� E 
 ��� ������������ ������� �������� n ������� ������� ��� �������,
 ����� ���������� ������     
%} 
%{
 ������ ��� ������� � ���������� �������, �������� ��� ����������
 ������������� ����� ���� ��������.
%}
                Az=A;
                Bz=B;
                Qz=Q;
                Lz=L;              
                Ez=E;
                zPos=totPos;
  
% �����, �������� � ������� 4
                
                eventInd=4;
 
            else  % if sumSort(1)>0 
%{
���� ��������, ��� ����� ���������� ����� ���� ������, � �������
����������� ��������� �������, �� �� ��������������� �������� ��������
�������� � �������� ���������� � ������� 2
%}
 
                    A=Ay;
                    B=By;
                    C=Cy;
                    D=Dy;
                    Q=Qy;
                    
                    L=Ly;
                    rAr=rAr_y;
                    tAr=tAr_y;
                        
                    totPos=yPos;
                    
                    eventInd=2;                    
 
            end  %if sumSort(1)>0
 
        case 4                       
 
            simCount4=0;
            
            for iRow=1:nRow
 
                selectRowInd=rowRangInd(iRow); 
%{
��������� ���������������(��������) �������� ������ ������ � ������� L, 
��������� ������ �������� ������                
%}
                initRowInd=A(selectRowInd);
                
%��������� ����� ��������� ������� � ��������� ������
 
                T=L(selectRowInd,:);
                
                baseFreePosInd=find(T==0);
                baseFreePos=length(baseFreePosInd);
%{
�����, �����, �� ������� ������, � �������� ��������������� ������
� �������, ����������� ��������� ����� ��������� ������� � ������ 
����� ���������������, � �����,������������� ������ ��������� �������
%}
 
                for jCol=1:baseFreePos                   
                                        
% �������� i �������� ����� ��������� ������ �� ������� ������
 
                    i=initRowInd;
                    
                    jPos=baseFreePosInd(jCol);
 
% �������� j �������� ��������� ��������� ������� �� ������� ������
 
                    j=B(jPos);
 
% �������� minRowInd ������ ������ � ������� L(1:nRow,1:nRow) � �����������
% ������ ��������� ������� � ������
 
                    minRowInd=selectRowInd;
                    
        %������ �������� ����� ��������� � ������� 4.
                    
                    sSame=0;
                    
                    while totPos < nComp
                           
%��� ������� ���� � ���� ����� �������� i,j �� ���������� ���� 
%�������� j-������ ������� ����� � ������� �������
                            
                        Q(i)=j;
                        
% �������������� ������� ����� ���������� �������, ������� ������
 
                        totPos=totPos+1;
                                                                                             
% ��������, ���� ������������ ������ �������, �� ��������� �������
 
                        if totPos==nComp                            
 
                            totSimCount=totSimCount+1;
                            processInd =0;
                            
                            break
                        end
%{
�� ��������� ��������� ���� ����������� �������� ��� ������������ �����                        
� �����������  ����� � ������ (i,j) ������� �������                        
����� �����, �� ������ �������� ��������������� ������ �� ���� �����������
��������, �������� ������� (minRowInd,colInd) ������� L
%}
 
                        A(minRowInd)=0;
 
                        B(jPos)=0;                                               
%{
������� ��������������� ������ ������� L, ��������� ������������� �������,
����������� � �������� rAr � tAr
%}
                        
                        rx=n+j-i;
                        tx=j+i;
                        
                        rxInd=find(rAr==rx);
 
                        L(rxInd)=1;
                        
                        txInd=find(tAr==tx);
 
                        L(txInd)=1;                                             
%{
�������������� �������� �������������� ������������ �������, �.�.
�������� "������ �������" ��������� ������� � ���������� ������, �����
���� ��� ��� ����������� �����
%} 

                        E(rxInd)=E(rxInd)-1;
                        E(txInd)=E(txInd)-1;
                        
% ������� 1 �� ��� �������� ������ ������� colInd
% �������� ������ �������� �������� A1
 
                        A1=find(A>0);
                        L(A1,jPos)=1;
 
                        rowSum=sum(L(A1,:)==0,2);
 
% ��������� ������ ������ minRowInd � ����������� ������ ��������� �������
 
                        [freePosAr,rowIndAr]=sort(rowSum);
 
                        if freePosAr(1)>0
%{
���� ��� ������ ����� ���������� ����������� ����� ��������� �������, ��
�������� �������� ������ ����� �� ���� �����
%} 
                            if numel(freePosAr)==1||freePosAr(1)<freePosAr(2)
                                randPos=1;
                            else
                                randPos=randi(2);  
                            end
 
                            minRow=rowIndAr(randPos);
                            minRowInd=A1(minRow);
 
                            i=A(minRowInd);
 
% ��������� ����� ��������� ������� � ���� ������
                            
                            rowFreePosAr=find(L(minRowInd,:)==0);
                            nfreePos=length(rowFreePosAr);
%{
������� ����� ���� ������� ��, ������� ��������� ����������� �����
��������� ������� � ���������� �������. ��� ����� ������������� 
�������� E(m,m)
%}
                            if nfreePos==1
                                jPos= rowFreePosAr(1);
                            else                                
                                T=E(minRowInd, rowFreePosAr);
 
                                [tSort,tInd]=sort(T);
                                    
                                if tSort(1)<tSort(2)
                                    jPos= rowFreePosAr(tInd(1));
                                       
                                else                         
                                    jInd=randi(2);
                                    jPos= rowFreePosAr(tInd(jInd));
                                end
                            end
                                
                            j=B(jPos);
 
%{
����� �������, ����� jPos �� ������ freePosInd(1:freePos) � ������� ������
������� ����������� ����� ��������� ������� � ���������� �������
%}
 
                        else  % if minFreePos>0
                           
%{
���� � ������ ��� ��������� ������� (minFreePos=0), �� ��������� �����
������ � �������������� �������� �������� ��������� ����������
%}
 
                            sSame=sSame+1;                         
                                                        
                            simCount4=simCount4+1;
                            totSimCount=totSimCount+1;
                            
%{
����������� �������� �������� �������� � �������� ����� �� ������ �����
while jCol<=colPos                            
%}
                            A=Az;
                            B=Bz;
                            Q=Qz;
                            L=Lz;
                            E=Ez;
                            totPos=zPos;
 
%{
���� ���������� ���������� �������� ��������� ���������� �������
sameRepeatBound, �� ��������� ���������� � ���������� �� ������
����� while jCol<=colPos
%}
                            
                            if sSame>sameRepeatBound
                                sSame=0;

break % ������� �� ������ ����� 
      % for jCol=1:baseFreePos

                            end                               
                        end  % if freePosAr(1)>0
                      
                    end  %while totPos < n
 
                        if processInd ==0  % ����� �� ����� while jCol<=colPos
                            break                       
                        end 
%{
���� ����� ��������� ���������� simCount4 ������ ����� while jCol<=colPos
��������� ��������� �������� repeatBound4 �� ������ ���� �����������
%}
                
                        if simCount4 > simBound4
                            break
                        end                        
 
                 end  % while jCol<=colPos
                 
                 if processInd==0
                     break                    
                 end
                 
                 if totSimCount > totSimBound 
                                        
                     processInd=0;
                     break
                 end                 
                 
%{
����, ��������������� �������� ��������������� ��������� � ������ 1,2,3,4
�� �� �������� �������, �� ��������� ����� ������� ������� � ����� 2
%}
 
                if simCount4 > simBound4
                   
                    A=Ay;
                    B=By;
                    C=Cy;
                    D=Dy;
                    Q=Qy;
                    
                    L=Ly;
                    rAr=rAr_y;
                    tAr=tAr_y;
                    
                    totPos=yPos;
 
                    eventInd=2;
   
                    break
                end
 
                if totSimCount > totSimBound
                    falseNegative=falseNegative+1;
                end
                 
            end  %for iRow=1:nRow
            
        otherwise
            processInd =0;              
            
    end  % switch eventInd

    if processInd==0
        break                    
    end
    
  end  % while processInd==1
   
toc
 
nDisp =50;
 
if n< nDisp
    nDisp =n;
    disp('Positions of all Queens on the chesboard:');
else
    disp('Positions of the first 50 Queens on the chesboard:');
end
 
Q(1: nDisp)

tStr = sprintf(' The size of Composition = %d', nComp);
disp(tStr);
 
% �������� �������������� ����������
 
outputFileName= 'kQueens_Test_Composition.mat';
 
save(outputFileName,'Q');
iInfo=['Composition is saved in file: ' outputFileName];
disp(iInfo);
 


