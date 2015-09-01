/xxx
/array.q
/xxx

/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

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

dropWhile:{y:fncify y;:reverse dropRightWhile[reverse[x];{y[reverse[x]]}[;y]]}

fill:{[x;v;L;R]L|:0;R&:count[`.[x]];if[L<R;.[`.;(x;L+til[R-L]);:;v]];:x}

findIndex:{y:fncify y;n:0;while[n<count x;if[y[x[n]];:n];n+:1];:-1}

findLastIndex:{y:fncify y;n:(count x)-1;while[n>=0;if[y[x[n]];:n];n-:1];:-1}

.qdash.first:{[x]:x[0]}

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
