% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).

ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.

salto_maximo(4.0).

% Calcular la distancia de la rana con las piedras

distancia(P1, P2, S):-
    ubicacion(P1, X1, Y1),
    ubicacion(P2, X2, Y2),
    SX is X2 - X1,
    SY is Y2 - Y1,
    S is sqrt(SX*SX + SY*SY).

% Ver si es posible que la rana haga el salto

siguiente_estado(P1, P2):-
    distancia(P1, P2, S),
    salto_maximo(Maximo),
    S =< Maximo.

% Busqueda DFS para encontrar el camino correcto

dfs(Posible, Posible, _).

dfs(Actual, Meta, Pasados) :-
    siguiente_estado(Actual, Siguiente),
    \+ member(Siguiente, Pasados),
    dfs(Siguiente, Meta, [Siguiente|Pasados]).

% Busqueda DFS para encontrar la orilla final desde la inicial

puede_llegar :-
    dfs(orilla_inicial, orilla_final, [orilla_inicial]).
    
