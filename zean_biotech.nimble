# --- Package
version       = "0.1.0"
author        = "hamidb80"
description   = "a static website"
license       = "MIT"
srcDir        = "src"
# bin           = @["zean_biotech"]

# --- Dependencies
requires "nim >= 1.6.6"
requires "yaml >= 1.0.0"
# "less": "^4.1.1",
# "less-watch-compiler": "^1.16.3",


# --- Tasks
task sw, "style-watch":
  exec "less-watch-compiler  ./styles/  static/dist/ app.less"

task css, "compile style sheets":
  exec "lessc ./styles/app.less  static/dist/app.css"
