# footerParts:
#    /products/    محصولات
#    /services/    خدمات

import std/[os, streams]
import marggers, karax/[vdom], yaml
import types #, gui

const dest = "./output/"

proc loadData[T](path: string): T =
  var s = newFileStream("./data/site.yaml")
  load(s, result)
  s.close


let site = loadData[Site]("./data/site.yaml")
echo site

# writeFile dest/"index.html", $homePage()
# writeFile dest/"products.html", $productsPage()
# writeFile dest/"services.html", $servicesPage()
# writeFile dest/"about-us.html", $aboutUsPage()
# writeFile dest/"contact-us.html", $contactUsPage()
