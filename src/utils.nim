import std/streams
import yaml

proc loadYaml*[T](path: string): T =
  var s = newFileStream("./data/site.yaml")
  load(s, result)
  s.close
