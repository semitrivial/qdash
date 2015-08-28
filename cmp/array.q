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
 if[100h=type[pred];          /Behavior if pred is a function
  n:count[arr];
  while[and[n>0;pred[arr[til n]]]; n-:1];
  :arr[til n]];
 if[=[type[pred];99h];        /Behavior if pred is a dictionary
  n:count[arr];
  while[all(n>0;99h=type arr[n-1];(count pred)=count inter[pred;arr[n-1]]); n-:1];
  :arr[til n]];
 '`$"Type"}

test:50
