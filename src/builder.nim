import std/[os, streams]
import karax/[vdom], yaml
import types, utils, gui


proc loadSiteData(path: string): Site = 
  result = loadYaml[Site](path)

  template loadContents(field): untyped =
    for a in mitems result.field:
      a.body = readfile "./data/articles"/a.body

  loadContents products
  loadContents services

when isMainModule:
  const dest = "./output/"
  let site = loadSiteData "./data/site.yaml"

  if dirExists dest:
    removeDir dest
  
  copyDir "./static", dest/"static"

  discard execShellCmd "lessc ./styles/app.less " & dest/"static/dist/app.css"

  writeFile dest/"index.html", $homeP(site.stages)
  writeFile dest/"about-us.html", $aboutUsP()
  writeFile dest/"contact-us.html", $contactUsP()
  writeFile dest/"products.html", $productsP(site.products)
  writeFile dest/"services.html", $servicesP(site.services)

  let 
    cv = loadYaml[CV]("./data/cv.yaml")
    # p = dest/cv.personal_information.name.toPath

  # createDir p
  # writeFile p/"index.html", $cvPage(cv)