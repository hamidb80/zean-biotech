import fs from 'fs'
import path from "path"

import { setObj } from "./utils/functional.js"
import { address } from "./config.js"

const __dirname = path.resolve()

// locals ---------------------------------------------------------------

function loadView(...viewPath) {
  return fs.readFileSync(path.join(__dirname, ...viewPath), 'utf8')
}

const defaultPartials = [
  'meta', 'footer', 'header', 'article',
].reduce((res, vname) => setObj(res, vname,
  loadView("views", "components", vname + '.html')
), {})

const defaultData = {
  navs: [
    { name: 'صفحه اصلی', link: `${address}/` },
    { name: 'محصولات', link: `${address}/products/` },
    { name: 'خدمات', link: `${address}/services/` },
    { name: 'درباره ما', link: `${address}/about-us/` },
    { name: 'تماس با ما', link: `${address}/contact-us/` },
  ],

  footerParts: [
    { title: 'محصولات', link: `${address}/products/` },
    { title: 'خدمات', link: `${address}/services/`},
  ]
}

// ----------------------------------------

export const stagePartial =
  loadView("views", "components", 'stage.html')

export function combinePartials(partialsNameMap = {}) {
  return { ...defaultPartials, ...partialsNameMap }
}
export function combineData(data = {}) {
  return { ...defaultData, ...data }
}

export const
  home = loadView('views', 'pages', 'home.html'),
  aboutus = loadView('views', 'pages', 'about-us.html'),
  contactus = loadView('views', 'pages', 'contact-us.html'),

  products = loadView('views', 'pages', 'products.html'),
  services = loadView('views', 'pages', 'services.html')