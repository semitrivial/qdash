/xxx
/function.q
/xxx

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

after:{[ptr;n;f]
 eval(:;ptr;
  $[n>1;
   {[x;y;z;t]after[x;y;z]}[ptr;n-1;f;];
   {[x]f[0]}]);:ptr}

before:{[ptr;n;f]
 eval(:;ptr;
  $[n>1;
   {[x;y;z;t]before[x;y;z];:z[0]}[ptr;n-1;f;];
   {[ptr;f;z]f0:f[0];eval(:;ptr;{[x;y]:x}[f0;]);:f0}[ptr;f;]])}

ary_hlp1:("[f]";"[f;x1]";"[f;x1;x2]";"[f;x1;x2;x3]";"[f;x1;x2;x3;x4]";"[f;x1;x2;x3;x4;x5]";"[f;x1;x2;x3;x4;x5;x6]";"[f;x1;x2;x3;x4;x5;x6;x7]")
ary_hlp2:("[]";"[x1]";"[x1;x2]";"[x1;x2;x3]";"[x1;x2;x3;x4]";"[x1;x2;x3;x4;x5]";"[x1;x2;x3;x4;x5;x6]";"[x1;x2;x3;x4;x5;x6;x7]")

ary:{[f;n]
 if[n<v:valence[f];'`$"New valence cap lower than initial valence"];
 if[n>7;'`$"ary has valence limit of 7"];
 if[n~v;:f];
 :(value["{",ary_hlp1[n],"f",ary_hlp2[v],"}"])[f]}

bind:{[f;x]
 if[0=v:valence[f];`$"Cannot bind 'this' on a 0-valence function"];
 if[1=v;:{[x;y]f[x]}[x]];
 :f[x]}

/
Todo: think of a way that bindAll would make sense in q
\

bindKey:{[dict;k]{[this;k;x](this[k])[this]}[dict;k;]}

curry:{x}

curryRight_:({[f;x]f[]};
 {[f;x]f[x]};
 {[f;x;y]f[y;x]};
 {[f;x;y;z]f[z;y;x]};
 {[f;x;y;z;t]f[t;z;y;x]};
 {[f;x1;x2;x3;x4;x5]f[x5;x4;x3;x2;x1]};
 {[f;x1;x2;x3;x4;x5;x6]f[x6;x5;x4;x3;x2;x1]};
 {[f;x1;x2;x3;x4;x5;x6;x7]f[x7;x6;x5;x4;x3;x2;x1]});

curryRight:{[f]
 v:valence[f];
 if[v>7;'`$"curryRight has valence limit 7"];
 :(curryRight_[v])[f]}

