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
