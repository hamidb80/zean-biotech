import homeData from './data/home.json'
import productsData from './data/products.json'
import servicesData from './data/services.json'

import fs from 'fs'
import Mustache from "mustache"
import path from "path"


const __dirname = path.resolve()

const templateTypeMap = {
  "paragraph": "paragraph.html",
  "list": "list.html",
  "title": "title.html",
  "bold": "bold.html",
  "space": "space.html",
}

function parseData(item) {
  let templString = fs.readFileSync(
    path.join(__dirname, "src", "template", templateTypeMap[item.type]), 'utf8')

  return Mustache.render(templString, { "content": item.content })
}

function renderBodies(items) {
  for (let it of items)
    it["body"] = it["body"].map(part => parseData(part)).join("\n")
}

renderBodies(productsData.products)
renderBodies(servicesData.services)

export { homeData, productsData, servicesData }