import fs from 'fs'
import path from "path"

import { setObj } from "./utils/functional.js"

const __dirname = path.resolve()

// ---------------------------------------------------------------

function loadView(...viewPath) {
  return fs.readFileSync(path.join(__dirname, ...viewPath), 'utf8')
}

export const originalPartials = [
  'meta',
  'footer',
  'header',
].reduce((res, vname) => setObj(res, vname, loadView("views", vname + '.html')), {})

export function combinePartials(partialsNameMap) {
  return { ...originalPartials, ...partialsNameMap }
}

export const
  home = loadView('views', 'home.html')