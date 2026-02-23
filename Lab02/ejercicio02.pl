power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

% Sacamos los hechos de la lista para tomarse por aparte

power(X, Daño, Costo) :-
    power_list(P),
    member(power(X, Daño, Costo), P).

villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

% Sacamos los hechos de la lista para tomarse por aparte

villain(X, Vida, Lista) :-
    villain_list(V),
    member(villain(X, Vida, Lista), V).

% Consulta si el villano es debil a cierto poder

debil(X, Y):- villain(X, _,Lista),
    member(Y, Lista).

% Calcular la vida de los villanos 

vida(X, Y):- villain(X, Y, _).

% Calcular el Gasto de energia

energia(X, Y):- power(X, _, Y).

% Busca las acciones que batman puede hacer

mover(
    estado(Villanos, Superpoderes, EnergiaActual),
    estado(VillanosRestantes, Superpoderes, NuevaEnergia)
) :-

    select(villain(_, Vida, Debilidades),
           Villanos,
           VillanosRestantes),

    member(power(Poder, Daño, Costo), Superpoderes),

    member(Poder, Debilidades),

    Daño >= Vida,

    EnergiaActual >= Costo,

    NuevaEnergia is EnergiaActual - Costo.

% Estado Meta

estado_meta(estado([], _, _)).

% Busqueda de DFS

	dfs(Estado, _) :-
    	estado_meta(Estado).

	dfs(Estado, Visitados) :-
    	mover(Estado, NuevoEstado),
    	\+ member(NuevoEstado, Visitados),
    	dfs(NuevoEstado, [NuevoEstado | Visitados]).

% Enunciado Final
 
batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villain),
    EstadoInicial = estado(Villain, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]).
