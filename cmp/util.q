fncify:{[p]
 if[99h<type p;:p];
 if[99h=type p;:{and[99h=type[x];x[key y]~value y]}[;p]];
 '`$"Predicate should be a function or a dictionary"}
