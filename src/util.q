/xxx
/util.q
/xxx

fncify:{
  [p]
  if[99h<type p;:p];
  if[99h=type p;:{and[99h=type[x];x[key y]~value y]}[;p]];
  '"Predicate should be a function or a dictionary"}

Set:{eval(:;x;({[x;y]x}[y;];0));:x}

mutator:{
  [f;argc]
  if[argc=1;:{[x;f]:Set[x;f[eval[x]]]}[;f]];
  if[argc=2;:{[x;y;f]:Set[x;f[eval[x];y]]}[;;f]];
  if[argc=3;:{[x;y;z;f]:Set[x;f[eval[x];y;z]]}[;;;f]];
  if[argc=4;:{[x;y;z;t;f]:Set[x;f[eval[x];y;z;t]]}[;;;;f]];
  '"Mutator currently only alters functions with valence 1/2/3/4"}

valence_counters:(`s#`short$())!()
valence_counters,:(enlist 100h)!(enlist {count[(value x)[1]]}) / functions
valence_counters,:(enlist 101h)!(enlist {1}) / unary primitives
valence_counters,:(enlist 102h)!(enlist {2}) / binary primitives
valence_counters,:(enlist 103h)!(enlist {3}) / ternary primitives
valence_counters,:(enlist 104h)!(enlist {1+valence[(value x)[0]]-sum each[{not[~[x;::]]};value x]}) / projection
valence_counters,:(enlist 105h)!(enlist {valence[(value x)[1]]})  / composition
valence_counters,:(enlist 106h)!(enlist {valence[value x]})  / each-both
valence_counters,:(enlist 107h)!(enlist {valence[value x]})  / over
valence_counters,:(enlist 108h)!(enlist {valence[value x]})  / scan
valence_counters,:(enlist 109h)!(enlist {valence[value x]})  / each-previous
valence_counters,:(enlist 110h)!(enlist {valence[value x]})  / each-right
valence_counters,:(enlist 111h)!(enlist {valence[value x]})  / each-left

valence:{[f](valence_counters[type[f]])[f]}

checktimer_:{[x]99h=type@[.timer;`timer]}
checktimer:{[]@[checktimer_;0;0b]}

about_timer:{[]
  0N!"Timer-related qdash functions depend on Natalie Inkpin's timer.q library.";
  0N!"The library is available at:";
  0N!"http://code.kx.com/wsvn/code/contrib/aquaqanalytics/Utilities/timer.q";}

ref:{({[x;y]x}[x];0)}

unarize:{[f]{[f;x;v]eval(f,ref each x[v])}[f;;til valence[f]]}

deunarize:{[f;v]
  if[0=v;:{[f;x]f[()]}[f]];
  if[1=v;:{[f;x]f[enlist x]}[f]];
  if[2=v;:{[f;x;y]f[(x;y)]}[f]];
  if[3=v;:{[f;x;y;z]f[(x;y;z)]}[f]];
  if[4=v;:{[f;x;y;z;t]f[(x;y;z;t)]}[f]];
  if[5=v;:{[f;x;y;z;t;u]f[(x;y;z;t;u)]}[f]];
  if[6=v;:{[f;x;y;z;t;u;v]f[(x;y;z;t;u;v)]}[f]];
  if[7=v;:{[f;x;y;z;t;u;v;w]f[(x;y;z;t;u;v;w)]}[f]];
  '"deunarize: valency cannot be greater than 7"}
