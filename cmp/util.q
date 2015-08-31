/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

fncify:{[p]
 if[99h<type p;:p];
 if[99h=type p;:{and[99h=type[x];x[key y]~value y]}[;p]];
 '`$"Predicate should be a function or a dictionary"}

mutator:{[f;argc]
 if[argc=1;:{[x;f]X:`.[x];@[`.;x;:;f[X]];:x}[;f]];
 if[argc=2;:{[x;y;f]X:`.[x];@[`.;x;:;f[X;y]];:x}[;;f]];
 if[argc=3;:{[x;y;z;f]X:`.[x];@[`.;x;:;f[X;y;z]];:x}[;;;f]];
 if[argc=4;:{[x;y;z;t;f]X:`.[x];@[`.;x;:;f[X;y;z;t]];:x}[;;;;f]];
 '`$"Mutator currently only alters functions with valence 1/2/3/4"}

