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
