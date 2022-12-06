import std/[os, streams]
import karax/[vdom], yaml
import types, utils, gui

const dest = "./output/"
let site = loadYaml[Site]("./data/site.yaml")


# -- delete output if exits

# -- copy static folder here

# -- build and copy styles
# exec "less-watch-compiler  ./styles/  static/dist/ app.less"
# exec "lessc ./styles/app.less  static/dist/app.css"

writeFile dest/"index.html", $homeP(site.stages)
writeFile dest/"about-us.html", $aboutUsP()
writeFile dest/"contact-us.html", $contactUsP()
writeFile dest/"products.html", $productsP(site.products)
writeFile dest/"services.html", $servicesP(site.services)
