/Code Disclaimer:
/Q is a strange language where the official idiom is to write
/code as tersely as possible (including 1-letter variable names,
/miserly use of newlines, etc.)  I wouldn't endorse such coding
/style for languages other than q.

/To monitor debug output (in separate console): tail -F debug.out
hdbg:hopen `:debug.out
echo:{(neg hdbg) .Q.s1 x}
