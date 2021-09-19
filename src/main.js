import path from "path"

import express from "express"
import Mustache from "mustache"

import { combinePartials, combineData, stagePartial } from "./views.js"
import * as VIEWS from "./views.js"
import * as DATA from "./data.js"


import * as cfg from "./config.js"

const app = express()
app.use("/static", express.static(path.join(cfg.__dirname, "static/")))

// routes -----------------------------------------------

app.get("/", async (req, res) => {
  res.send(Mustache.render(
    VIEWS.home,
    combineData(DATA.homeData),
    combinePartials({ "stage": stagePartial, })))
})
app.get("/products/", async (req, res) => {
  res.send(Mustache.render(
    VIEWS.products,
    combineData(DATA.productsData),
    combinePartials()
  ))
})
app.get("/services/", async (req, res) => {
  res.send(Mustache.render(
    VIEWS.services,
    combineData(DATA.servicesData),
    combinePartials()
  ))
})
app.get("/contact-us/", async (req, res) => {
  res.send(Mustache.render(
    VIEWS.contactus,
    combineData(),
    combinePartials()
  ))
})
app.get("/about-us/", async (req, res) => {
  res.send(Mustache.render(
    VIEWS.aboutus,
    combineData(),
    combinePartials()
  ))
})

// run -------------------------------------------------

app.listen(cfg.port, () => {
  console.log(`Example app listening at ${cfg.address}`)
})
