---
title: "Example: Date/Time"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Dates, instants and reporting years

Use a date class when an observation records a calendar date, and a date-time class when it records an instant. A reporting year such as `2014` is an integer, not a complete date to be guessed as January 1. The regional cleaning example only needs reporting years; these date-time examples prepare you for the station data in Units 09–10.

## Read a calendar date

```r
as.Date("2014-01-01")
as.Date("31.01.2014", format = "%d.%m.%Y")
```

`%d`, `%m` and `%Y` specify day, month and four-digit year. Use an explicit format for ambiguous source strings and inspect failed conversions with `is.na()`.

## Specify the time zone

```r
ct <- as.POSIXct("01.01.2014 13:30:35",
                 format = "%d.%m.%Y %H:%M:%S", tz = "Europe/Berlin")
ct
format(ct, format = "%Y-%m-%d %H:%M:%S", tz = "UTC", usetz = TRUE)
```

The input is **13:30:35 in Berlin**, which is **12:30:35 UTC** on that January date. Specifying the zone avoids depending on the computer's local settings. `Europe/Berlin` accounts for daylight-saving rules; `CET` and `CEST` describe different seasonal offsets.

`POSIXct` represents instants as seconds relative to the Unix epoch. `POSIXlt` exposes calendar components in a list-like representation:

```r
lt <- as.POSIXlt(ct, tz = "Europe/Berlin")
lt$hour
lt$mon + 1L
```

Here the hour is 13 and the month is 1; POSIXlt months start at zero. Prefer `POSIXct` for a date-time column in a data frame. `strptime()` parses strings into `POSIXlt`; consult its format documentation rather than guessing a format.

## Elapsed time and calendar changes

```r
later <- ct + 30 * 60
difftime(later, ct, units = "mins")
as.Date("2014-01-02") - as.Date("2014-01-01")
```

These calculations give 30 elapsed minutes and one calendar day. Adding 86,400 seconds is not always the same as moving to the same local clock time on the next calendar day across a daylight-saving transition. State which operation your question requires.

## Return to readable text

```r
strftime(ct, format = "%d.%m.%Y %H:%M", tz = "UTC")
```

The displayed text is `01.01.2014 12:30`; the original instant is unchanged. Formatting produces character data, rather than changing the measurement itself. Keep parsed instants for calculations and format a separate display when needed.

See the [R date-time documentation](https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html) for formats and conversion details.
