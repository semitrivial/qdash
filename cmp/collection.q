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
