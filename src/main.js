import express from 'express'
import Mustache from 'mustache'

import { home as homeTemp, originalPartials } from "./views.js"
import * as cfg from "./config.js"

const app = express()
app.use(express.static('./static/'))

// routes -----------------------------------------------

app.get('/', (req, res) => {
  res.send(Mustache.render(homeTemp, {
    name: "Joe",
    age: () => 4
  }, originalPartials))
})


// run -------------------------------------------------

app.listen(cfg.port, () => {
  console.log(`Example app listening at ${cfg.address}`)
})
