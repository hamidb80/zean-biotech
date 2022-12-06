  "scripts": {
    "dev": "nodemon --experimental-json-modules src/main.js",
    "style-watch": "less-watch-compiler  ./styles/  static/dist/ app.less",
    "build": "lessc ./styles/app.less  static/dist/app.css",
    "start": "node --experimental-json-modules src/main.js",
    "update": "fandogh image publish --version",
    "deploy": "fandogh service apply -f fservice.yml"
  },

  "devDependencies": {
    "less": "^4.1.1",
    "less-watch-compiler": "^1.16.3",