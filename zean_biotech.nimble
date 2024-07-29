# --- Package
version       = "0.1.0"
author        = "hamidb80"
description   = "a static website"
license       = "MIT"
srcDir        = "src"
bin           = @["builder"]


# --- Dependencies
requires "nim >= 1.6.6"
requires "yaml >= 1.0.0"
requires "marggers >= 0.3.3"
requires "karax >= 1.2.2"
# "less": "^4.1.1" 
# margrave

task fast, "for dev":
  exec "nim r src/builder.nim"

task go, "natural":
  exec "nimble build"
  exec "./builder.exe"
  