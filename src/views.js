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
    { name: 'درباره ما', link: `${address}/aboutus/` },
    { name: 'تماس با ما', link: `${address}/contactus/` },
  ],

  footerParts: [
    {
      title: 'محصولات', items: [
        { name: "کیت استخراج DNA از بزاق", link: `${address}/contactus/` },
        { name: "کیت استخراج DNA از خون", link: `${address}/contactus/` },
      ]
    },
    {
      title: 'خدمات', items: [
        { name: "کیت استخراج DNA از بزاق", link: `${address}/contactus/` },
        { name: "کیت استخراج DNA از خون", link: `${address}/contactus/` },
      ]
    },
    {
      title: 'تماس با ما', items: [
        { name: "کیت استخراج DNA از بزاق", link: `${address}/contactus/` },
        { name: "کیت استخراج DNA از خون", link: `${address}/contactus/` },
      ]
    },
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