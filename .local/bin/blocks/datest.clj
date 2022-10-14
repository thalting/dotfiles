#!/usr/bin/env bb

(let [date (.format (java.text.SimpleDateFormat. "E, d MMM y, hh:mm a")
                    (new java.util.Date))]
  (print date))
