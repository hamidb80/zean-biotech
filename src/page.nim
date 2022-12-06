import karax/[karaxdsl, vdom]


func space(content: string): VNode = 
  buildhtml tdiv(class="space-y")

func title(content: string): VNode = 
  buildhtml h4:
   text content

func list: VNode = 
  buildhtml ul:
    for c in content:
      li:
        i(class="icon check-icon")
        text c

func article*(
  id, text, title, img_url, img_alt: string,
  body: VNode): VNode =

  buildHtml tdiv(class = "mt-3"):
    tdiv(class = "box", id = id):
      tdiv(class = "header"):
        h2(class = "title"):
          text title

        tdiv(class = "image"):
          img(src = img_url, alt = img_alt)

      tdiv(class = "body"):
        discard
        # elem body

func footer: Vnode =
  let title = "he"

  buildHtml footer(class = "main-footer"):
    tdiv(class = "part links"):
      tdiv(class = "body"):
        for p in footerParts:
          a(href = "link"):
            tdiv(class = "icon")
            span(class = "text"):
              text title

    tdiv(class = "part contact"):
      tdiv(class = "title"):
        text "تماس با ما"

      tdiv(class = "body"):
        text """
          031-36502820
          داخلی
          297
          شنبه تا چهارشنبه ساعت 10 تا 17
          پنج شنبه ها ساعت 10 تا 13
        """
        text """
        09901880418
        شماره همراه و واتساپ شرکت
        """

        text "ایمیل:"
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

func header: VNode =
  buildHtml header(class = "main-header"):
    img(src = "/static/pics/logo.png", alt = "")
    h1:
      text "زیست اکسیر آینده نگر"

  nav(class = "main-nav"):
    for n in navs:
      a(href = "{{link}}"):
        text name

func head: VNode = 
  buildHtml head():
    meta(charset="UTF-8")
    meta(http-equiv="X-UA-Compatible", content="IE=edge")
    meta(name="viewport", content="width=device-width, initial-scale=1.0")
    meta(
      name="description",
      content="زیست اکسیر آینده نگر, زیست اکسیر, محصولات آزمایشگاهی, کیت های تشخیص DNA")

    link(rel="stylesheet", href="/static/dist/app.css")
    title:
      text "{{ pageTitle }} - زیست اکسیر آینده نگر"
  
func stage: Vnode = 
  buildHtml tdiv(class="stage"):
    tdiv(class="top triangle")
    tdiv(class="inside"):
      tdiv(class="part image"):
        img(src=pic_url, alt=pic_alt)
      
      tdiv(class="part content"):
        h2(class="title"):
          text title

        tdiv(class="icons"):
          for ic in icons:
            tdiv class="icon {{.}}">

        for l in link:
          a(class="btn see-more", href="{{link}}"):
            text "بیشتر بدانید ..."
      
    tdiv(class="bottom triangle")


func aboutus: VNode = 
  buildHtml body:
    header()

    tdiv(class="box automated"):
      text """
        درسال 1399، شرکت زیست اکسیر آینده نگر توسط چند عضو هیئت علمی دانشگاه با هدف تامین نیازهای مراکز تحقیقاتی و تشخیصی
        فعال در زمینه بیولوژی مولکولی و بیوتکنولوژی شروع به فعالیت کرد.
      """
      
      text """
        در ابتدا این شرکت فعالیت خود را به صورت کار خدماتی در زمینه اصلاح نژاد دام (تعیین گوسفندان هتروزیگوت و هموزیگوت از
        نظر ژن چند قلوزائی) شروع کرد و پس از شروع به تولید کیت های استخراج اسیدهای نوکلئیک نمود.
      """

      text """
        مشخصه اصلی کیت های این شرکت سرعت و کیفیت بالا و در عین حال قیمت پائین آن می باشد.
      """
      
      text """
        هم اکنون این شرکت در دو بخش خدمات و تولیدات افتخار این را دارد که در خدمت پژوهشگران و مشتریان عزیز باشد.
      """

    footer()

func contactUs: VNode = 
  buildHtml html:
    head()
    body():
      header()

      tdiv(class="box automated"):
        p(class="address"):
          text """
          اصفهان، کیلومتر 5 جاده اصفهان شیراز، سپاهان شهر، بلوار غدیر، بلوار قائم جنوبی، دانشگاه شهید اشرفی اصفهانی، مرکز
          رشد،
          شرکت زیست اکسیر آینده نگر
          """

        tdiv(class="space-y")
        
        p(class="number"):
          text """
          ایمیل:
          """

          a(href="mailto:info@zeanbiotech.ir"):
            text "info@zeanbiotech.ir"
        
        tdiv(class="space-y")

        p(class="number"):
          text """
          031-36502820 داخلی 297
          شنبه تا چهارشنبه ساعت 10 تا 17
          پنج شنبه ها ساعت 10 تا 13
          """

        p( class="number"):
          text """
          09901880418
          شماره همراه و واتساپ شرکت
          """

      footer()

func home: VNode = 
  buildHtml html:
    head()
    body():
      header()

      tdiv(class="stages"):
        for s in stages:
          stage()

      footer()

func products: VNode = 
  buildHtml html:
    head()
    body():
      header()

      tdiv(class="products article-wrapper"):
        for p in products:
          article(p)

      footer()

func services: VNode = 
  buildHtml html:
    head()

    body():
      header()

      tdiv( class="services article-wrapper"):
        for s in services:
          article()

      footer()

