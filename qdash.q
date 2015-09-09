/xxx
/preamble.q
/xxx

\d .qdash

/xxx
/util.q
/xxx

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

fncify:{[p]
 if[99h<type p;:p];
 if[99h=type p;:{and[99h=type[x];x[key y]~value y]}[;p]];
 '`$"Predicate should be a function or a dictionary"}

Set:{eval(:;x;({[x;y]x}[y;];0));:x}

mutator:{[f;argc]
 if[argc=1;:{[x;f]:Set[x;f[eval[x]]]}[;f]];
 if[argc=2;:{[x;y;f]:Set[x;f[eval[x];y]]}[;;f]];
 if[argc=3;:{[x;y;z;f]:Set[x;f[eval[x];y;z]]}[;;;f]];
 if[argc=4;:{[x;y;z;t;f]:Set[x;f[eval[x];y;z;t]]}[;;;;f]];
 '`$"Mutator currently only alters functions with valence 1/2/3/4"}

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

/xxx
/array.q
/xxx

chunk:{y cut x}

compact:{
  [arr]
  arr:arr[where {not null x} each arr];
  :arr[where {x<>0} each arr]}

difference:except

drop:{sublist[(y;count x);x]}

dropRight:{sublist[(0;(count x)-y);x]}

dropRightWhile:{
  [arr;pred]
  pred:fncify[pred];
  n:count[arr];
  while[and[n>0;pred[arr[n-1]]]; n-:1];
  :arr[til n]}

dropWhile:{
  [x;pred]
  pred:fncify pred;
  :reverse dropRightWhile[reverse[x];{y[reverse[x]]}[;pred]]}

fill:{
  [x;v;L;R]
  L|:0;
  R&:count[`.[x]];
  if[L<R;.[`.;(x;L+til[R-L]);:;v]];:x}

findIndex:{
  [x;pred]
  pred:fncify pred;
  n:0;
  while[n<count x;if[pred[x[n]];:n];n+:1];
  :-1}

findLastIndex:{
  [x;pred]
  pred:fncify pred;
  n:(count x)-1;
  while[n>=0;if[pred[x[n]];:n];n-:1];
  :-1}

.qdash.first:first

flatten:raze

flattenDeep:{$[type x;:x;:(),/flattenDeep each raze x]}

indexOf:{
  if[z<0;z+:count x];
  z|:0;
  i:sublist[(z;count x);x]?y;
  if[(i+z)<count x;:i+z];
  :-1}

initial:{((count x)-1)#x}

/
Todo: figure out if there's a way to port
lodash's "intersection" that makes sense
with q's lack of variadic functions
\

.qdash.last:last

lastIndexOf:{
  c:-1+count x;
  z:$[z<0;-1-z;c-z];
  i:indexOf[reverse x;y;z];
  :$[i=-1;-1;c-i]}

pull:mutator[except;2]

pullAt:mutator[{x[(til count x) except y]};2]

filter:{
  [x;pred]
  pred:fncify pred;
  :exec c from ([]c:x) where pred[c]}

remove:mutator[filter;2]

rest:{$[c:count x;(1-c)#x;0#x]}

slice:{sublist[(y;z-y);x]}

sortedIndex:{$[(count x)=i:x?y;:1+bin[x;y];:i]}

sortedLastIndex:{1+bin[x;y]}

take:{$[y>count x;:x;:y#x]}

takeRight:{$[y>count x;:x;:(0-y)#x]}

takeRightWhile:{
  pred:fncify pred;
  i:0;
  c:count x;
  while[and[i<c;pred[(0-i)#x]];i+:1];
  :(0-i)#x}

takeWhile:{
  pred:fncify pred;
  i:0;
  c:count x;
  while[and[i<c;pred[i#x]];i+:1];
  :i#x}

/
Todo: figure out whether "union" can be ported in in a meaningful
way, given the lack of variadic functions in q
\

uniq:distinct

unzip:flip

unzipWith:{y each [flip x]}

without:except

xor:{except[x;y],except[y;x]}

zip:flip

zipObject:{(),/{((enlist (x[0]))!(rest x))} each x}

zipWith:{y each [flip x]}

/xxx
/chain.q
/xxx

chain_:{`value`tap`thru`fncs!(x;{chain_[x[y];(z,x)]}[;x;y];{y[x]}[x;];y)}
chain:chain_[;()]

tap:{c:chain[y[x[`value]]];c.fncs,:y;:c}

thru:{y[x[`value]]}

.qdash.value:{x[`value]}

plant:{x[`value]:(y{y[x]}/x[`fncs]);:x}

/xxx
/collection.q
/xxx

at:{x[y]}

countBy:{
  m:y{x[y]}/:x;
  u:distinct m;
  u!({count where y=x}[;m] each u)}

every:{
  [x;pred]
  pred:fncify pred;
  i:0;
  c:count x;
  while[i<c;$[pred[x[i]];i+:1;:0b]];
  :1b}

/see array.q for the 'filter' function

find:{
  pred:fncify pred;
  i:0;
  c:count x;
  while[i<c;$[pred[x[i]];:x[i];i+:1]];
  :x[c]}

findLast:{find[reverse x;y]}

findWhere:find

forEach:{
  [x;f]
  i:0;
  X:$[99h=type x;value x;x];
  c:count X;
  while[i<c;$[f[X[i]]~0b;:x;i+:1]];
  :x}

forEachRight:{reverse forEach[reverse x;y]}

groupBy:{
  m:y{x[y]}/:x;
  u:distinct m;
  u!({z[where y=x]}[;m;x] each u)}

includes:{
  c:count x;
  $[z<0;
    [z+:c;z|:0];
    z>=c;
    :0b;
    [while[z<c;$[x[z]~y;:1b;z+:1]];
    :0b]]}

indexBy:{
  m:y{x[y]}/:x;
  u:distinct m;
  d:u!((count u)#(::));
  i:0;
  c:count x;
  while[i<c;d[m[i]]:x[i];i+:1];
  :d}

invoke:{map[x;y[;z]]}

map:{y{x[y]}/:x}

partition:{
  [x;pred]
  pred:fncify pred;
  m:map[x;pred];
  :(x[where m<>0];x[where m=0])}

pluck:{map[x;{x[y]}[;y]]}

reduce:{y/[z;x]}

reduceRight:{y/[z;reverse x]}

reject:{
  [x;pred]
  pred:fncify pred;
  filter[x;{not[y[x]]}[;pred]]}

sample:{x[y?count x]}

shuffle:{x[(neg c)?(c:count x)]}

size:count

some:{
  [x;pred]
  pred:fncify pred;
  not every[x;{not y[x]}[;pred]]}

sortBy:{x[iasc[map[x;y]]]}

sortByAll:{
  if[0=count y;:x];
  (),/ {sortByAll[x;y]}[;rest y] each exec c from`v xasc`v xgroup([]c:x;v:y[0][x])}

sortByOrder:{
  T:`asc`desc!(::;{{0-y[x]}[;x]});
  sortByAll[x;{[x;y;z;T]T[z[x]][y[x]]}[;y;z;T] each til count z]}

qdash.where:filter

/xxx
/date.q
/xxx

now:{[]floor (`float$(.z.z-1970.01.01T00:00:00.000))*86400000}

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

/xxx
/postamble.q
/

\
