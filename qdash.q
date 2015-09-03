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

mutator:{[f;argc]
 if[argc=1;:{[x;f]X:`.[x];@[`.;x;:;f[X]];:x}[;f]];
 if[argc=2;:{[x;y;f]X:`.[x];@[`.;x;:;f[X;y]];:x}[;;f]];
 if[argc=3;:{[x;y;z;f]X:`.[x];@[`.;x;:;f[X;y;z]];:x}[;;;f]];
 if[argc=4;:{[x;y;z;t;f]X:`.[x];@[`.;x;:;f[X;y;z;t]];:x}[;;;;f]];
 '`$"Mutator currently only alters functions with valence 1/2/3/4"}


/xxx
/array.q
/xxx

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

chunk:{y cut x}

compact:{[arr]arr:arr[where {not null x} each arr];:arr[where {x<>0} each arr]}

difference:except

drop:{sublist[(y;count x);x]}

dropRight:{sublist[(0;(count x)-y);x]}

dropRightWhile:{
 [arr;pred]
 pred:fncify[pred];
 n:count[arr];
 while[and[n>0;pred[arr[n-1]]]; n-:1];
 :arr[til n]}

dropWhile:{y:fncify y;:reverse dropRightWhile[reverse[x];{y[reverse[x]]}[;y]]}

fill:{[x;v;L;R]L|:0;R&:count[`.[x]];if[L<R;.[`.;(x;L+til[R-L]);:;v]];:x}

findIndex:{y:fncify y;n:0;while[n<count x;if[y[x[n]];:n];n+:1];:-1}

findLastIndex:{y:fncify y;n:(count x)-1;while[n>=0;if[y[x[n]];:n];n-:1];:-1}

.qdash.first:first

flatten:raze

flattenDeep:{$[type x;:x;:(),/flattenDeep each raze x]}

indexOf:{if[z<0;z+:count x];z|:0;i:sublist[(z;count x);x]?y;if[(i+z)<count x;:i+z];:-1}

initial:{((count x)-1)#x}

/
Todo: figure out if there's a way to port
lodash's "intersection" that makes sense
with q's lack of variadic functions
\

.qdash.last:last

lastIndexOf:{c:-1+count x;z:$[z<0;-1-z;c-z];i:indexOf[reverse x;y;z];:$[i=-1;-1;c-i]}

pull:mutator[except;2]

pullAt:mutator[{x[(til count x) except y]};2]

filter:{y:fncify y;:exec c from ([]c:x) where y[c]}

remove:mutator[filter;2]

rest:{$[c:count x;(1-c)#x;0#x]}

slice:{sublist[(y;z-y);x]}

sortedIndex:{$[(count x)=i:x?y;:1+bin[x;y];:i]}

sortedLastIndex:{1+bin[x;y]}

take:{$[y>count x;:x;:y#x]}

takeRight:{$[y>count x;:x;:(0-y)#x]}

takeRightWhile:{y:fncify y;i:0;c:count x;while[and[i<c;y[(0-i)#x]];i+:1];:(0-i)#x}

takeWhile:{y:fncify y;i:0;c:count x;while[and[i<c;y[i#x]];i+:1];:i#x}

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

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

chain_:{`value`tap`thru`fncs!(x;{chain_[x[y];(z,x)]}[;x;y];{y[x]}[x;];y)}
chain:chain_[;()]

tap:{c:chain[y[x[`value]]];c.fncs,:y;:c}

thru:{y[x[`value]]}

.qdash.value:{x[`value]}

plant:{x[`value]:(y{y[x]}/x[`fncs]);:x}

/xxx
/collection.q
/xxx

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

at:{x[y]}

countBy:{m:y{x[y]}/:x;u:distinct m;u!({count where y=x}[;m] each u)}

every:{y:fncify y;i:0;c:count x;while[i<c;$[y[x[i]];i+:1;:0b]];:1b}

/see array.q for the 'filter' function

find:{y:fncify y;i:0;c:count x;while[i<c;$[y[x[i]];:x[i];i+:1]];:x[c]}

findLast:{find[reverse x;y]}

findWhere:find

forEach:{i:0;X:$[99h=type x;value x;x];c:count X;while[i<c;$[y[X[i]]~0b;:x;i+:1]];:x}

forEachRight:{reverse forEach[reverse x;y]}

groupBy:{m:y{x[y]}/:x;u:distinct m;u!({z[where y=x]}[;m;x] each u)}

includes:{c:count x;$[z<0;[z+:c;z|:0];z>=c;:0b;[while[z<c;$[x[z]~y;:1b;z+:1]];:0b]]}

indexBy:{
 m:y{x[y]}/:x;u:distinct m;d:u!((count u)#(::));i:0;c:count x;
 while[i<c;d[m[i]]:x[i];i+:1];:d}

invoke:{map[x;y[;z]]}

map:{y{x[y]}/:x}

partition:{y:fncify y;m:map[x;y];:(x[where m<>0];x[where m=0])}

pluck:{map[x;{x[y]}[;y]]}

reduce:{y/[z;x]}

reduceRight:{y/[z;reverse x]}

reject:{y:fncify y;filter[x;{not[y[x]]}[;y]]}

sample:{x[y?count x]}

shuffle:{x[(neg c)?(c:count x)]}

size:count

some:{y:fncify y;not every[x;{not y[x]}[;y]]}

sortBy:{x[iasc[map[x;y]]]}

sortByAll:{if[0=count y;:x];
 (),/{sortByAll[x;y]}[;rest y]each exec c from`v xasc`v xgroup([]c:x;v:y[0][x])}

sortByOrder:{T:`asc`desc!(::;{{0-y[x]}[;x]});
 sortByAll[x;{[x;y;z;T]T[z[x]][y[x]]}[;y;z;T] each til count z]}

qdash.where:filter

/xxx
/date.q
/xxx

now:{[]floor (`float$(.z.z-1970.01.01T00:00:00.000))*86400000}

/xxx
/postamble.q
/

\
