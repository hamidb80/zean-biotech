import std/[os, streams]
import karax/[vdom], yaml
import types, utils, gui

const dest = "./output/"
let site = loadYaml[Site]("./data/site.yaml")

when isMainModule:
  if dirExists dest:
    removeDir dest
  
  copyDir "./static", dest/"static"

  # -- build and copy styles
  discard execShellCmd "lessc ./styles/app.less " & dest/"static/dist/app.css"

  writeFile dest/"index.html", $homeP(site.stages)
  writeFile dest/"about-us.html", $aboutUsP()
  writeFile dest/"contact-us.html", $contactUsP()
  writeFile dest/"products.html", $productsP(site.products)
  writeFile dest/"services.html", $servicesP(site.services)
