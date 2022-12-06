import std/[os, streams]
import karax/[vdom], yaml
import types, utils, gui

const dest = "./output/"
let site = loadYaml[Site]("./data/site.yaml")

writeFile dest/"index.html", $homePage(site.stages)
writeFile dest/"about-us.html", $aboutUsPage()
writeFile dest/"contact-us.html", $contactUsPage()
# writeFile dest/"products.html", $productsPage()
# writeFile dest/"services.html", $servicesPage()
