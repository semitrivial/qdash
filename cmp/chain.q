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
