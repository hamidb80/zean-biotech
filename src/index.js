import { Edge } from 'edge.js'
import fs from 'fs'
import path from 'path'

// ---------------------------------

const edge = Edge.create()
edge.mount(new URL('../views', import.meta.url))

// ---------------------------------

function replaceFileExtension(filePath, newExtension) {
  let dirName = path.dirname(filePath)
  let fileNameWithoutExt = path.basename(filePath, path.extname(filePath))

  return path.join(dirName, `${fileNameWithoutExt}${newExtension}`)
}

function getFilesRecursively(directory, extension) {
  let files = []

  fs.readdirSync(directory).forEach(file => {
    let filePath = path.join(directory, file)
    let stats = fs.statSync(filePath)

    if (stats.isDirectory())
      files = files.concat(getFilesRecursively(filePath, extension))

    else if (path.extname(file) === extension)
      files.push(filePath)
  })

  return files
}

function writeFileRecursive(filePath, content) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true })
  fs.writeFileSync(filePath, content)
}

function copyHtmlFilesRecursive(sourceAbs, sourcePath, destPath, com) {
  return getFilesRecursively(sourcePath, '.edge').map(srcFile => {
    console.log(srcFile)

    if (path.extname(srcFile) === '.edge') {
      let relfile = path.relative(sourceAbs, srcFile)
      let savePath = replaceFileExtension(path.join(destPath, relfile), '.html')
      return edge
        .render(relfile, { com })
        .then(content => writeFileRecursive(savePath, content))
    }
  })
}

// ---------------------------------

function build() {
  Promise.all(copyHtmlFilesRecursive('./views/', './views/pages/', './out', {
    "name": "زیست اکسیر آینده نگر",
    "phones": [
      "09134242180",
      "09901880418"
    ],
    "email": "info@zeanbiotech.ir"
  })).then(_ => {
    fs.cp('./static', './out/static', { recursive: true }, () => { })
    fs.cp('./out/pages', './out', { recursive: true }, () => { fs.rmdir('./out/pages', () => { }) })
  })
}

build()
