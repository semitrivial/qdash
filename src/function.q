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

