:- consult('config.pl').
:- consult('translations.pl'). 
:- consult('utils.pl').


:-dynamic rocher/2, arbre/2, vache/4, dimitri/2, round/1.

% initialisation 1

case_valide(X,Y):-
        largeur(Xmax),
        hauteur(Ymax),
        X>=0,
        Y>=0,
        X<Xmax,
        Y<Ymax.
case_valide_libre(X,Y):-
        case_valide(X,Y),
        not(occupe(X,Y)).

occupe(X,Y):-rocher(X,Y).
occupe(X,Y):-arbre(X,Y).
occupe(X,Y):-vache(X,Y,_,_).
occupe(X,Y):-dimitri(X,Y).
libre(X,Y):- repeat,
        largeur(Xmax),
        hauteur(Ymax),
        X is random(Xmax),
        Y is random(Ymax),
        not(occupe(X,Y)).


placer_rochers(0):- !.
placer_rochers(N):-
        libre(X,Y),
        !,
        assert(rocher(X,Y)),
        N1 is N-1,
        placer_rochers(N1).

placer_rochers:- 
        nombre_rochers(NR),
        log('Placement de rocher: ',info),log(NR,info),nl,
        placer_rochers(NR).

placer_arbres(0):- !.
placer_arbres(N):-
        libre(X,Y),
        !,
        assert(arbre(X,Y)),
        N1 is N-1,
        placer_arbres(N1).

placer_arbres:- nombre_arbres(NA),
        log('Placement d''arbres: ',info),log(NA,info),nl,
        placer_arbres(NA).


placer_vaches(0,_):- !.
placer_vaches(N,Type):- N>0,
        libre(X,Y),
        !,
        assert(vache(X,Y,Type,vache)),
        N1 is N-1,
        placer_vaches(N1,Type).


% I used findall to get all types of cows.
placer_vaches:- findall(Type,
                (nombre_vaches(Type,N),
                log('Placement de vaches de type: ',info),log(Type,info),write(' '),log(N,info),nl,
                placer_vaches(N,Type)),_).
                

placer_dimitri:- libre(X,Y),
        !,
        assert(dimitri(X,Y)).



vaches(L):-findall([X,Y],vache(X,Y,_,_),L).
vaches_saines(L):-findall([X,Y],vache(X,Y,_,vache),L).
vaches_zombies(L):-findall([X,Y],vache(X,Y,_,zombie),L).

creer_zombie:- vaches_saines(Vaches),
        length(Vaches,Len),
        Len > 0,
        N is random(Len),
        nth0(N,Vaches,[X,Y]),
        retract(vache(X,Y,Type,vache)),
        assert(vache(X,Y,Type,zombie)),
        log('Zombie cree!',warning),nl.

afficher:-afficher(0).
afficher(Y):-
        hauteur(Ymax),
        Y>=Ymax,
        !.
afficher(Y):-
        Y>=0,
        afficher_ligne(0,Y),
        nl,
        Y1 is Y+1,
        afficher(Y1).
        

afficher_ligne(X,_):- X<0, !.
afficher_ligne(X,_):-largeur(Xmax),X>=Xmax, !.
afficher_ligne(_,_):-write('  '),fail.
afficher_ligne(X,Y):-
        rocher(X,Y),
        rocher_char(Rocher_char,Color),
        write_color(Rocher_char,Color),
        X1 is X+1,
        afficher_ligne(X1,Y),!.

afficher_ligne(X,Y):-arbre(X,Y),
        arbre_char(Arbre_char,Color),
        write_color(Arbre_char,Color),
        X1 is X+1,
        afficher_ligne(X1,Y),!.

afficher_ligne(X,Y):-vache(X,Y,Type,Etat),
        vache_char(Type,Etat,Vache_char,Color),
        write_color(Vache_char,Color),
        X1 is X+1,
        afficher_ligne(X1,Y),!.

afficher_ligne(X,Y):-dimitri(X,Y),
        dimitri_char(Dimitri_char,Color),
        write_color(Dimitri_char,Color),
        X1 is X+1,
        afficher_ligne(X1,Y),!.

afficher_ligne(X,Y):-
        libre_char(Libre_char,Color),
        write_color(Libre_char,Color),
        X1 is X+1,
        afficher_ligne(X1,Y).


        
        
% le jeu:
question(Action):- % read 1 char
        log('Entrez votre choix: ',question),
        log('(n=nord, s=sud, e=est, o=ouest, a=reste): ',question),
        read(Ch),
        get_char(_), % pour consommer le retour a la ligne
        input_map(Ch,Action),
        log('Action: ',info),log(Action,info),nl.
question(Action):- % read 1 char
        log('choix invalide!',alert),nl,
        question(Action).


        
vache_voisine(X,Y,X,Y1,Etat):- Y1 is Y-1, vache(X,Y1,_,Etat).
vache_voisine(X,Y,X,Y1,Etat):- Y1 is Y+1, vache(X,Y1,_,Etat).
vache_voisine(X,Y,X1,Y,Etat):- X1 is X+1, vache(X1,Y,_,Etat).
vache_voisine(X,Y,X1,Y,Etat):- X1 is X-1, vache(X1,Y,_,Etat).

zombification(X,Y):- findall([X1,Y1],
        (vache_voisine(X,Y,X1,Y1,vache),
        retract(vache(X1,Y1,Type,vache)),
        assert(vache(X1,Y1,Type,zombie))),
        _).

zombification([]):-!.        
zombification([[X,Y]|L]):-zombification(X,Y),
        zombification(L).
zombification:-vaches_zombies(L),
        zombification(L).


deplacement_vache(X,Y,Xdest,Ydest):- 
        case_valide_libre(Xdest,Ydest),
        retract(vache(X,Y,Type,Etat)),
        assert(vache(Xdest,Ydest,Type,Etat)).

deplacement_vache(_,_,_,_).

deplacement_vache(X,Y,Direction):- Direction = nord,!,
        Ydest is Y-1,
        deplacement_vache(X,Y,X,Ydest).
deplacement_vache(X,Y,Direction):- Direction = sud,!,
        Ydest is Y+1,
        deplacement_vache(X,Y,X,Ydest).
deplacement_vache(X,Y,Direction):- Direction = est,!,
        Xdest is X+1,
        deplacement_vache(X,Y,Xdest,Y).
deplacement_vache(X,Y,Direction):- Direction = ouest,!,
        Xdest is X-1,
        deplacement_vache(X,Y,Xdest,Y).

deplacement_vache([]).
deplacement_vache([[X,Y]|L]):-
        random(0,4,N),
        nth0(N,[nord,sud,est,ouest],Direction),
        deplacement_vache(X,Y,Direction),
        deplacement_vache(L).


deplacement_zombie:-
        vaches_zombies(L),
        deplacement_vache(L).
deplacement_zombie.

deplacement_joueur(X,Y):-
        case_valide_libre(X,Y),
        retract(dimitri(_,_)),
        assert(dimitri(X,Y)).

deplacement_joueur(Direction):- Direction = nord,!,
        dimitri(X,Y),
        Ydest is Y-1,
        deplacement_joueur(X,Ydest).

deplacement_joueur(Direction):- Direction = sud,!,
        dimitri(X,Y),
        Ydest is Y+1,
        deplacement_joueur(X,Ydest).

deplacement_joueur(Direction):- Direction = est,!,
        dimitri(X,Y),
        Xdest is X+1,
        deplacement_joueur(Xdest,Y).

deplacement_joueur(Direction):- Direction = ouest,!,
        dimitri(X,Y),
        Xdest is X-1,
        deplacement_joueur(Xdest,Y).
deplacement_joueur(Direction):- Direction = reste,!.


round(0).
initialisation:- 
        log("Initialisation du jeu...",success),nl,
        placer_rochers,
        placer_arbres,
        placer_vaches,
        placer_dimitri,
        creer_zombie,
        log("Initialisation terminee",success),nl.    

reset:- 
        % etes vous surs de vouloir reinitialiser le jeu?
        log('etes vous surs de vouloir reinitialiser le jeu? [y/N]: ',warning),
        get_char(Ch),
        get_char(_), % pour consommer le retour a la ligne
        Ch = 'y',
        resset(1).

reset(1):-
        log("Reinitialisation du jeu...",success),nl,
        retractall(round(_)),
        assert(round(0)),
        retractall(rocher(_, _)),
        retractall(arbre(_, _)),
        retractall(vache(_, _, _, _)),
        retractall(dimitri(_, _)),
        jeu.

rejouer:- 
        log("voulez-vous rejouer? [y/N]: ",warning),
        get_char(Ch),
        get_char(_), % pour consommer le retour a la ligne
        Ch = 'y',
        reset(1).

verification:- dimitri(X,Y),
                not(vache_voisine(X,Y,_,_,zombie)).
                

jeu:-   round(Round),
        Round is 0,
        initialisation,
        afficher,!,
        next_round.

jeu:-   round(Round),
        log('Tour: '),write(Round),nl,
        question(Action),
        deplacement_joueur(Action),
        zombification,
        deplacement_zombie,
        afficher,!,       
        next_round.

next_round:-
        verification,!,
        round(Round),
        Round1 is Round+1,
        retract(round(Round)),
        assert(round(Round1)),
        jeu.

next_round:-nl,
        round(Round),
        log('Vous avez perdu!',alert),nl,
        log('Vous avez survecu ',success),log(Round,success),log(' tours!',success),nl,
        log('Fin du jeu!'),nl,
        rejouer.


