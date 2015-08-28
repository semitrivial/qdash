chunk:{
 [arr;size]
 if[size<1;'`$"Chunk size"]
 retval:();
 while[0<c:count arr;
  $[c>size;
   [retval,:enlist size#arr; arr:(size-c)#arr];
   [retval,:arr; arr:()]]];
 :retval}
