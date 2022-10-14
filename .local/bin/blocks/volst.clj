#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])

(let [vol (read-string (-> (sh "pamixer" "--get-volume")
                           :out))
      state (read-string (-> (sh "pamixer" "--get-mute")
                             :out))]
  (if (or (= state true) (= vol 0))
    (print "婢")
    (if (< vol 33)
      (printf "%s%%" vol)
      (if (< vol 66) (printf " %s%%" vol) (printf " %s%%" vol)))))
