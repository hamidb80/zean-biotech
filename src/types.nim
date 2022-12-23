import std/options

type
  Stage* = object
    title*, img_url*, img_alt*, link*: string
    icons*: seq[string]

  Article* = object
    id*: int
    title*, img_url*, img_alt*, body*: string

  Site* = object
    stages*: seq[Stage]
    products*, services*: seq[Article]

type
  CV* = object
    personal_information: PV
    education: seq[Education]
    professional_experiences: seq[ProfessionalXP]
    research_interests: seq[string]
    publications: seq[string]
    talks: seq[Talk] 
    posters: seq[Poster] 
    patents: seq[Patent] 
    teaching_experience: TeachingXP
    skills: seq[string]
    reference: Address

  Address = object
    name: string
    sub: Option[seq[string]]
    location: Option[LocationArray]
    pobox: Option[int]
    tel, fax: Option[string]
    email: Option[string]


  ProfessionalXP = object
    title: string
    span: TimeSpanArray
    `in`: Address

  Span = enum
    start, stop

  TimeSpanArray = array[Span, string]

  Education = object
    degree: string
    field: string
    span: TimeSpanArray
    `in`: string
    thesis: Option[string]

  Name = object
    first, last: string

  FamilyStatus = enum
    single, married

  Contact = object
    phone, email, linkedin: string

  PV = object
    name: Name
    born: Born 
    nationality: string
    family_status: FamilyStatus
    contact: Contact

  Patent = object
    center: string
    id: int

  DateUnit = enum
    year, month, day

  CivilUnit = enum
    country, city

  DateArray = array[DateUnit, int]
  LocationArray = array[CivilUnit, string]

  TeachingXP = object
    university_courses, workshops: seq[string]

  Born* = object
    `when`: DateArray
    where: LocationArray