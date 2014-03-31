:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

zawod_jest(programista) :-
	jest_to(informatyk),
	pozytywne(lubisz, rozwiązywac_problemy),
	pozytywne(potrafisz, pracowac_w_zespole),
	pozytywne(wiesz, jak_tworzy_sie_oprogramowanie_komputerowe),
	negatywne(jestes, bardzo_leniwy),
	negatywne(jesteś, nieodpowiedzialny),
	pozytywne(znasz, jezyk_angielski),
	negatywne(nie, mozesz_usiedziec_w_jednym_miejscu).
	

zawod_jest(serwisant_komputerowy) :-
	jest_to(informatyk),
	pozytywne(lubisz, majterkowac),
	pozytywne(potrafisz, zlozyc_komputer_z_czesci).

zawod_jest(manager) :-
	jest_to(pracownik_umyslowy),
	pozytywne(lubisz, spotykac_sie_z_ludzmi),
	pozytywne(jestes, przebojowy),
	pozytywne(lubisz, pokazac_kto_tu_rzadzi).

zawod_jest(ksiegowy) :-
	jest_to(pracownik_umyslowy),
	pozytywne(lubisz, liczyc).

zawod_jest(nauczyciel) :-
	jest_to(pracownik_umyslowy),
	pozytywne(masz, cierpliwosc_do_dzieci),
	pozytywne(lubisz, pomagac_innym),
	pozytywne(potrafie, wysluchac_innych),
	pozytywne(masz, skonczone_studia_lub_planujesz).

zawod_jest(lekarz) :-
	jest_to(pracownik_umyslowy),
	pozytywne(lubisz, pomagac_innym),
	negatywne(nie, możesz_zniesc_widoku_krwi),
	pozytywne(swietnie, sie_uczysz),
	pozytywne(mam, dobry_kontakt_z_ludzmi).

zawod_jest(strazak) :-
	jest_to(pracownik_mundurowy),
	pozytywne(lubisz, pomagac_innym),
	pozytywne(ryzyko, to_Twoje_drugie_imie),
	pozytywne(jestes, wysportowany),
	pozytywne(jestes, odporny_na_stres).

zawod_jest(policjant) :-
	jest_to(pracownik_mundurowy),
	pozytywne(trudno, cie_wyprowadzic_z_rownowagi),
	pozytywne(jestes, nieprzekupny),
	negatywne(latwo, ulegasz_wplywom_innych),
	pozytywne(cenisz, sobie_sprawiedliwosc).
	

zawod_jest(kucharz) :-
	jest_to(pracownik_mundurowy),
	pozytywne(lubisz, przebywac_w_kuchni),
	pozytywne(uwielbiasz, gotowac),
	pozytywne(lubisz, nosic_biale_ubrania),
	negatywne(potrafisz, ugotowac_tylko_wode_na_kawe).

zawod_jest(gornik) :-
	jest_to(pracownik_mundurowy),
	jest_to(pracownik_fizyczny),
	pozytywne(chcialbys, pracowac_w_ciemnosciach).

zawod_jest(budowlaniec) :-
	jest_to(pracownik_fizyczny),
	pozytywne(chcialbys, budowac_lub_remontowac_domy),
	pozytywne(masz, ukonczona_lub_chcesz_isc_do_szkoly_o_profilu_budowlanym).

zawod_jest(kierowca) :-
	pozytywne(lubisz, jezdzic_samochodem),
	pozytywne(znasz, sie_troche_na_mechanice),
	negatywne(chcesz, spedzac_jak_najmniej_czasu_w_pracy).

jest_to(informatyk) :-
	jest_to(pracownik_umyslowy),
	pozytywne(lubisz, komputery).
	

jest_to(pracownik_umyslowy) :-
	pozytywne(chcesz, pracowac_glownie_umyslowo).
	

jest_to(pracownik_fizyczny) :-
	pozytywne(chcesz, pracowac_glownie_fizycznie),
	pozytywne(nie, boisz_sie_ciezkiej_pracy).

jest_to(pracownik_mundurowy) :-
	pozytywne(chcialbys, chodzic_w_mundurze_lub_w_stroju_charakterystycznym_tylko_dla_jednego_zawodu).


pozytywne(X, Y) :-
	xpozytywne(X, Y), !.

pozytywne(X, Y) :-
	not(xnegatywne(X, Y)),
	pytaj(X, Y, tak).

negatywne(X, Y) :-
	xnegatywne(X, Y), !.

negatywne(X, Y) :-
	not(xpozytywne(X, Y)),
	pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
	!, write('Czy '), write(X), write(' '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay), 
	odpowiedz(Replay, tak).


pytaj(X, Y, nie) :-
	!, write('Czy '), write(X), write(' '), write(Y), write(' ? (t/n)\n'),
	readln([Replay]),
	pamietaj(X, Y, Replay),
	odpowiedz(Replay, nie).    

odpowiedz(Replay, tak):-
	sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
	sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, tak),
	assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
	odpowiedz(Replay, nie),
	assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
	write('\n\nNacisnij enter aby zakonczyc\n'),
	retractall(xpozytywne(_, _)),
	retractall(xnegatywne(_, _)),
	readln(_).

wykonaj :-
	zawod_jest(X), !,
	write('Twoim idealnym zawodem może być:  '), write(X), nl,
	wyczysc_fakty.

wykonaj :-
	write('\nNie jestem w stanie odgadnac, '),
	write('Twoich predyspozycji zawodowych.\n\n'), wyczysc_fakty.


	
