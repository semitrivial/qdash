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

timerIds:([hash:`guid$()]id:`int$())
timerbydesc:{[dsc]:(exec id from .timer.timer where (dsc~) each description)[0];}
timerbyhash:{[hash]:timerbydesc["Qdash timer ",string[hash]]}
canceltimer:{[hsh;i].timer.remove[i];delete from `.qdash.timerIds where hash=hsh;}
cncltmrhash:{canceltimer[x;timerbyhash[x]]}

debounce_:{[h;f;w;x]
 if[x~`cancel;:canceltimer[h]];
 $[null[timerIds[h][`id]];
   [dsc:"Qdash timer ",string[h];
     .timer.one[.z.p+w*1000000;(cncltmrhash;h);dsc;0];
     id:timerbydesc[dsc];
     timerIds,:`hash`id!(h;id);
     :f[]];
   [update nextrun:.z.p+w*1000000 from `.timer.timer where id=.qdash.timerIds[h][`id];]]}
debounce:{[f;w]
  if[not[checktimer[]];'"Debounce requires timer.q; run .qdash.about_timer[] for more info"];
  h:(1?0Ng)[0];
  :debounce_[h;f;w;]}

defer:{[f]
  if[not[checktimer[]];'"Defer requires timer.q; run .qdash.about_timer[] for more info"];
  if[0=.z.w;'"defer: can only be run when .z.w is not 0"];
  h:(1?0Ng)[0];
  F:{[f;h]if[0=.z.w;cncltmrhash[h];:f[]];}[f;];
  dsc:"Qdash timer ",string[h];
  .timer.rep[.z.p;.z.p+9999D00:00;0D00:00:00.1;(F;h);2h;dsc;0];}

delay:{[f;w]
  if[not[checktimer[]];'"Delay requires timer.q; run .qdash.about_timer[] for more info"];
  h:(1?0Ng)[0];
  dsc:"Qdash timer ",string[h];
  .timer.one[.z.p+w*1000000;({[f;h].qdash.cncltmrhash[h];:f[]}[f;];h);dsc;0];}

flow:{{x[y[z]]}[x;y;]}/

flowRight:{flow[reverse[x]]}

memoize:{[f;ptr]
  set[ptr;([k:enlist[8#(::)]]v:enlist[8#(::)])];
  F:{[f;ptr;x]
    if[x in !:[ptr];:ptr[x][`v]];
    insert[ptr;(x;v:f[x])];
    :v}[unarize f;ptr;];
  :deunarize[F;valence f]}

modArgs:{[f;args]
  if[count[args]<>v:valence[f];'length];
  :deunarize[{[f;args;x]f[args{x[y]}'x]}[unarize f;args];v]}

negate:{[f]deunarize[{not[x[y]]}[unarize f];valence f]}

once:{[f;ptr]
  v:valence f;
  F:{[f;ptr;v;x]ptr set deunarize[{[x;y]x}[r:f[x]];v];:r}[unarize[f];ptr;v];
  ptr set deunarize[F;v];
  :ptr}

partial:{[f;args]
  v:valence f;
  c:count args;
  if[c>v;'length];
  F:{[f;args;x]f[args,x]}[unarize[f];args];
  :deunarize[F;v-c]}

partialRight:{[f;args]
  v:valence f;
  c:count args;
  if[c>v;'length];
  F:{[f;args;x]f[x,args]}[unarize[f];args];
  :deunarize[F;v-c]}

rearg:{[f;ind]
  v:valence f;
  if[v<>count[ind];'length];
  F:{[f;ind;x]f[x[ind]]}[unarize f;ind];
  :deunarize[F;v]}

/
Todo: Figure out if there's a meaningful way to port "restParam"
\

spread:unarize

throttle_:{[h;f;w;x]
 if[x~`cancel;:canceltimer[h]];
 if[null[timerIds[h][`id]];
   dsc:"Qdash timer ",string[h];
   .timer.one[.z.p+w*1000000;(cncltmrhash;h);dsc;0];
   id:timerbydesc[dsc];
   timerIds,:`hash`id!(h;id);
   :f[]];}
throttle:{[f;w]
  if[not[checktimer[]];'"Throttle requires timer.q; run .qdash.about_timer[] for more info"];
  h:(1?0Ng)[0];
  :throttle_[h;f;w;]}

wrap:{partial[x;enlist y]}
