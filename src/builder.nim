# footerParts:
#    /products/    محصولات
#    /services/    خدمات

import std/[os]
import marggers, karax/[vdom], yaml
import gui

const dest = "./output/"

echo loadas[YamlNode](readFile "./data/services.yaml")

writeFile dest/"index.html", $homePage()
# writeFile dest/"products.html", $productsPage()
# writeFile dest/"services.html", $servicesPage()
# writeFile dest/"about-us.html", $aboutUsPage()
# writeFile dest/"contact-us.html", $contactUsPage()
