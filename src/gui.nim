import std/[strformat, sequtils, strutils, options]
import karax/[karaxdsl, vdom], marggers, marggers/element
import types

# --- basics

func markdown2html*(s: string): seq[VNode]

func spaceB(): VNode =
  buildhtml tdiv(class = "space-y")

func titleB(content: VNode): VNode =
  buildhtml h3:
    content


func itemB(contents: seq[VNode]): VNode =
  result = buildhtml li:
    span(class = "icon check-icon")
    for c in contents:
      c

func listB(items: seq[VNode]): VNode =
  buildhtml ul:
    for i in items:
      i

func paragraphB(items: seq[VNode]): VNode =
  buildHtml p:
    for i in items:
      i

func boldB(items: seq[VNode]): VNode =
  buildHtml bold:
    for i in items:
      i

func m2h(elem: MarggersElement): VNode =
  if elem.isText:
    if elem.str.startsWith "------":
      spaceB()
    else:
      buildHtml span:
        text elem.str
  else:
    let subs = elem.content.map(m2h)
    case elem.tag
    of ul: listB subs
    of li: itemB subs
    of h3: titleB subs[0]
    of p: paragraphB subs
    of strong: boldB subs
    else: raise newException(ValueError, "not implmeneted: " & $elem.tag)

func markdown2html*(s: string): seq[VNode] =
  {.cast(noSideEffect).}:
    parseMarggers(s).map(m2h)

# --- components

type Link = tuple
  link, name: string

const
  navs: seq[Link] = @[
    ("/", "صفحه اصلی"),
    ("/products.html", "محصولات"),
    ("/services.html", "خدمات"),
    ("/about-us.html", "درباره ما"),
    ("/contact-us.html", "تماس با ما"),
  ]
  footerParts: seq[Link] = @[
    ("/products.html", "محصولات"),
    ("/services.html", "خدمات")
  ]


func footerC(): Vnode =
  buildHtml tdiv:
    footer(class = "main-footer"):
      tdiv(class = "part links"):
        tdiv(class = "body"):
          for p in footerParts:
            a(href = p.link):
              tdiv(class = "icon")
              span(class = "text"):
                text p.name

      tdiv(class = "part contact"):
        tdiv(class = "title"):
          text "تماس با ما"

        tdiv(class = "body"):
          p:
            text """
          09901880418
          شماره همراه و واتساپ شرکت
          """

          p:
            text "ایمیل: "
            a(href = "mailto:info@zeanbiotech.ir"):
              text "info@zeanbiotech.ir"

      tdiv(class = "part address"):
        tdiv(class = "title"):
          text "آدرس"

        tdiv(class = "body"):
          text """
          اصفهان، کیلومتر 5 جاده اصفهان شیراز، سپاهان شهر، بلوار غدیر، بلوار قائم جنوبی، دانشگاه شهید اشرفی اصفهانی، مرکز
          رشد،
          شرکت زیست اکسیر آینده نگر
          """

    tdiv(class = "after-footer"):
      text """
      تمامی حقوق برای شرکت zean محفوظ میباشد
      ©
      """

func headerC(): VNode =
  buildHtml tdiv:
    header(class = "main-header"):
      img(src = "/static/pics/logo.png", alt = "site logo")
      h1:
        text "زیست اکسیر آینده نگر"

    nav(class = "main-nav"):
      for n in navs:
        a(href = n.link):
          text n.name

func headC(pageTitle: string): VNode =
  buildHtml head():
    meta(charset = "UTF-8")
    meta(http-equiv = "X-UA-Compatible", content = "IE=edge")
    meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
    meta(
      name = "description",
      content = "زیست اکسیر آینده نگر, زیست اکسیر, محصولات آزمایشگاهی, کیت های تشخیص DNA")

    link(rel = "stylesheet", href = "/static/dist/app.css")
    title:
      text fmt"{pageTitle} - زیست اکسیر آینده نگر"


func articleC(artcl: Article): VNode =
  buildHtml tdiv(class = "mt-3"):
    tdiv(class = "box", id = $artcl.id):
      tdiv(class = "header"):
        h2(class = "title"):
          text artcl.title

        tdiv(class = "image"):
          img(src = artcl.img_url, alt = artcl.img_alt)

      tdiv(class = "body"):
        for e in markdown2html artcl.body:
          e

func stageC(s: Stage): Vnode =
  buildHtml tdiv(class = "stage"):
    tdiv(class = "top triangle")
    tdiv(class = "inside"):
      tdiv(class = "part image"):
        img(src = s.img_url, alt = s.img_alt)

      tdiv(class = "part content"):
        h2(class = "title"):
          text s.title

        tdiv(class = "icons"):
          for ic in s.icons:
            tdiv(class = fmt"icon {ic}")

        if s.link != "":
          a(class = "btn see-more", href = s.link):
            text "بیشتر بدانید ..."

    tdiv(class = "bottom triangle")

# --- pages

func homeP*(stages: seq[Stage]): VNode =
  buildHtml html:
    headC "صفحه اصلی"
    body:
      headerC()

      tdiv(class = "stages"):
        for s in stages:
          stageC s

      footerC()

func aboutUsP*(): VNode =
  buildHtml html:
    headC "درباره ما"
    body:
      headerC()

      tdiv(class = "box automated"):
        p:
          text """
          درسال 1399، شرکت زیست اکسیر آینده نگر توسط چند عضو هیئت علمی دانشگاه با هدف تامین نیازهای مراکز تحقیقاتی و تشخیصی
          فعال در زمینه بیولوژی مولکولی و بیوتکنولوژی شروع به فعالیت کرد.
          """

        p:
          text """
          در ابتدا این شرکت فعالیت خود را به صورت کار خدماتی در زمینه اصلاح نژاد دام (تعیین گوسفندان هتروزیگوت و هموزیگوت از
          نظر ژن چند قلوزائی) شروع کرد و پس از شروع به تولید کیت های استخراج اسیدهای نوکلئیک نمود.
          """

        p:
          text """
          مشخصه اصلی کیت های این شرکت سرعت و کیفیت بالا و در عین حال قیمت پائین آن می باشد.
          """

        p:
          text """
          هم اکنون این شرکت در دو بخش خدمات و تولیدات افتخار این را دارد که در خدمت پژوهشگران و مشتریان عزیز باشد.
          """

      footerC()

func contactUsP*(): VNode =
  buildHtml html:
    headC "ارتباط با ما"
    body:
      headerC()

      tdiv(class = "box automated"):
        p(class = "address"):
          text """
          اصفهان، کیلومتر 5 جاده اصفهان شیراز، سپاهان شهر، بلوار غدیر، بلوار قائم جنوبی، دانشگاه شهید اشرفی اصفهانی، مرکز
          رشد،
          شرکت زیست اکسیر آینده نگر
          """

        tdiv(class = "space-y")

        p(class = "number"):
          text """
          ایمیل:
          """

          a(href = "mailto:info@zeanbiotech.ir"):
            text "info@zeanbiotech.ir"

        tdiv(class = "space-y")

        p(class = "number"):
          text """
          031-36502820 داخلی 297
          شنبه تا چهارشنبه ساعت 10 تا 17
          پنج شنبه ها ساعت 10 تا 13
          """

        p(class = "number"):
          text """
          09901880418
          شماره همراه و واتساپ شرکت
          """

      footerC()

func productsP*(products: seq[Article]): VNode =
  buildHtml html:
    headC "محصولات"
    body:
      headerC()

      tdiv(class = "products article-wrapper"):
        for p in products:
          articleC p

      footerC()

func servicesP*(services: seq[Article]): VNode =
  buildHtml html:
    headC "خدمات"

    body:
      headerC()

      tdiv(class = "services article-wrapper"):
        for s in services:
          articleC s

      footerC()

func edtime(sp: TimeSpanArray): VNode =
  buildHtml tdiv():
    hr()
    tdiv(class = "time-span"):
      tdiv(class = "line"):
        span(class = "start"):
          text sp[start]

        span(class = "space"):
          text " - "

        span(class = "stop"):
          text sp[stop]

func my1: VNode =
  buildHtml tdiv(class = "my1")

func educationC*(ed: Education): VNode =
  buildHtml tdiv(class = "education"):
    edtime ed.span
    p:
      bold:
        text ed.degree
        text " "
        text ed.field

      text " - "
      italic:
        text ed.`in`

    if issome ed.thesis:
      my1()
      p:
        bold:
          text "Thesis: "
        text ed.thesis.get

func profexC*(px: ProfessionalXP): VNode =
  buildHtml tdiv(class = "education"):
    edtime px.span
    p:
      bold:
        text px.title

      text " - "
      italic:
        text $px.`in`

    if issome px.thesis:
      my1()
      p:
        bold:
          text "Thesis: "
        text px.thesis.get

func patentC(p: Patent): VNode =
  buildHtml li:
    text p.center
    text " - patent No: "
    bold:
      text $p.id

proc iconC(name: string): VNode =
  buildHtml span(class="icon " & name)

proc downloadBtn: VNode =
  buildHtml a(class = "icon-wrapper download"):
    iconC "download"

proc activityC(ac: Activity, you: seq[string]): VNode =
  let c = 
    buildHtml span:  
      bold: text ac.title

  buildHtml tdiv(class = "pub"):
    p(class = "title"):
      if issome ac.download:
        downloadBtn()

      if isSome ac.download:
        a(href = "/static/files/" & ac.download.get): c
      else:
        c

      text " - "
      italic: text ac.footnote

    p:
      for p in ac.people:
        let c =
          if p in you: " me"
          else: ""

        tdiv(class = "author " & c):
          p:
            text p

proc cvPage*(cv: CV): VNode =
  let
    pfp = cv.personal_information

    name =
      pfp.name.first & " " &
      pfp.name.last

    you = @[
      capitalizeAscii name,
      capitalizeAscii pfp.name.last & " " & pfp.name.first[0]
    ]

    pageTitle = name & " CV"

  buildHtml html:
    head:
      meta(charset = "UTF-8")
      meta(http-equiv = "X-UA-Compatible", content = "IE=edge")
      meta(name = "viewport", content = "width=device-width, initial-scale=1.0")
      meta(name = "description", content = pageTitle)
      link(rel = "preconnect", href = "https://fonts.googleapis.com")
      link(rel = "preconnect", href = "https://fonts.gstatic.com",
          crossorigin = "true")
      link(href = "https://fonts.googleapis.com/css2?family=Karla:wght@200;300&display=swap",
          rel = "stylesheet")
      link(rel = "stylesheet", href = "/static/dist/cv.css")
      title:
        text pageTitle

    body:
      tdiv(class = "cv-wrapper"):
        aside:
          tdiv(class = "profile"):
            tdiv(class = "pfp"):
              img(src = pfp.image)

            tdiv(class = "info"):
              h1(class = "name"):
                text name

              tdiv(class = "job"):
                text pfp.current_job

          tdiv(class = "body"):
            ul:
              li:
                bold: text "Birthday: "
                text pfp.born

              li:
                bold: text "Nationality: "
                text pfp.nationality

              li:
                bold: text "family status: "
                text $pfp.family_status

              li:
                bold: text "phone: "
                text pfp.contact.phone

              li:
                bold: text "email: "
                text pfp.contact.email

              li:
                bold: text "linkedIn: "
                text pfp.contact.linkedIn

        main:
          h2: text "Education"
          tdiv(class = "content"):
            for ed in cv.education:
              educationC ed

          h2: text "Professional Experiences"
          tdiv(class = "content"):
            for ex in cv.professional_experiences:
              profexC ex

          h2: text "Research Interests"
          tdiv(class = "content"):
            ul:
              for ri in cv.research_interests:
                li:
                  text ri

          h2: text "Publications"
          tdiv(class = "content"):
            for p in cv.publications:
              activityC(p, you)

          h2: text "Talks"
          tdiv(class = "content"):
            for t in cv.talks:
              activityC(t, you)

          h2: text "Posters"
          tdiv(class = "content"):
            for p in cv.posters:
              activityC(p, you)

          h2: text "Patents"
          tdiv(class = "content"):
            ul:
              for p in cv.patents:
                patentC p

          h2: text "Teaching Experience"
          tdiv(class = "content"):
            h3: text "University Courses"
            ul:
              for uc in cv.teaching_experience.university_courses:
                li: text uc

            h3: text "Workshops"
            ul:
              for wk in cv.teaching_experience.workshops:
                li: text wk

          h2: text "Skills"
          tdiv(class = "content"):
            ul:
              for sk in cv.skills:
                li:
                  text sk

          h2: text "Reference"
          tdiv(class = "content"):
            p:
              text cv.reference
