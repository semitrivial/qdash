chain_:{`value`tap`thru`fncs!(x;{chain_[x[y];(z,x)]}[;x;y];{y[x]}[x;];y)}
chain:chain_[;()]

tap:{c:chain[y[x[`value]]];c.fncs,:y;:c}

thru:{y[x[`value]]}

.qdash.value:{x[`value]}

plant:{x[`value]:(y{y[x]}/x[`fncs]);:x}
