#!/usr/bin/env bb

(def date (.format (java.text.SimpleDateFormat. "E, d MMM y, hh:mm a") (new java.util.Date)))
(print date)
