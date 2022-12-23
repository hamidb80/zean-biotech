import std/[options, strutils]
import yaml/annotations

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
    personal_information*: PV
    education*: seq[Education]
    professional_experiences*: seq[ProfessionalXP]
    research_interests*: seq[string]
    publications*, talks*, posters*: seq[Activity]
    patents*: seq[Patent]
    teaching_experience*: TeachingXP
    skills*: seq[string]
    reference*: Address

  Activity* {.sparse.} = object
    people*: seq[string]
    title*, footnote*: string
    tags* {.defaultVal: @[].}: seq[string]
    location*: Option[LocationArray]

  Address* {.sparse.} = object
    name*: string
    sub* {.defaultVal: @[].}: seq[string]
    location*: Option[LocationArray]
    pobox*: Option[string]
    tel*: Option[string]
    fax*: Option[string]
    email*: Option[string]

  ProfessionalXP* {.sparse.} = object
    title*: string
    thesis*: Option[string]
    span*: TimeSpanArray
    `in`*: Address

  Education* {.sparse.} = object
    degree*: string
    field*: string
    span*: TimeSpanArray
    `in`*: string
    thesis*: Option[string]

  Name* = object
    first*, last*: string

  FamilyStatus* = enum
    single, married

  Contact* = object
    phone*, email*, linkedin*: string

  PV* = object
    image*: string
    name*: Name
    born*: Born
    current_job*: string
    nationality*: string
    family_status*: FamilyStatus
    contact*: Contact

  Born* = object
    date*: DateArray
    location*: LocationArray

  Patent* = object
    center*: string
    id*: int

  SpanPart* = enum
    start, stop

  DateUnit* = enum
    year, month, day

  CivilUnit* = enum
    country, city


  TimeSpanArray* = array[SpanPart, string]
  DateArray* = array[DateUnit, int]
  LocationArray* = array[CivilUnit, string]

  TeachingXP* = object
    university_courses*, workshops*: seq[string]


func toPath*(n: Name): string =
  (n.first & n.last)
  .toLowerAscii
  .replace(" ", "")
