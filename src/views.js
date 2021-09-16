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
  'meta', 'footer', 'header', 'footer-part',
].reduce((res, vname) => setObj(res, vname,
  loadView("views", "components", vname + '.html')
), {})

const defaultData = {
  navs: [
    { name: 'صفحه اصلی', link: `${address}/` },
    { name: 'محصوالات', link: `${address}/products/` },
    { name: 'خدمات', link: `${address}/services/` },
    { name: 'درباره ما', link: `${address}/about-us/` },
    { name: 'تماس با ما', link: `${address}/contact-us/` },
  ],

  footerParts: [
    { title: 'محصولات', link: `${address}/contactus/` },
    { title: 'خدمات', link: `${address}/about-us/`},
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
  home = loadView('views', 'pages', 'home.html')