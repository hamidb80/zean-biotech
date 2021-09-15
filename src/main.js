import path from "path"

import express from 'express'
import Mustache from 'mustache'

import { home as homeTemp, combinePartials, combineData, stagePartial } from "./views.js"
import * as cfg from "./config.js"

const app = express()
app.use('/static', express.static(path.join(cfg.__dirname, 'static/')))

// routes -----------------------------------------------

app.get('/', async (req, res) => {
  res.send(Mustache.render(homeTemp, combineData({
    'stages': [
      {
        title: 'تولید کیت های آزمایشگاهی استخراج اسید نوکلئیک',
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
        icons: ['/static/pics/aid-kit.svg'],
      },
      {
        title: 'تعیین ژنوتیپ گوسفندان چند قلوزا',
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
        icons: ['/static/pics/gene.svg'],
      },
      {
        title: 'مواد و تجهیزات آزمایشگاه',
        pic_url: 'https://picsum.photos/300/200',
        pic_alt: 'dsad',
        link: 'ds',
        icons: [
          '/static/pics/dropper.svg',
          '/static/pics/lab-flask.svg'
        ],
      },
    ]
  }), combinePartials({ 'stage': stagePartial, })))
})
app.get('/products/', async (req, res) => {
  res.send(Mustache.render(
    homeTemp,
    combineData(),
    combinePartials()
  ))
})
app.get('/services/', async (req, res) => {
  res.send(Mustache.render(
    homeTemp,
    combineData(),
    combinePartials()
  ))
})
app.get('/contact-us/', async (req, res) => {
  res.send(Mustache.render(
    homeTemp,
    combineData(),
    combinePartials()
  ))
})
app.get('/about-us/', async (req, res) => {
  res.send(Mustache.render(
    homeTemp,
    combineData(),
    combinePartials()
  ))
})

// run -------------------------------------------------

app.listen(cfg.port, () => {
  console.log(`Example app listening at ${cfg.address}`)
})
