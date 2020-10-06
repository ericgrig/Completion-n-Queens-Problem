% Solution_n_Queens_Completion_Problem
%{
 Le programme est con?u pour compl?ter ? une composition arbitraire de
 k reines. Par composition, nous entendons la distribution al?atoire
 de k reines ? un ?chiquier arbitraire de taille n x n, de sorte que
 trois conditions de cette t?che soient remplies: dans chaque ligne,
 dans chaque colonne, ainsi que sur les diagonales gauche et droite
 passant par la position o? se trouve la reine, il n'y a pas plus
 d'une reine.
 Il est n?cessaire de trouver au moins une solution et de montrer
 ainsi que la solution existe, ou de juger qu'avec une probabilit? donn?e
 P), cette composition ne peut pas ?tre compl?t?e.
%}

%{
 License: Attribution-NonCommercial-ShareAlike
 CC BY-NC-SA – “This license lets others remix, adapt, and build upon your
 work non-commercially, as long as they credit you and license their new
 creations under the identical terms”.
%}

%{
 Auteur et d?veloppeur du projet - Grigoryan Eros (EricGrig), 2020

 Je serai heureux si des sections du code, ou l'ensemble du programme
 dans son ensemble, sont utilis?es ? des fins scientifiques ou ? des fins
 ?ducatives. En m?me temps, je vous serais reconnaissant de bien vouloir
 vous r?f?rer ? ma publication. C'est un ?l?ment de la culture et un signe
 de respect mutuel.

 Pour une utilisation commerciale de toute partie du code du programme,
 ou du programme dans son ensemble, le consentement ?crit de l'auteur
 est requis.
%}

%{
 Les r?sultats de recherche associ?s au d?veloppement de cet algorithme
 sont publi?s dans arxiv.org dans l'article:
 Grigoryan E., Linear algorithm for solution n-Queens Completion problem,
 https://arxiv.org/abs/1912.05935  .  Ce sera correct si vous lisez
 d'abord cette publication avant de commencer ? ?tudier le code source
 du programme. Cela rendra la description du programme plus transparente
 et r?duira le nombre de questions possibles.
 La version russe de l'article est publi?e sur le site Internet de la
 communaut? des programmeurs habr.com:  https://habr.com/ru/post/483036/ 
%}

%{
 1.La d?but
 ----------
 Comment les donn?es sont pr?par?es?
 ----------------------------------- 
 Indiquez n la taille du c?t? de l'?chiquier. Soit un tableau
 unidimensionnel annul? de taille n. Si la reine en position j est situ?e
 dans la i-?me rang?e de l'?chiquier, alors, en cons?quence,
 la valeur j est ?crite dans la i-?me cellule du tableau de donn?es
 unidimensionnel.
 
 Ensuite, avec le nom "?chiquier de taille n x n", nous utiliserons
 le nom "matrice de la solution de taille n x n"
 
 Lisons le fichier de donn?es de la composition et enregistrons le r?sultat
 dans le tableau Q. Ici, ? titre d'exemple, le nom du fichier de donn?es
 est utilis? kQueens_Test_Composition.mat . Ce nom doit ?tre remplac? par
 le nom qui correspond ? votre fichier de donn?es.
%}
 
inputFileName= 'kQueens_Test_Composition.mat';
 
iInfo=['Input file name: ' inputFileName];
disp(iInfo);
 
% Input data file
 
Q=importdata(inputFileName);
 
n=length(Q);
 
%{
 Nous d?finissons le nombre de cellules nulles dans le tableau Q,
 que nous d?signons par nZero. Ainsi, nous d?terminons le nombre
 de lignes libres dans la matrice de solution
%}

nZero=sum(Q==0);
 
% Indique la taille de la composition par nComp

nComp=n-nZero;

%{
 Nous affichons pour l'utilisateur les informations n?cessaires
 sur ce probl?me: la taille de la matrice de d?cision, la taille de la
 composition, le nombre de positions libres
%}

disp(' ');
tStr = sprintf(' Chessboard Size = %d',n); disp(tStr)
disp(' ');
tStr = sprintf('Composition Size = %d',nComp); disp(tStr)
tStr = sprintf('Number of free Positions = %d',nZero); disp(tStr)

%{
 Affichage des 50 premi?res lignes de la composition (ou de la composition
 enti?re si n <50
%}

if n<50
    nDisp=n;
else
    nDisp=50;
end
tStr = sprintf('The first %d positions of queens:',nDisp); disp(tStr)
disp(Q(1:nDisp));
 
%{
 S'il s'av?re que la taille de la composition est ?gale ? la taille
 de l'?chiquier, nous afficherons le message correspondant et terminerons
 le programme.
%}

if nComp==n
    tStr = sprintf('Composition size the same as matrix size %d',nComp);
    disp(tStr); 
    pause
    exit
end
 
%{
 S'il s'av?re que la taille de la composition est nulle, c'est-?-dire
 qu'il n'y a pas de composition, nous afficherons le message correspondant
 et terminerons le programme
%}

if nComp==0
    tStr = sprintf('Composition size =0. No composition!');
    disp(tStr); 
    exit
end

%{
 G?n?ral
 ------- 
 Au cours de la recherche, trois algorithmes de base pour r?soudre
 le probl?me ont ?t? d?velopp?s, qui diff?rent ? la fois par la vitesse
 de r?solution du probl?me et par son efficacit?. Le programme impl?mente
 ?galement des sections de code qui ex?cutent des fonctions pr?paratoires
 pour les algorithmes de base.
 D?signez ces sections du code, respectivement: Block-0,Block-1,...,Block-5.

Bloc-0  -- Bloc de d?part. V?rification de la bonne composition, 
  !        pr?paration destableaux de contr?le
  !
Bloc-1 --  formation d'une solution bas?e sur l'algorithme
  !        rand_set & rand_set. La valeur limite du nombre de reines 
  !        correctement d?finies est eventBound2
  !
Bloc-2  -- op?rations pr?paratoires pour le passage au Bloc-3
  !
Bloc-3  -- formation d'une solution bas?e sur un algorithme  rand & rand
  !        La valeur limite du nombre de reines correctement ?tablies
  !        est eventBound3
  !
Bloc-4  -- op?rations pr?paratoires pour le passage au Bloc-5.
  !
Bloc-5  -- formation d'une d?cision bas?e sur les r?gles
           du "risque minimal" et"dummage minimal". 

Dans le processus de recherche d'une solution, le calcul est transf?r?
d'un bloc de l'algorithme ? un autre sous forme de stick relais.
L'algorithme a ?t? d?velopp? pour une plage assez large de valeurs
de la taille d'un ?chiquier: d'une valeur de 7 ? 100 000 000.
Si la taille de la ordinateur RAM le permet, vous pouvez ?galement
effectuer des calculs pour de grandes valeurs de la taille d'un ?chiquier,
par exemple, pour n = 800 000 000. (Sur un ordinateur avec RAM = 32 Go,
le probl?me de s?lection a ?t? r?solu pour n = 1 000 000 000. Cependant,
en raison du manque de m?moire, nous avons d? modifier un peu le programme
et effectuer des calculs en deux ?tapes).
%}

if n<5
    tStr = sprintf('The algorithm was developed for the values n > 7');
    disp(tStr); 
    exit
end   
 
%{
 Si nComp <= eventBound2, puis les calculs commencent par le Bloc-1
 Si eventBound2 < nComp <= eventBound3, puis les calculs commencent
 par le Bloc-2
 Si nComp > eventBound3, le contr?le est ensuite transf?r? au Bloc-4,
 o? les travaux pr?paratoires sont effectu?s et apr?s quoi une transition
 est effectu?e dans le Bloc-5 pour les calculs de base
%}

%{
 Comme les r?sultats de l'?tude l'ont montr?, dans la plage
 de valeurs n=(7,...,99) n?cessite une approche plus m?ticuleuse
 de la formation d'une branche de la recherche d'une solution.
 Par cons?quent, cet intervalle a ?t? divis? en deux sous-intervalles
 (7,...,49) et (50,...,99), dans chacun d'eux, l'algorithme correspondant
 est utilis? solutions. (Ici, les valeurs limites peuvent ?tre l?g?rement
 augment?es ou diminu?es. De l?, l'essence de la solution ne changera pas)
%}

% nFix1, nFix2 - La valeur fixe de la taille de la matrice de d?cision.

nFix1=50;
nFix2=100;

%{
 Si n < nFix1, puis l'ex?cution des calculs est transf?r?e au Block-4.
 Si nFix1 <= n < nFix2, puis l'ex?cution des calculs est transf?r?e
 au Block-2.
%}

%{
 ? propos des valeurs limites eventBound2 et eventBound3:
 -----------------------------------------------------
 Si le processus de formation d'une branche pour trouver une solution
 conduit ? une impasse, nous devez revenir en arri?re (Back Tracking),
 ? certains des niveaux pr?c?dents, et recommencer la recherche
 d'une solution. Pour ce faire, nous devons savoir lequel des niveaux
 pr?c?dents doit ?tre renvoy? afin de conserver ? l'avance les valeurs
 des principaux param?tres de ce niveau. Le choix du point de retour
 optimal est une t?che plut?t compliqu?e et int?ressante. Dans cet
 algorithme, nous utilisons la r?gle suivante. En plus du niveau initial,
 qui correspond ? l'ach?vement du contr?le de composition et ? la formation
 de tous les tableaux de contr?le, nous formons et utilisons deux niveaux
 de base suppl?mentaires pour revenir en arri?re: eventBound2 
 et eventBound3. Ici, la mesure comptable du niveau de d?cision 
 est le nombre de reines correctement plac?es sur l'?chiquier.
%}  

%{
 Sur le nombre de recalculs au dernier niveau de base
 ----------------------------------------------------
 Les plus grandes difficult?s dans le fonctionnement de l'algorithme
 surviennent ? la derni?re ?tape de la r?solution du probl?me. Toutes les
 erreurs cach?es qui ont ?t? commises lors du choix de l'index d'une ligne
 libre, et (ou) du choix d'une position libre dans cette ligne, 
 "s'accumulent progressivement", et ? la derni?re ?tape se manifestent
 par le fait que parmi les lignes libres restantes, il y a au moins une
 ligne, dans qui n’existe pas une seule position libre. Cela signifie 
 une impasse. Par cons?quent, l'algorithme pour former la branche de la
 recherche d'une solution au dernier stade est plus m?ticuleux. 
(Par analogie, il convient d'utiliser ici une comparaison 
 de la microchirurgie avec la chirurgie).
 Afin de prendre en compte les moyens efficaces possibles de former
 une branche de la recherche d'une solution, ? la derni?re ?tape,
 ? l'int?rieur de deux cycles imbriqu?s, nous ex?cutons le troisi?me cycle,
 qui est r?p?t? plusieurs fois, en revenant au d?but du m?me cycle,
 sans changer les param?tres des deux cycles externes. Cela revient
 ? appliquer la proc?dure de Back Tracking ? l'int?rieur d'un syst?me
 de boucles imbriqu?es. La valeur seuil du nombre de fois qui peuvent
 ?tre produites ? l'int?rieur de ce cycle est indiqu?e par repeatBound.
 De plus, dans le texte, cela sera discut? un peu plus en d?tail. 
%} 

%{
 Calculez les valeurs eventBound2 et eventBound3, ainsi que le nombre
 seuil de r?p?titions repeatBound.
%}

if n<nFix1 
    
    repeatBound=25; 
    
else    
    repeatBound=5;
    
    u=log10(n);
    w=u*u;
    
    if n<30000
        b2=12.749568*w*u -46.535838*w + 120.011829*u -89.600272;
        b3=9.717958*w*u -46.144187*w + 101.296409*u -50.669273;
    else
        b2=-0.886344*w*u+56.136743*w-146.486415*u+227.967782;
        b3=14.959815*w*u-253.661725*w+1584.711376*u-3060.691342;
    end
 
    eventBound2=n-round(b2);
    eventBound3=n-round(b3);
   
end
 
%{
 Valeurs empiriques des param?tres eventBound2 è eventBound3 sont ?tablies
 sur la base d'un tr?s grand nombre d'exp?riences de calcul et sont
 optimis?es pour toute la gamme de r?solution de probl?mes. Pour toute
 plage plus petite de n valeurs, ces param?tres peuvent ?tre l?g?rement
 modifi?s et obtenir des valeurs auxquelles le programme fonctionnera
 un peu plus rapidement.
 
 Dans le processus de r?solution du probl?me, si un blocage se produit,
 certains blocs de l'algorithme sont r?ex?cut?s. De plus, selon les valeurs
 n et nComp des calculs r?p?t?s commencent d?s le d?but ou ? partir
 d'un certain niveau atteint. Si une recherche r?p?t?e d'une solution
 aux niveaux sup?rieurs ne m?ne pas au succ?s, alors une recherche r?p?t?e
 d'une solution commence aux niveaux inf?rieurs. Ici, les variables
 simBound3, simBound5 d?terminer le nombre maximum de recalculs dans
 les Bloc-3 et les Bloc-5. totSimBound - d?termine le montant total 
 tous les recalculs ? tous les niveaux.
%}

simBound3=5;
 
simBound5=100;
 
totSimBound=1000; 
%{
 falseNegSimCount - nombre de cycles de recomptage complets du compte
 tenu de la composition.
 Ceci est un compteur du nombre de recalculs pour terminer compositions,
 compositions, qui n'ont pas r?ussi ? terminer la premi?re fois
%}
falseNegSimCount=0; 
        
%{
 falseNegSimBound - limite de recalcul.
 Si, dans un premier temps, il n'est pas possible de terminer la composition,
 alors alors le calcul est r?p?t? ? partir du point de d?part
%}
 
falseNegSimBound=10;
 
%{
L'algorithme utilise plusieurs tableaux de contr?le:
A - pour contr?ler les indices de ligne,
B - pour contr?ler les indices de colonne.
%}

A=zeros(1,n,'uint8');        
               
B=zeros(1,n,'uint8');
 
%{
 De plus, deux tableaux sont utilis?s pour contr?ler les cellules des
 projections diagonales: D1(1:n2), D2(1:n2), o? n2 est la taille
 des tableaux de contr?le
%}

n2=2*n;
 
D1=zeros(1,n2,'uint8'); 
D2=zeros(1,n2,'uint8');
 
%{
 S?lection d'index d'?v?nements actifs eventInd.
 --------------------------------------------
 D?finissez l'index de bloc ? partir duquel le programme d?marrera.
 Pour ce faire, affectez la valeur appropri?e ? la variable eventInd.
 Nous d?terminons ?galement la valeur seuil pour le nombre de calculs
 r?p?t?s ? la derni?re ?tape (simBound5).
%}
 
if n<nFix1
            
    eventInd=4;
    simBound5=totSimBound;
            
elseif n<nFix2
            
    eventInd=2;
else
    if nComp<eventBound2
        eventInd=1;
 
    elseif nComp<eventBound3
        eventInd=2;
 
    else
        eventInd=4;
        simBound5=totSimBound;
    end
end
 
tic

%{
 3. V?rification de l'entr?e de composition
 ------------------------------------------
 La composition sera v?rifi?e et les cellules correspondantes des matrices
 de contr?le seront remplies s?quentiellement A, B, C et D.
 Dans les cellules du tableau Q(i), les index des positions des reines
 correctement d?finies pour les lignes correspondantes sont stock?s.
 Incr?mentation de la variable totPos pour tenir compte du nombre
 de reines correctement install?es.
%}

%{
 D?finissez les indices de ligne occup?s dans le tableau Q et enregistrez
 les r?sultats dans le tableau qPosInd
%}

qPosInd=find(Q>0);
 
%{
 Nous ?crivons l'unit? dans les cellules du tableau B qui correspondent
 aux colonnes occup?es.
%}

B(Q(qPosInd))=1;
 
% D?finissez la somme des unit?s du tableau B

s=sum(B);

%{
 V?rifiez si deux reines diff?rentes se trouvent dans la m?me colonne.
 Si c'est le cas, il y a une erreur dans la composition d'origine.
 Dans ce cas, nous afficherons le message correspondant et interromprons
 le travail ult?rieur du programme.
%}

if s~=n-nZero
    'Error -- the same positions in different row!' 
    exit
end
      
%{
 L'algorithme de v?rification fonctionne comme suit. Si cellule (i,j)),
 o? j=Q(i) libre, en tenant compte des restrictions diagonales et
 des restrictions sur le nombre d'?l?ments dans chaque colonne,
 la reine se situe correctement dans cette cellule. Nous ne v?rifions
 pas la r?gle «pas plus d'une reine par ligne», car le mod?le
 de pr?paration des donn?es initiales exclut la possibilit? de plus
 d'une reine dans la composition. Chaque cellule d'un tableau de donn?es
 d'entr?e ? une dimension caract?rise la ligne correspondante dans
 la matrice de d?cision.
%}
       
qError=0;
for k=1:nComp
 
    i=qPosInd(k);
    j=Q(i);
 
    r=n+j-i;
    t=j+i;
 
    if D1(r)==0 && D2(t)==0
        D1(r)=1;
        D2(t)=1;
    else
        qError=1;
        break
    end
end
        
%{
 Si une erreur est d?tect?e dans la composition, c'est-?-dire l'emplacement
 des reines ne r?pondra pas aux conditions de la t?che, un message 
 correspondant s'affichera et le programme sera interrompu.
%}

if qError==0
    A(qPosInd)=1;
    totPos=nComp;
else
    tStr = sprintf('Error in composition!  Row = %d Position= %d',i,j);
    disp(tStr)
    exit
end
 
% Supprimons le tableau qPosInd, car nous ne l'utiliserons plus.

clear qPosInd
 
%{
 Enregistrement de copies des tableaux g?n?r?s pour r?utilisation
 ----------------------------------------------------------------
 Nous avons fait un travail pr?paratoire. Organisation des donn?es
 d'entr?e et v?rification de la validit? de la composition. Des copies
 des tableaux form?s sont cr??es. S'il est n?cessaire de revenir
 ? ce niveau et de retraiter la composition, nous restaurerons
 tous les tableaux n?cessaires en fonction de ces sauvegardes.
 Ce niveau est le niveau de base initial (z?ro), d'o? commence
 la formation de la branche de recherche de solution. Ici, le nombre
 de reines correctement install?es est ?gal ? la taille
 de la composition originale.  
%}
 
        if eventInd==1
            Ax=A;
            Bx=B;
            D1x=D1;
            D2x=D2;
            Qx=Q;
            xTotPos=totPos;
        end

%{
 Remettre ? z?ro les compteurs de r?p?tition pour le troisi?me (simCount3)
 et cinqui?me (simCount5) niveaux.
%}

        simCount3=0;
        
        simCount5=0;

% simCount3 sera ensuite utilis? comme commutateur dans le Bloc-3.
        
%{
 Mettons ? z?ro totSimCount - le compteur du nombre cumul? de toutes
 les r?p?titions ? diff?rents niveaux.
%}

        totSimCount=0;
   
%{
 Tous les ?v?nements se d?roulent ? l'int?rieur du cycle:
 while processInd == 1 jusqu'? ce qu'une solution pour cette composition
 soit obtenue, ou qu'il soit ?tabli que la solution n'existe pas avec
 la probabilit? P. Le crit?re principal pour une telle ?valuation est le
 nombre total de tous les calculs r?p?t?s (totSimCount). Dans l'article,
 dont le lien est donn? dans le commentaire au d?but de ce programme,
 est ?crit suffisamment en d?tail ? ce sujet.
 ? la suite d'un grand nombre d'exp?riences de calcul, pour une grande
 vari?t? de compositions al?atoires de taille arbitraire k et pour
 diff?rentes valeurs de la taille d'un ?chiquier n, il a ?t? constat? que
 si le nombre total de calculs r?p?t?s totSimCount d?passe la valeur seuil
 de totSimBound, et aucune solution n'a ?t? trouv?e, la composition
 ne peut pas ?tre termin?e. La probabilit? d'erreur d'un tel 
 jugement est de 0,0001 .
%}

%{
 Le d?but de la formation la branche de recherche solutions
 ----------------------------------------------------------
 Comme mentionn? ci-dessus, nous consid?rons les diff?rents blocs
 du programme comme des ?v?nements distincts.
 Il y a cinq ?v?nements de ce type. Trois d'entre eux correspondent
 aux blocs principaux du programme et deux ?v?nements correspondent
 ? des blocs de programme qui ex?cutent des fonctions pr?paratoires.
 Affectez la variable activeEvent ? l'index de l'?v?nement actuellement
 actif.
%}

activeEvent=eventInd;
 
%{
 Nous introduisons la variable processInd - comme "switcher" pour quitter
 la boucle.
 Le cycle est ex?cut? si processInd == 1 sinon l'ex?cution de la boucle
 est interrompue.
%}
 
processInd=1;
 
%{
 Nous introduisons la variable compositionInd. Si compositionInd == 1,
 cela signifie que la composition est positive, c'est-?-dire qu'elle 
 peut ?tre compl?t?e en solutions compl?tes.
 Si compositionInd == 0, alors la composition sera consid?r?e comme
 n?gative, c'est-?-dire qu'elle ne peut pas ?tre compl?t?e en solution
 compl?te. Si compositionInd = -1, alors la composition sera consid?r?e
 comme n?gative "par naissance". Cela signifie que dans le tableau
 d'entr?e, parmi les rang?es libres de cette composition, il y a au moins
 une rang?e, dans laquelle il n'y a pas de position libre (toutes les
 positions sont ferm?es en raison des interdictions form?es par des
 reines pr?alablement ?tablies).
%}

solutionInd =1;
        
% D?but du cycle principal

while processInd==1
 
% L'?v?nement event sert de commutateur entre 5 ?v?nements

    switch activeEvent
 
        case 1  

%{
 Bloc-1. Utilisation de l'algorithme rand_set & rand_set
 -------------------------------------------------------
 Dans ce bloc, nous recherchons une ligne libre et une position libre
 dans cette ligne pour positionner la reine, jusqu'? ce que le total des
 reines correctement d?finies soit ?gal ? la valeur de seuil (eventBound2).
 L'algorithme qui s'ex?cute dans ce bloc est appel? rand_set & rand_set.
 Son essence est la suivante. On retrouve les indices de toutes les lignes
 libres. Effectuer une permutation al?atoire de ces indices. De m?me,
 on retrouve les indices de toutes les colonnes libres. Nous passons
 ?galement une permutation al?atoire de ces indices. Nous consid?rerons
 les indices de paires de ces deux listes (indice de ligne al?atoire,
 indice de colonne al?atoire). Si la cellule de la matrice de d?cision
 correspondant ? cette paire d'indices ne contredit pas les restrictions
 diagonales, alors nous mettons la reine dans cette position. Dans ce cas,
 nous ?crivons 1 dans les cellules des tableaux de contr?le appropri?s A,
 B, D1 et D2. Le total des reines correctement install?es (totPos)
 augmente d'une unit?.
%}
            
            while totPos < eventBound2
 
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
                    if D1(r)==0 && D2(t)==0
                        D1(r)=1;
                        D2(t)=1;
                        Q(i)=j;
                        A(i)=1;
                        B(j)=1;
                        totPos=totPos+1;
                    end
                end
            end
            
%{
 Dans ce bloc, les positions des reines sont d?termin?es rapidement.
 Et, bien qu'ici toutes les positions soient d?termin?es correctement,
 cependant, le «tableau» global de la distribution des reines dans
 la matrice de la solution est «grossier». Si nous ne nous arr?tons
 pas ? une ?tape optimale, la poursuite de la construction de la branche
 de la recherche risque de conduire ? une impasse. ?tant donn? la vitesse
 ?lev?e de l'algorithme rand_set & rand_set, sur la base de ce bloc, nous
 passons par le chemin maximum de la valeur de nComp aux valeurs
 eventBound2. Apr?s cela, l'ex?cution du programme est transf?r?e 
 au bloc suivant.
%}

%{
 Important! Ce bloc n'est ex?cut? que si n> = 100 et la taille
 de la composition est inf?rieure ? eventBound2. Comme l'ont montr? les
 r?sultats de pr?s de deux dizaines de millions d'exp?riences de calcul,
 pour une valeur donn?e de eventBound2, cet algorithme compl?te toujours
 la composition ? la valeur de eventBound2. Il n'y a jamais eu 
 de situation o? l'algorithme est boucl? et non termin?. Cela est d? au
 fait que la valeur de eventBound2 n'est pas critique, et il existe 
 de nombreuses possibilit?s diff?rentes pour atteindre ce niveau.
 Pour cette raison, ? ce stade, nous avons exclu le contr?le 
 de l'ach?vement du cycle de l'algorithme, bien que cette possibilit?
 ait ?t? prise en compte dans les premi?res versions du programme.
 La soif de vitesse ?tait plus ?lev?e que la logique d'embrasser des
 situations admissibles presque impossibles.
%}

%{
 Lorsque le nombre de reines correctement plac?es (totPos) est ?gal
 ? eventBound2, la gestion des ?v?nements est transf?r?e vers Bloc-2.
%}
 
            activeEvent=2;            
            
        case 2 

%{
 Bloc-2. Pr?paration des tableaux n?cessaires pour le travail dans le Bloc-3
 --------------------------------------------------------------------------- 
 Dans ce bloc, un travail pr?paratoire est effectu? pour la transition
 vers le Bloc-3. Son essence est la suivante: que le nombre de lignes
 libres restantes soit nFreeRow. Nous formons un tableau L(1:nFreeRow,
 1:nFreeRow) et collectons les indices de position libre de toutes les
 lignes restantes. Cela signifie ce qui suit: dans la matrice de solution
 d'origine, nous consid?rons la grille d'intersection de colonnes libres
 et de lignes libres. Nous transf?rons toutes ces cellules de la grille
 d'intersection ? la projection dans un tableau plus petit L. Dans ce cas,
 nous prenons en compte la correspondance des indices du tableau L avec
 les indices correspondants de la matrice de solution d'origine.
%}

%{ 
 Recherchez les indices initiaux des lignes libres restantes dans
 la matrice de solution et enregistrez les r?sultats dans le tableau A.
%}

            A=find(A==0);
            
% Indique le nombre de lignes libres par nFreeRow

            nFreeRow=length(A); 
%{
 Nous trouvons les indices initiaux des colonnes libres restantes dans
 la matrice de solution et enregistrons les r?sultats dans le tableau B.
%}
            B=find(B==0);
            
%{
 De toute ?vidence, le nombre de colonnes libres sera ?gal au nombre
 de lignes libres
%}

%{
 Cr?er un tableau L(1:nFreeRow, 1:nFreeRow) et remplissez toutes les
 cellules avec un. De plus, si la cellule L(p, q) s'av?re libre,
 alors nous ?crivons z?ro dans cette cellule au lieu d'un.
%}

            L=ones(nFreeRow,nFreeRow,'uint8');
 
%{
 Cr?ons des tableaux rAr et tAr pour sauvegarder les index
 de correspondance pour contr?ler les tableaux.
%}

            rAr=zeros(nFreeRow,nFreeRow,'uint32');
            tAr=zeros(nFreeRow,nFreeRow,'uint32'); 

%{
 Nous aurons besoin de ces tableaux pour rendre compte de mani?re
 ?quivalente des indices de positions libres dans le tableau L,
 avec les indices correspondants des tableaux de contr?le D1 et D2.
 Sur la base des informations sur les lignes et colonnes libres restantes,
 nous ?crivons z?ro dans les cellules libres correspondantes du tableau L.
 Dans le m?me cycle, nous formerons des tableaux de comptabilit? rAr et tAr.
%}

            for p=1:nFreeRow
                i=A(p);
                for q=1:nFreeRow
                    j=B(q);
                    r=n+j-i;
                    t=j+i;
                    if D1(r)==0 && D2(t)==0
                        L(p,q)=0;
                        rAr(p,q)=r;
                        tAr(p,q)=t;
                    end
                end
            end 
 
%{
 Sauvegardez tous les tableaux principaux. Nous en aurons besoin pour 
 le Back Tracking, s'il devient n?cessaire de revenir au d?but du Bloc-2
 pour des calculs r?p?t?s.
%}

            Ay=A;
            By=B;
            D1y=D1;
            D2y=D2;
            Qy=Q;
            Ly=L;
            rAr_y=rAr;
            tAr_y=tAr;
            
            yTotPos=totPos;
 
%{
 Nous avons fait le travail pr?paratoire. Nous pouvons maintenant passer
 au Bloc-3.
%}

            activeEvent=3;      
        
        case 3
%{
 Bloc-3. Utilisation de l'algorithme rand & rand
 ---------------------------------------------
 Dans ce bloc, nous poursuivons l'ach?vement de la composition. Ici, un
 autre algorithme est utilis?, qui s'appelle rand & rand. Son essence est
 la suivante. Dans la liste des lignes libres restantes, un index de ligne
 al?atoire est s?lectionn?. Dans la ligne s?lectionn?e, dans la liste des
 positions libres, nous s?lectionnons au hasard un index. S'il s'av?re
 que la position est libre des restrictions diagonales impos?es par
 toutes les reines pr?c?demment plac?es, alors la position est consid?r?e
 comme libre et la reine y est plac?e.
%}

% Augmentez le compteur du nombre de cas lorsque le Bloc-3 est utilis?.

            simCount3=simCount3+1;
%{
 S'il s'av?re que le nombre de r?p?titions (simCount3) ne d?passe pas
 la valeur limite de simBound3, alors nous continuerons ? former une
 solution sur la base des donn?es collect?es dans le tableau L.
%}

            if simCount3 <= simBound3                                
 
                while totPos < eventBound2
                                                         
%{
 D?finir des indices de lignes libres dans le tableau L en fonction
 du tableau A
%}
                    freeRowAr=find(A>0);
                    
% D?finissez le nombre de lignes libres (nFreeRow)
 
                    nFreeRow=length(freeRowAr);
 
% Choisissez un nombre al?atoire (randNumb) dans l'intervalle (1, nFreeRow).

                    randNumb=randi(nFreeRow);
%{
Dans la liste des lignes libres freeRowAr, nous s?lectionnons
 au hasard l'index des lignes selectRowInd
%}                   
                    selectRowInd=freeRowAr(randNumb);             
%{
 Consid?rons un tableau L. Formons une liste d'indices de position
 libres (freePosAr) dans une rang?e avec selectRowInd. D?finissez
 la taille de cette liste (nFreePos)
%}
                    freePosAr=find(L(selectRowInd,:)==0);
                    
                    nFreePos=length(freePosAr);
 
                    if nFreePos>0                   
%{
 S'il y a une position libre dans la ligne s?lectionn?e, nous continuons
 la solution. S'il n'y a pas de positions libres, cela signifie que 
 la branche de recherche a conduit ? un blocage. Dans ce cas, nous devons
 interrompre l'ex?cution de l'algorithme dans ce bloc et revenir au niveau
 de base pr?c?dent.
%}

%{
 S'il y a une position libre dans la ligne, alors nous s?lectionnons un
 nombre al?atoire (randNumb) dans l'intervalle (1,nFreePos)
%}
 
                        randNumb=randi(nFreePos);                       
%{
 Apr?s cela, dans la liste des positions libres (freePosAr), nous
 s?lectionnons la position selectPosInd sur la base du nombre al?atoire
 s?lectionn? randNumb.
%}

                        selectPosInd=freePosAr(randNumb);                       
%{
 Nous avons s?lectionn? au hasard l'index de ligne libre (selectRowInd)
 et s?lectionn? au hasard l'index de position libre (selectPosInd) dans
 cette ligne. Toutes ces actions ont ?t? effectu?es dans le tableau L.
 Maintenant, nous allons restaurer l'index d'origine de la position
 s?lectionn?e sur la base du tableau B (c'est l'indice qui correspond
 ? la matrice de donn?es d'origine).
%}

                        j=B(selectPosInd);
%{
 Nous restaurerons ?galement l'index d'origine de la ligne s?lectionn?e
 en fonction du tableau A.
%}
                        i=A(selectRowInd);
                    
%{
 Nous enregistrons le r?sultat (position reine dans la rang?e) dans
 le tableau Q
%}

                        Q(i)=j;

% On incr?mente le compteur du nombre de positions occup?es par la reine.

                        totPos=totPos+1;
%{
 Nous ?crivons 1 dans la cellule selectRowInd du tableau de contr?le
 des lignes libres A pour corriger que la ligne correspondante est ferm?e.
%}
                        A(selectRowInd)=0;
%{
 Nous ?crivons 1 dans la cellule selectPosInd du tableau B pour corriger
 que la colonne correspondante est occup?e.
%}
                        B(selectPosInd)=0;
%{
 Modifiez les cellules correspondantes des tableaux de contr?le diagonaux
 D1 et D2 en utilisant les valeurs r?elles des indices (i,j)
 (qui correspondent ? l'?chiquier d'origine).
%}
                        rx=n+j-i;
                        tx=j+i;
 
                        D1(rx)=1;
                        D2(tx)=1; 
%{
 Dans toutes les lignes libres du tableau L dans la colonne selectPosInd,
 nous ?crivons 1 (pour fermer les cellules correspondantes).
%}
                        L(freeRowAr,selectPosInd)=1;                        
%{
 Important! Nous travaillons avec un tableau L, o? sont projet?es toutes
 les lignes libres et toutes les colonnes libres de la «grande» matrice
 de donn?es d'origine. Lorsque nous pla?ons la reine ? la position (i, j)
 dans la matrice de donn?es initiale, alors, en m?me temps, devraient
 ?tre exclus de la suite: la row(i), la column(j) et toutes les cellules
 de la matrice de donn?es qui se coucher sur les diagonales gauche
 et droite passant par le point (i, j). Ci-dessus, nous avons exclu
 la ligne correspondante et la colonne correspondante, en mettant ? z?ro
 les cellules correspondantes dans les tableaux A et B. Maintenant,
 nous devons par "projection" exclure les cellules du tableau L qui
 correspondent aux exceptions diagonales de la matrice de donn?es d'origine.
 Pour ce faire, nous utilisons les index ?quivalents correspondants
 pr?c?demment stock?s dans les tableaux rAr et tAr.
%}                        
                        rxInd=find(rAr==rx);
 
                        L(rxInd)=1;
 
                        txInd=find(tAr==tx);
 
                        L(txInd)=1; 
%{
 Ainsi, nous avons effectu? toutes les ?tapes proc?durales associ?es
 ? la s?lection d'une position (i,j) dans la matrice de donn?es d'origine
 pour l'emplacement de la reine. 
%}
                    else  % if freePos>0                                               
%{
 S'il n'y a pas de positions libres dans la ligne, cela signifie que nous
 avons atteint une impasse, nous devons donc fermer cette branche de
 recherche et revenir au Bloc-3, puis r?p?ter pour former une solution.
 Avant cela, nous devons restaurer tous les tableaux n?cessaires en
 fonction des sauvegardes. Nous incr?mentons le compteur du nombre
 total de calculs r?p?t?s, puisque nous revenons ? recalculer.
%} 
                        totSimCount= totSimCount+1; 
%{
 Sur la base des copies enregistr?es, nous restaurerons les valeurs des
 tableaux n?cessaires.
%}                     
                        A=Ay;
                        B=By;
                        D1=D1y;
                        D2=D2y;
                        Q=Qy;
 
                        L=Ly;
                        rAr=rAr_y;
                        tAr=tAr_y;
 
                        totPos=yTotPos;
                    
% Passons au Block-3 pour le recomptage.
                    
                        activeEvent=3;                             
 
                    end   % if freePos>0 
     
                end    %while totPos < simBound2
            else                 

%{
 S'il s'av?re que le nombre de r?p?titions de simCount3 d?passe la valeur
 limite repeatBound3 et, en m?me temps, eventInd == 1, alors nous devons
 revenir au niveau de base 1 et reconstruire les branches de recherche.
 Avant cela, nous devons restaurer tous les tableaux n?cessaires qui
 correspondent ? ce point de retour.
%} 
                if eventInd==1 
                    
% On incr?mente le compteur total du nombre de calculs r?p?t?s.

                    totSimCount= totSimCount+1;                     
                                      
% Restaurons les tableaux et transf?rons le contr?le au Bloc-1.
            
                    A=Ax;
                    B=Bx;
                    D1=D1x;
                    D2=D2x;
                    Q=Qx;
                    totPos=xTotPos;
                    
% Remettez ? z?ro la valeur du compteur simCount3.
             
                    simCount3=0;

% Passons au Bloc-1.
            
                    activeEvent=1;
                else                                                 
%{
 Si, dans ce bloc, il y avait des r?p?titions simBound3, et dans chaque
 cas, ? un moment donn?, il s'est av?r? que parmi les lignes libres
 restantes, il y a une ligne dans laquelle il n'y a pas de position libre,
 cela signifie que cette composition est n?gative, et il ne peut pas ?tre
 compl?t?. Pour cette raison, le programme doit ?tre interrompu.
 Nous avons mis la variable compositionInd ? z?ro pour corriger que
 cette composition est n?gative. Nous avons ?galement mis la variable
 processInd ? z?ro pour interrompre le programme.
%}

                    solutionInd=2;
                    
                    processInd=0;
                    
                    break 
                end                                   
            
            end  % if simCount3 > simBound3            
%{
 Une fois les calculs du Bloc-3 r?ussis, le nombre de reines correctement
 situ?es dans la matrice de la solution sera ?gal ? eventBound3.
 Passons au Bloc-4.
%}

            if totPos >= eventBound2
                activeEvent=4;
            end
 
        case 4             

%{
Bloc 4. Pr?paration des tableaux n?cessaires pour travailler dans le bloc-5
---------------------------------------------------------------------------
 Nous allons au Block-4 dans trois cas:
 1) Imm?diatement apr?s la fin du bloc 3, c'est-?-dire si eventInd ?tait
    ?gal ? 1 ou 2,
 2) Si la valeur n <= nFix1,
 3) Si la valeur nComp> = eventBound2.
 Ce bloc est pr?paratoire, o? nous perpare les tableaux n?cessaires avant
 la transition dans le Bloc-5. Dans une certaine mesure, le fonctionnement
 de l'algorithme dans ce bloc est similaire au fonctionnement
 de l'algorithme dans le Bloc-3. Son essence est la suivante. Soit nRow le
 nombre de lignes libres restantes dans la matrice de solution.
 Nous formons un tableau L(1:nRow, 1:nRow) et collectons les donn?es de
 toutes les lignes et colonnes libres. L'algorithme de g?n?ration
 du tableau L est similaire ? celui utilis? dans Bloc-2. Comme dans
 le Bloc-2, nous prendrons en compte la correspondance des indices 
 du tableau L avec les indices correspondants de la matrice de solution
 d'origine. La traduction par projection d'une solution de la matrice
 d'origine vers une matrice L plus petite nous donne la possibilit?
 ? chaque ?tape de trouver efficacement une ligne avec un nombre minimum
 de positions libres et de r?duire consid?rablement la quantit? de calcul.
 Mais, non moins important est le fait que, sur la base du tableau L,
 nous gardons simultan?ment le statut de toutes les lignes libres restantes.
 Cela nous permet de contr?ler toutes les lignes et de d?terminer si une
 situation s'est produite lorsque dans l'une des lignes restantes le nombre
 de positions libres est nul. Dans ce cas, nous excluons la branche de
 recherche comme impasse. Cette approche nous permet de reporter
 les pr?visions et c'est important. Nous arr?tons le calcul beaucoup plus
 t?t que le moment o? il est "soudainement" constat? que cette branche de
 recherche est bloqu?e et doit ?tre interrompue.
%}

%{
 La transition directe depuis le d?but du programme vers le Bloc-4 et
 la transition s?quentielle le long de la cha?ne Bloc-2 -> Bloc-3 -> Bloc-4
 diff?rent par la forme de repr?sentation des tableaux A et B. Ceci doit
 ?tre pris en compte.
%}

            if eventInd==4                 
%{
 Nous trouvons les indices initiaux des lignes libres restantes dans
 la matrice de solution et les stockons dans le tableau A
%}             
                A=find(A==0);
                
% Notons nRow le nombre de lignes libres

                nRow=length(A); 

%{
 Nous trouvons les indices initiaux des colonnes libres restantes dans
 la matrice de solution et les stockons dans le tableau B
%}
                B=find(B==0); 
            
            else
                T=find(A>0);
                
                A=A(T);
 
                nRow=length(T);
            
                T=find(B>0);
                
                B=B(T);
            end  
            
%{
 Cr?ez un tableau L(1:nRow,1:nRow) et remplissez toutes les cellules
 avec un.
%}            

            L=ones(nRow,nRow,'uint32'); 
%{
 Cr?ez des tableaux rAr et tAr. On y enregistre les indices cellulaires
 des tableaux de contr?le diagonaux qui correspondent aux positions libres
 dans le tableau L.
%}
            rAr=zeros(nRow,nRow,'uint32');
            tAr=zeros(nRow,nRow,'uint32');
%{
 Cr?ons des tableaux pour prendre en compte la liste cumulative des
 restrictions form?es par la diagonale gauche (D1s), la diagonale droite
 (D2s) et les projections de colonne (Bs).
%}
            D1s=zeros(1,n2,'uint16');
            D2s=zeros(1,n2,'uint16');
            Bs=zeros(1,n,'uint16');
%{
 Sur la base des informations sur les lignes et colonnes libres restantes,
 nous ?crivons z?ro dans les cellules libres correspondantes du tableau L.
 Nous formons les tableaux Cs, Ds, Bs, ainsi que les tableaux 
 de comptabilit? rAr, tAr. Pour toutes les lignes (nRow) et,
 par cons?quent, pour les positions libres restantes dans ces lignes,
 nous formons une liste cumulative de restrictions pour les projections
 diagonales gauche D1 et droite D2, ainsi que pour les projections
 de la colonne Bs.
%}
            for p=1:nRow
                i=A(p);
                for q=1:nRow
                    j=B(q);
                    r=n+j-i;
                    t=j+i;
                    if D1(r)==0 && D2(t)==0
                        L(p,q)=0;
                        rAr(p,q)=r;
                        tAr(p,q)=t;
                        D1s(r)=D1s(r)+1;
                        D2s(t)=D2s(t)+1;
                        Bs(j)=Bs(j)+1;
                    end
                end
            end   
 
% Nous calculons la somme des ?l?ments de chaque ligne du tableau L

            rowSum=sum(L==0,2);  
%{
 Nous trions les valeurs de somme dans l'ordre croissant du nombre
 de positions libres dans la ligne.
%}
            [sumSort,rowRangInd]=sort(rowSum);
%{
 Ici, dans le tableau rowRangInd, les indices de ligne sont stock?s
 s?quentiellement avec un nombre croissant de positions libres dans
 la ligne.
%}
            if sumSort(1)>0                 
%{
 Ici sumSort(1) est le nombre minimum de positions libres dans la liste
 de toutes les lignes du tableau L(nRow,nRow).
%}

%{
 Si le nombre minimum de positions libres est sup?rieur ? z?ro, 
 alors nous continuons la solution et construisons la branche
 de la recherche.
%} 

%{
 Cr?ez un tableau de contr?le comptable E de taille nRow x nRow,
 dans chaque cellule dont nous allons stocker la valeur totale
 des restrictions correspondantes.
%}
            E=zeros(nRow,nRow,'uint16');
%{
 Nous calculons et stockons dans le tableau E la valeur totale des
 contraintes des tableaux comptables de contr?le.
%}
            for p=1:nRow
                for q=1:nRow
                    r=rAr(p,q); %  Index r for array Cs
                    t=tAr(p,q); % Index t for array Ds
                    j=B(q);     % Index j for array Bs
                    if r>0 && t>0
                        E(p,q)=D1s(r)+D2s(t)+Bs(j);
                    end
                end
            end
            
% Supprimer les tableaux qui ne seront plus utilizes.            
            
            clear D1s D2s Bs

% Ensuite, au lieu des tableaux D1, D2 et Bs, nous utiliserons le tableau E.          
 
%{
 Avant de passer ? l'?v?nement suivant, nous enregistrerons une copie
 de ces tableaux pour les r?utiliser.
%}
                Az=A;
                Bz=B;
                Qz=Q;
                Lz=L;
                
                Ez=E;
                zPos=totPos;
%{
 Nous avons termin? les travaux pr?paratoires du Bloc-4. Ensuite,
 nous allons au Bloc-5.
%}
                activeEvent=5;
                
            else  % if sumSort(1)>0                
%{
 S'il s'av?re que parmi les rang?es restantes, il y a des ?ufs dans
 lesquels il n'y a pas de position libre, cela signifie:

 a) Si eventInd = 4, la composition initiale ne peut pas ?tre termin?e,
 car dans la composition il y a au moins une ligne libre sans position
 libre. (On peut dire que cette composition est n?gative depuis
 la «naissance»).

 b) Si eventInd <3, alors nous devons retourner au Bloc-2 et r?p?ter
 la formation de la branche de recherche.
%}
                if eventInd<3                  
%{
 Si l'index d'?v?nement est 1 ou 2, alors nous revenons au d?but du Bloc-3.
 Pour ce faire, avant de passer au Bloc-3, nous allons restaurer l'?tat
 initial des tableaux de contr?le que nous avions ? la fin du Bloc-2.
%}
                    A=Ay;
                    B=By;
                    D1=D1y;
                    D2=D2y;
                    Q=Qy;
                    
                    L=Ly;
                    rAr=rAr_y;
                    tAr=tAr_y;
            
                    totPos=yTotPos;
                    
                    activeEvent=3;
                    
% On incr?mente le compteur total du nombre de calculs r?p?t?s.

                    totSimCount= totSimCount+1;                     
                    
                elseif eventInd > 3                    
%{
 Si eventInd == 4, cela signifie que la taille de la composition ?tait
 telle que nous sommes imm?diatement pass?s ? ce niveau, en contournant
 les niveaux 1, 2 et 3. Et puisque parmi toutes les lignes libres restantes,
 il y a au moins une ligne dans laquelle il y a pas de position libre,
 alors cette composition ne peut initialement pas ?tre compl?t?e.
 Par cons?quent, nous affichons le message appropri? et interrompons
 le programme.
 
 Nous avons d?fini la variable compositionInd sur -1 pour corriger
 que cette composition est initialement n?gative et ne peut pas ?tre
 compl?t?e. De plus, nous attribuons z?ro ? la variable processInd pour
 interrompre la poursuite du fonctionnement du programme
%}

                    solutionInd=2;
                    
                    processInd=0;
                    
                    break
                end
                
            end  %if sumSort(1)>0

% Apr?s les travaux pr?paratoires du Bloc-4, nous passons au Bloc-5.
                        
        case 5    
%{
 Bloc-5. L'?tape finale de la r?solution de probl?mes.
 -----------------------------------------------------
 Nous sommes au dernier niveau de solution de base. Il reste quelques
 lignes libres jusqu'? la fin de la solution. Si, ? partir de ce niveau,
 en train de r?soudre le probl?me, la branche de recherche m?ne
 ? un blocage, alors nous reviendrons ? ce niveau de base. ? cette ?tape,
 nous devons choisir une seule position dans une rang?e libre,
 pour l'emplacement de la reine. Dans cette ?tape, le nombre
 de possibilit?s d'un tel choix est ?gal ? la somme des positions libres
 dans toutes les lignes libres restantes. Les deux boucles imbriqu?es
 utilis?es dans le Bloc-5 n'ont qu'un seul objectif, s?lectionner l'index
 d'une ligne libre ? un niveau donn? et s?lectionner la position libre
 dans cette ligne. Toute la recherche suppl?mentaire des lignes libres
 restantes est effectu?e uniquement dans la troisi?me boucle imbriqu?e.
 Par cons?quent, d'abord dans le Bloc-5:

 - nous s?lectionnons la ligne avec le nombre minimum de positions
 libres;

 - nous s?lectionnons une position libre dans cette rang?e et pla?ons
 la reine.

 Apr?s cela, la s?quence d'actions suivante est effectu?e dans la
 troisi?me boucle:
 
 a)Parmi les lignes libres restantes, nous s?lectionnons une ligne avec
 le nombre minimum de positions libres,
 
 b) Parmi les positions libres de la ligne s?lectionn?e, nous s?lectionnons
 cette position qui cause un dommage minimal ? toutes les positions
 libres restantes.
 
 Ce cycle se poursuit jusqu'? l'obtention d'une solution compl?te. Si,
 ? un moment donn?, la branche de recherche aboutit ? un blocage,
 le cycle est interrompu. Sur la base des copies de sauvegarde,
 tous les tableaux et variables correspondant au niveau de base actuel
 sont restaur?s. Dans ce cas, la troisi?me boucle imbriqu?e se r?p?te
 ? nouveau, sans aucune modification des param?tres des premi?re et
 deuxi?me boucles imbriqu?es. Le nombre de ces calculs r?p?t?s au niveau
 de la troisi?me boucle imbriqu?e ne doit pas d?passer la valeur limite
 de repeatBound. Si le nombre de r?p?titions d?passe la valeur
 de repeatBound, dans ce cas, apr?s le retour au niveau de base,
 les param?tres des deux premi?res boucles imbriqu?es changent comme
 d'habitude. L'utilisation d'un tel mod?le de trois boucles imbriqu?es
 n'est pas enti?rement ?vidente ? premi?re vue. Le fait est que dans les
 cas o? il y a plusieurs lignes avec la m?me valeur minimale du nombre
 total de positions libres, nous s?lectionnons au hasard l'indice
 de l'une de ces deux lignes (ou un indice al?atoire de l'une des trois
 lignes si trois lignes ont la m?me valeur minimale). De m?me,
 une s?lection al?atoire d'une position libre dans une rang?e est 
 effectu?e si deux positions dans une rang?e causent le m?me dommage 
 minimal ? toutes les positions libres restantes. (Ici, une s?lection 
 al?atoire est faite de seulement deux positions qui causent le m?me
 dommage minimal). Nous utilisons un tel algorithme avec un seul but afin
 de maximiser l'utilisation des "ressources de t?ches" qui restent ? cette
 ?tape. Plus la fin de la solution est proche, moins il est probable 
 que la ligne libre s?lectionn?e aura une position libre. Selon la r?gle
 du risque minimum, nous devons d'abord placer la reine dans cette rang?e
 libre, o? le nombre de positions libres est minime. Voil? ce que nous
 faisons. Mais dans les situations o? deux lignes ou deux positions libres
 ont les m?mes caract?ristiques minimales, nous s?lectionnons cet indice
 de mani?re al?atoire. Lorsque le troisi?me cycle imbriqu? est r?p?t?
 plusieurs fois sans modifier les param?tres du cycle, cela nous donne
 la possibilit? d'utiliser davantage de "capacit?s de ressources"
 de la t?che ? ce niveau, car ? certaines ?tapes de la formation 
 de la branche de recherche, une s?lection al?atoire est utilis?e.
%}

% Remettez ? z?ro le compteur du nombre de calculs r?p?t?s dans le Bloc-5

            simCount5=0;
%{
 Le cycle for iRow = 1: nRow sert ? l'analyse s?quentielle des lignes
 libres restantes, class?es par ordre croissant du nombre total 
 de positions libres dans la ligne. Les indices des lignes correspondantes
 sont stock?s dans le tableau rowRangInd(1:nRow). Ici nRow est le nombre
 de lignes libres restantes. Le tableau rowRangInd des calculs 
 correspondants a ?t? effectu? dans le Bloc-4.
%}
            
            for iRow=1:nRow   % Premi?re boucle imbriqu?e (externe)             
                
% Choisissez une ligne dans la liste class?eþ

                selectRowInd=rowRangInd(iRow);
 
%{
 selectRowInd est l'index de ligne dans le tableau L. D?terminons
 la valeur initiale de l'index de ligne sur l'?chiquier, qui dans
 le tableau L correspond ? l'index selectRowInd.
 La valeur de baseRowInd sera n?cessaire ult?rieurement pour des
 calculs r?p?t?s.
%}              
 
                baseRowInd=A(selectRowInd);
                
%{
 Copiez la ligne avec index selectRowInd du tableau L dans 
 le tableau temporaire T
%} 
                T=L(selectRowInd,:);         
%{
 D?finissez les indices de position libre dans cette ligne et enregistrez
 le r?sultat dans le tableau baseFreePosAr (encore une fois, notez que
 les positions nulles dans le tableau L correspondent aux positions libres
 dans la matrice de solution d'origine)
%}
                baseFreePosAr=find(T==0);
 
% D?finissez le nombre total de positions libres (nFreePos) dans cette ligne
 
                nFreePos=length(baseFreePosAr);
%{
 La boucle for jCol = 1: nFreePos est utilis?e pour les positions libres
 d'analyse s?quentielle dans la ligne.
%}
                for jCol=1:nFreePos  % Boucle imbriqu?e-2					                                        
 
% Attribuer i l'indice r?el de la ligne s?lectionn?e

                    i=baseRowInd;                   
%{
 Dans le tableau baseFreePosAr, nous s?lectionnons l'index de la colonne,
 qui est ?crit dans la cellule avec le nombre jCol. Ici jPos est l'indice
 de colonne du tableau L.
%}
                    jPos=baseFreePosAr(jCol); 

                    jPosBase=jPos;                    
%{
 On d?termine la valeur r?elle de l'index de colonne (j), qui correspond
 ? l'?chiquier en question
%}
                    j=B(jPos);

%{
 Enregistrez la valeur de j dans la variable baseFreePos pour des calculs
 r?p?t?s
%}
                    baseFreePos=j;                    
%{
 Attribuez ? la variable minRowInd la valeur de l'index de ligne 
 du tableau L, qui a le nombre minimum de positions libres dans la ligne.
%}
                    minRowInd=selectRowInd;
 
% Z?ro le nombre de tentatives de la troisi?me boucle imbriqu?e.

                    repeatCount=0;                    
%{
 La boucle while totPos <n est la troisi?me boucle imbriqu?e, o?, ? chaque
 ?tape, une position libre est recherch?e pour que la reine soit situ?e
 dans l'une des lignes libres restantes.
%}
                    while totPos < n  % Boucle imbriqu?e-3					                               
%{
 La valeur d'index initiale de la ligne s?lectionn?e (i) et la valeur
 d'index de colonne (j) pour la premi?re ?tape, nous avons d?termin?
 ci-dessus (dans le Bloc 4), avant d'entrer dans le cycle. Dans le 
 tableau Q de la ligne (i), nous enregistrons l'indice (j) 
 de la position reine.
%}                           
                        Q(i)=j;
                        
% On incr?mente le compteur du nombre de reines install?es.

                        totPos=totPos+1;
                                                                                             
% V?rifiez si une solution compl?te est form?e, puis arr?tez les calculs.

                        if totPos==n
				    solutionInd=1;
                            processInd=0;                            
                            break
                        end                       
%{
 Nous avons utilis? le r?sultat pr?par? dans le Bloc-4 et plac? la reine
 dans la cellule (i,j) de la matrice de solution. Ainsi, nous avons
 termin? le cycle suivant de d?termination de la position sur l'?chiquier
 pour l'emplacement de la reine. Apr?s cela, nous devons changer 
 les cellules correspondantes dans tous les tableaux de contr?le,
 ?tant donn? les indices (minRowInd, jPos) du tableau L.
%}
                        A(minRowInd)=0;
 
                        B(jPos)=0;                                              
%{
 Modifier les cellules correspondantes du tableau L en utilisant les index
 ?quivalents stock?s dans les tableaux rAr et tAr.
%}                       
                        rx=n+j-i;
                        tx=j+i;
                        
                        rxInd=find(rAr==rx);
 
                        L(rxInd)=1;
                        
                        txInd=find(tAr==tx);
 
                        L(txInd)=1;
                                              
%{
 Nous d?cr?mentons la valeur du tableau de contr?le cumulatif E, car nous
 avons plac? la reine ? la position (i,j).
%}
                        E(rxInd)=E(rxInd)-1;
                        E(txInd)=E(txInd)-1;
                        
% ?crivez 1 ? toutes les cellules actives dans la colonne jPos du tableau L

                        A1=find(A>0);
 
                        L(A1,jPos)=1;                        
%{
 ? cette ?tape, ? l'int?rieur de la boucle while totPos <n, nous avons
 effectu? les actions suivantes:
 - nous pla?ons la reine dans la cellule (i,j), en utilisant
   les informations pr?par?es pr?c?demment;
 - effectu? les actions proc?durales n?cessaires avec des tableaux de
   contr?le, apr?s que la reine est plac?e dans la cellule (i,j).
%}

%{
 S?lection d'une rang?e libre et d'une position libre dans la rang?e
 -------------------------------------------------------------------
 Maintenant, parmi les lignes libres restantes, nous trouvons la ligne
 avec le nombre minimum de positions libres, et parmi ces positions nous
 choisissons celle qui, dans le cas de la fermeture de la position,
 causera un dommage minimal ? toutes les positions libres restantes
 dans les autres positions libres Lignes. Pour le faire, suivez ces ?tapes:
%}

%{
 1.D?finissez le nombre de positions libres dans chaque rang?e
   libre restante
%}

                        rowSum=sum(L(A1,:)==0,2);
%{
 2. Nous classons le tableau rowSum dans l'ordre croissant.
                        
 3. Enregistrez les valeurs class?es des sommes dans le tableau freePosAr
    et les indices des lignes correspondantes dans le tableau rowIndAr.
%} 
                        [freePosAr,rowIndAr]=sort(rowSum);
%{
 ?tant donn? qu'? ce stade, nous suivons simultan?ment l'?tat de toutes
 les lignes libres restantes, cela nous donne l'opportunit? d'?tablir
 si une telle situation s'est produite que dans l'une des lignes restantes,
 le nombre de positions libres est nul. Dans ce cas, nous consid?rons
 la branche de recherche g?n?r?e comme un blocage et revenons au d?but
 du cycle.
 Cette approche nous permet de reporter la pr?vision - nous arr?tons les
 calculs avant qu'il ne soit ?tabli ? l'?tape suivante qu'il n'y a pas
 de position libre dans la ligne.
%}

%{
 Voici le point de contr?le pour la branche de recherche g?n?r?e. Si, dans
 chacune des lignes libres restantes, il y a au moins une position libre,
 alors la formation de la branche de recherche continue.
%}
                        if freePosAr(1)>0                            
%{
 Il se peut que dans une liste class?e, les deux premiers ?l?ments de la
 liste ou les trois premiers ?l?ments de la liste aient la m?me valeur
 minimale. Dans ce cas, nous s?lectionnons au hasard l'indice de l'une
 des deux lignes avec la m?me valeur minimale (ou, l'indice de l'une des
 trois lignes, s'il y en a trois).
%} 
 
                            if numel(freePosAr)==1||freePosAr(1)<freePosAr(2)
                                
                                randPos=1;
                                
                            elseif numel(freePosAr)>2 && freePosAr(1)==freePosAr(3)
                                
                                randPos=randi(3);
                            else
                                
                                randPos=randi(2);
                                
                            end
 
                            minRow=rowIndAr(randPos);
                            
                            minRowInd=A1(minRow); 
%{
 Nous d?terminons le nombre de positions libres dans la ligne s?lectionn?e
 et stockons les indices de ces lignes dans le tableau freePosAr.
%}                          
                            freePosAr=find(L(minRowInd,:)==0);
                            
% D?finir le nombre de positions libres (nFreePos)

                            nFreePos=length(freePosAr);
%{
 Parmi ces positions, nous choisissons celle qui ferme le nombre minimum
 de positions libres dans les rang?es restantes. Pour ce faire,
 nous utilisons le tableau E. Si deux lignes ont le m?me nombre minimum
 de positions libres, nous s?lectionnons au hasard l'indice jPos de l'une
 d'entre elles. Ici, nous introduisons un ?l?ment de hasard «sain» dans
 l'algorithme dans tous les cas o? deux rang?es ont le m?me nombre
 de positions libres.
%}
                            if nFreePos==1
                                jPos=freePosAr(1);
                            else
                                    
                                T=E(minRowInd,freePosAr);
 
                                [tSort,tInd]=sort(T);
                                    
                                if tSort(1)<tSort(2)
                                    jPos=freePosAr(tInd(1));
                                       
                                else                                        
                                    jInd=randi(2);
                                    jPos=freePosAr(tInd(jInd));
                                end
                            end                            
%{
 Sur la base du tableau d'indices source A, nous restaurons l'index r?el
 i ligne donn?e.
%}
                            i=A(minRowInd);                                                       
%{
 Sur la base du tableau des indices source B, nous restaurons l'indice
 r?el j cette colonne                            
%}                               
                            j=B(jPos); 
 
                        else  %if numel(rowSum)>0 && freePosAr(1)>0                                                       
%{
 S'il s'av?re qu'il n'y a pas de positions libres dans la ligne,
 cela signifie que la branche de recherche a conduit ? un blocage.
 Dans ce cas, nous fermons la branche de recherche et incr?mentons les
 compteurs: repeatCount, simCount5, totSimCount.
%}
                            repeatCount=repeatCount+1;
                            simCount5=simCount5+1;
                            totSimCount=totSimCount+1;
%{
 Nous allons restaurer les valeurs de tous les tableaux de contr?le
 (au d?but de l'ex?cution du cycle while totPos <n) et transf?rer le
 contr?le au d?but du cycle. Si le nombre d'utilisations r?p?t?es du cycle
 (alors while totPos < n) ne d?passe pas la valeur de seuil repeatBound,
 alors le contr?le est transf?r? au d?but du cycle while totPos < n, sans
 changer les param?tres de deux cycles externes        
%}                            
                            A=Az;
                            B=Bz;
                            Q=Qz;
                            L=Lz;
                            E=Ez;
                            
                            totPos=zPos;
                            
                            i=baseRowInd;
                            j=baseFreePos;
                            minRowInd=selectRowInd;
                            jPos=jPosBase;


                            
                            if repeatCount>repeatBound                               
%{
 Si le nombre de r?utilisation de boucle (while totPos < n) d?passe
 le seuil repeatBound, le contr?le est transf?r? vers la boucle externe
 while jCol<=colPos. Ci-dessus, nous avons restaur? les param?tres
 correspondants pour la transition.
%}

                                repeatCount=0;
                                i=baseRowInd;                                
                                
                                break
                                %  Sortie de la boucle while totPos <n
                                % Exiting the loop while totPos <n
                                % Aller ? la suite du cycle while jCol<=colPos
                                % Going into the while jCol <= colPos loop
                            end                         
                            
                        end  %if numel(rowSum)>0 && freePosAr(1)>0                                      
                      
                    end  %while totPos < n 
                                     
                        if processInd==0
                            break
                            % Sortie de la boucle while jCol<=colPos
                            % Exiting the while jCol <= colPos loop
                        end
 
                 end  %while jCol<=colPos
                 
                 if processInd==0
                     break
                     % Sortie de la boucle  for iRow=1:nRow
                     % Exit the loop for iRow = 1: nRow
                 end 
%{
 Ici, ? l'int?rieur de la boucle for iRow = 1: nRow, se trouve le seul
 endroit o? nous contr?lons totSimCount. Si la valeur de totSimCount
 d?passe la valeur de totRepeatBound, un message s'affiche indiquant
 que la probabilit? que cette composition puisse ?tre compl?t?e
 jusqu'? ce que la solution compl?te soit inf?rieure ? 0,0001.
%} 
                    if totSimCount > totSimBound
                        solutionInd=3; 
                        break                                      
%{
 Soit totSimCount <= totSimBound. Ensuite, si, apr?s avoir quitt? le cycle:
 while jCol <= colPos, il s'av?re que le nombre de nouveaux tests
 ? ce niveau (simCount5) d?passe les limites autoris?es (simBound5),
 alors dans le cas eventInd <3, nous transf?rons le contr?le 
 ? l'?v?nement 2. Si eventInd == 4, le programme continue,
 sous r?serve de restrictions.
%}
                    elseif simCount5 > simBound5 && eventInd<3
                        
                        A=Ay;
                        B=By;
                        D1=D1y;
                        D2=D2y;
                        Q=Qy;
                        
                        L=Ly;
                        rAr=rAr_y;
                        tAr=tAr_y;
                        
                        totPos=yTotPos;

                        simCount3=0;
                        simCount5=0;
                        
                        activeEvent=3;
                        break
                    end
                          
            end  %for iRow=1:nRow
%{
 Si solutionInd == 3, alors nous incr?mentons le compteur de cycle complet
 falseNegSimCount.
 Si la valeur du compteur ne d?passe pas le falseNegSimBound,
 nous retournons le contr?le au d?but du recomptage, selon la valeur
 de l'?v?nement            
%}
          if solutionInd==3
                     
                if falseNegSimCount < falseNegSimBound
                    
                    falseNegSimCount=falseNegSimCount+1;
                                             
                    switch eventInd
 
                        case 1
                            
                    % Restaurer les baies et transf?rer le contr?le ? l'?v?nement 1
                            A=Ax;
                            B=Bx;
                            D1=D1x;
                            D2=D2x;
                            Q=Qx;
 
                            totPos=xTotPos;
                            activeEventInd=1;
 
                         case 2
                   % Restaurer les baies et transf?rer le contr?le ? l'?v?nement 3        
                            A=Ay;
                            B=By;
                            D1=D1y;
                            D2=D2y;
                            Q=Qy;
                            L=Ly;
                            rAr=rAr_y;
                            tAr=tAr_y;
 
                            totPos=yTotPos;
                            activeEventInd=3;
 
                         case 4
                   % Restaurer les baies et transf?rer le contr?le ? l'?v?nement 5
                            A=Az;
                            B=Bz;
                            Q=Qz;
                            L=Lz;
                            E=Ez;
 
                            totPos=zPos;
                            activeEventInd=5;                                 
                    end
                         
                 % remise ? z?ro des compteurs pour les ?v?nements correspondants
                    
                    simCount3=0;
                    simCount5=0;
                    totSimCount=0;                                                                   
                else
                    processInd=0;
                    break
                end
          end  
            
            if processInd==0
                break                    
            end
            
    end  %switch event
    
end  %while processInd==1
      
toc

tStr = sprintf('Number of complete re-counting cycles = %d',falseNegSimCount);
disp(tStr)
 
if falseNegSimCount>0
    totSimCount= falseNegSimCount*totSimBound + totSimCount;
end
    
tStr = sprintf('Total number of usage the Back Tracking procedure = %d',totSimCount);
disp(tStr)
 
if solutionInd == 1
    disp(' ');
    disp('Solution is Ok!');
else
    disp('This composition cannot be completied!');
end
 
if solutionInd==3
    if n < 100
        tStr= sprintf('The error of such conclusion is less than 0.0001');
        disp(tStr);
    elseif n < 800
        tStr= sprintf('The error of such conclusion is less than 0.00001');
        disp(tStr);
    else
        tStr= sprintf('The error of such conclusion is less than 0.000001');
        disp(tStr);
    end
end
 
tStr = sprintf('The first %d positions of queens:',nDisp); disp(tStr)                    
disp(Q(1:nDisp));
 
%{
 Nous enregistrerons le r?sultat de l'ach?vement dans le fichier
 nQueens_Test_Completion_Solution.mat. Si ? la suite de la solution,
 il n'?tait pas possible de compl?ter la composition ? la solution
 compl?te, alors les valeurs nulles sont enregistr?es dans les cellules
 correspondantes du tableau Q.
 Le nom de fichier nQueens_Test_Completion_Solution.mat est donn? ? titre
 d'exemple. ?videmment, vous pouvez utiliser n'importe quel autre nom.
%}

outputFileName= 'nQueens_Test_Solution.mat';
 
if solutionInd == 1
    save(outputFileName,'Q');
    iInfo=['Solution saved in file: ' outputFileName];
    disp(iInfo);
end
 




