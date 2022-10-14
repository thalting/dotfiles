#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])

(def exitcode (-> (sh "playerctl" "metadata") :exit))

(if (= exitcode 1)
  (print "♬ No playback")
  (do
    (def artist (clojure.string/trim (-> (sh "playerctl"  "metadata" "artist") :out)))
    (def track (clojure.string/trim (-> (sh "playerctl"  "metadata" "title") :out)))
    (if (= artist "")
     (printf "♫ %s" track)
     (if (= track "")
       (printf "♫ %s" artist)
       (printf "♫ %s - %s" artist track)))))
