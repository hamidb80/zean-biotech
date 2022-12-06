# Zean Biotech Business Website
a static website, coded in ***Nim***.

## Generate Output
get final result in `./output` directory:
```shell
nim r src/builder.nim
# or
nimble go
```

## Serve
you can use simple ready-to-go http servers the website.

I like the npm package `http-server`:
```
http-server .\output\
```