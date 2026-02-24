valida(NuevaFila, Lista) :-
    length(Lista, L),
    NuevaCol is L + 1,
    verificar(NuevaFila, NuevaCol, Lista, 1).

verificar(_, _, [], _).

verificar(NuevaFila, NuevaCol, [FilaAnterior | Resto], ColActual) :-
    NuevaFila =\= FilaAnterior,
    abs(NuevaFila - FilaAnterior) =\= abs(NuevaCol - ColActual),
    SiguienteCol is ColActual + 1,
    verificar(NuevaFila, NuevaCol, Resto, SiguienteCol).

dfs(EstadoActual, _, EstadoActual) :-
    length(EstadoActual, 8).

dfs(EstadoActual, Visitados, SolucionFinal) :-
    between(1, 8, NuevaFila),
    valida(NuevaFila, EstadoActual),
    append(EstadoActual, [NuevaFila], NuevoEstado),
    \+ member(NuevoEstado, Visitados),
    dfs(NuevoEstado, [NuevoEstado | Visitados], SolucionFinal).

solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).
