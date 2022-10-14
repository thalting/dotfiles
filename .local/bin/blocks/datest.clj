#!/usr/bin/env bb

(def date (.format (java.text.SimpleDateFormat. "E, d MMM y, h:m a") (new java.util.Date)))
(println date)
