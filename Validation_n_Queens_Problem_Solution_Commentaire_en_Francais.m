
%Validation_nQueens_Problem_Solution
%{
Ce programme est destin?:

a) pour v?rifier l'exactitude de la solution Probl?me n-Queens pour un ?chiquier arbitraire de taille n x n,

b) v?rifier l'exactitude d'une composition arbitraire de k reines r?parties al?atoirement sur un ?chiquier de taille n x n.
%}

%{
 License: Attribution-NonCommercial-ShareAlike CC BY-NC-SA

“Cette licence permet ? d'autres personnes de remixer, d'adapter et de s'appuyer sur votre travail de mani?re non commerciale, ? condition qu'elles vous cr?ditent et conc?dent leurs nouvelles cr?ations sous les m?mes conditions.”.
%}

%{
Auteur et d?veloppeur du projet - Grigoryan Eros (EricGrig), 2020

Je serai heureux si des sections du code, ou l'ensemble du programme dans son ensemble, seront utilis?s ? des fins scientifiques ou ? des fins ?ducatives. En m?me temps, je vous serai reconnaissant si vous consid?rez qu'il est possible de faire r?f?rence ? ma publication. C'est un ?l?ment de culture et un signe de respect mutuel.

Pour une utilisation commerciale d'une partie quelconque du code du programme, ou de l'ensemble du programme dans son ensemble, le consentement ?crit de l'auteur est requis.
%}

%{
Cet algorithme est d?crit en d?tail dans l'article: Grigoryan E., Linear algorithm for solution n-Queens Completion problem, https://arxiv.org/abs/1912.05935  .  Ce sera correct si vous lisez d'abord cette publication avant de commencer ? analyser le code source. Cela rendra la description du programme plus transparente et r?duira le nombre de questions possibles.
%}

%{
Comment sont pr?par?es les donn?es initiales?

Indiquez la taille du c?t? de l'?chiquier par n.
Soit un tableau de taille annul? ? une dimension n.
Si dans la i-?me rang?e de l'?chiquier la reine est plac?e en position j, alors, respectivement, dans la i-?me cellule du tableau de donn?es, la valeur de j est ?crite.
%}

%{
Entr?e de donn?es.

Nous ?crirons les donn?es d'entr?e dans le tableau Q.
Le nom du fichier d'entr?e nQueens_Test_Solution.mat doit ?tre chang?, si un autre fichier est s?lectionn?
%}

inputFileName= 'nQueens_Test_Solution.mat';

%inputFileName= 'kQueens_Test_Composition.mat';


iInfo=['Input file name: ' inputFileName];
disp(iInfo);


Q=importdata(inputFileName);

 
% Afficher la taille d'un ?chiquier

n=length(Q);

disp(' ');
tStr = sprintf(' The size of a chessboard = %d',n);
disp(tStr);
disp(' ')

% n2 – la taille des tableaux de contr?le diagonaux

n2=n*2;

% Formation de tableaux de contr?le pour le contr?le diagonal. 
    
D1=zeros(1,n2,'uint8');
D2=zeros(1,n2,'uint8');
B=zeros(1,n,'uint8');
 
%{
Nous d?terminons le nombre de lignes sur l'?chiquier dans lequel la reine ne se trouve pas, c'est-?-dire le nombre de lignes libres. Ce nombre est ?gal au nombre total de cellules nulles dans le tableau Q.
%}
 
nZero=sum(Q==0);

qError = 0;


%{ qError – indice de validation de d?cision. Si qError == 0, alors la solution est correcte, sinon, si qError == 1, alors la solution contient une erreur.
%}
 
tic

%{
Si nZero == 0, alors cela signifie que les donn?es d'entr?e sont une solution du probl?me n-Queens, sinon - les donn?es d'entr?e sont une composition.
%}

%{
L'essence de l'algorithme est que nous ne pouvons ?crire qu'une seule fois 1 dans les cellules mises ? z?ro des tableaux de contr?le D1, D2, et B, sinon, l'une des trois conditions de la t?che sera viol?e.
%}

if nZero==0
    for i=1:n
        j=Q(i);
        r=n+j-i;
        t=j+i;
 
        if D1(r)==0 && D2(t)==0 && B(j)==0
            D1(r)=1;
            D2(t)=1;
            B(j)=1;
        else
            qError=1;
            break
        end
    end    
else        
    for i=1:n
        if Q(i)>0
            j=Q(i);
            r=n+j-i;
            t=j+i;
            if D1(r)==0 && D2(t)==0 && B(j)==0                
                D1(r)=1;
                D2(t)=1;
                B(j)=1;
            else
                qError=1;
                break
            end      
        end
    end 
end
toc

%{
k – le nombre d'?l?ments diff?rents de z?ro dans le tableau Q (taille de la composition)
%}
 

if qError==0

    if nZero==0
        disp('Solutions is ok!')

    else

        tStr = sprintf('Composition size = %d', n-nZero);
        disp(tStr);
        disp('Composition is ok!')
    end 
       
else
    tStr = sprintf('Error in solution in row = %d',i);
    disp(tStr)
end
 
 



