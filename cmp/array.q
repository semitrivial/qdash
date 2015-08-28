chunk:{y cut x}

compact:{
 [arr]
 arr:arr[where {not null x} each arr];
 :arr[where {x<>0} each arr]}

difference:{x except y}
