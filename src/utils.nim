import std/streams
import yaml

proc loadYaml*[T](path: string): T =
  var s = newFileStream(path)
  load(s, result)
  s.close
