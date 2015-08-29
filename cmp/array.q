chunk:{y cut x}

compact:{
 [arr]
 arr:arr[where {not null x} each arr];
 :arr[where {x<>0} each arr]}

difference:{x except y}

drop:{sublist[(y;count x);x]}

dropRight:{sublist[(0;(count x)-y);x]}

dropRightWhile:{
 [arr;pred]
 if[99h<type[pred];          /Behavior if pred is a function
  n:count[arr];
  while[and[n>0;pred[arr[til n]]]; n-:1];
  :arr[til n]];
 if[99h=type[pred];        /Behavior if pred is a dictionary
  n:count[arr];
  while[all(n>0;99h=type arr[n-1];arr[n-1;key pred]~value pred); n-:1];
  :arr[til n]];
 '`$"Type"}

dropWhile:{reverse dropRightWhile[reverse[x];{y[reverse[x]]}[;y]]}

/
fill:{[x;v;L;R]L|:0;R&:count[`.[x]];if[L<R;(`.[x])[L+til[R-L]]:v];:x}
\
