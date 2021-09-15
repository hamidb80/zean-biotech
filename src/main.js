import path from "path"

import express from 'express'
import Mustache from 'mustache'

import { home as homeTemp, combinePartials, combineData, stagePartial } from "./views.js"
import * as cfg from "./config.js"

const app = express()
app.use(express.static(path.join(cfg.__dirname, 'static/')))

// routes -----------------------------------------------

app.get('/', async (req, res) => {
  res.send(Mustache.render(homeTemp, combineData({
    'stages': [
      {
        title: 'جن گیری',
        icons: [],
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
      },
      {
        title: 'سلام خوبی؟',
        icons: [],
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
      },
      {
        title: 'آمپول میزنیم',
        icons: [],
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
      },
    ]
  }), combinePartials({ 'stage': stagePartial, })))
})


// run -------------------------------------------------

app.listen(cfg.port, () => {
  console.log(`Example app listening at ${cfg.address}`)
})
