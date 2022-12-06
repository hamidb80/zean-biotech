# footerParts:
#    /products/    محصولات
#    /services/    خدمات

import std/[os]
import marggers, karax/[vdom]
import gui

const dest = "./output/"


writeFile dest/"index.html", $homePage()
# writeFile dest/"products.html", $productsPage()
# writeFile dest/"services.html", $servicesPage()
# writeFile dest/"about-us.html", $aboutUsPage()
# writeFile dest/"contact-us.html", $contactUsPage()
