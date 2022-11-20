#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])
(require '[clojure.string])

(let [info (clojure.string/split
            (-> (sh "wpctl" "get-volume" "@DEFAULT_AUDIO_SINK@")
                :out)
            #"\n")
      vol
      (read-string (get (clojure.string/split
                         (-> (sh "wpctl" "get-volume" "@DEFAULT_AUDIO_SINK@")
                             :out)
                         #"\.")
                        1))]
  (if (or (.contains (str (get info 0) "\n") "MUTE") (= vol 0))
    (print "婢")
    (if (< vol 33)
      (printf "%s%%" vol)
      (if (< vol 66) (printf " %s%%" vol) (printf " %s%%" vol)))))
