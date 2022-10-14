#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])

(def vol (read-string (-> (sh "pamixer" "--get-volume") :out)))
(def state (read-string (-> (sh "pamixer" "--get-mute") :out)))

(if (or (= state true) (= vol 0))
  (print "婢")
  (if (or (> vol 0) (< vol 33))
   (printf "%s%%" vol)
   (if (or (> vol 33) (< vol 66))
     (printf " %s%%" vol)
     (printf " %s%%" vol))))
