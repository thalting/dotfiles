#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])
(require '[clojure.string])

(let [info (-> (sh "wpctl" "get-volume" "@DEFAULT_AUDIO_SINK@")
               :out)
      vol (->> (sh "wpctl" "get-volume" "@DEFAULT_AUDIO_SINK@")
               (:out)
               (re-find #"[0-9.]+")
               (Float/parseFloat)
               (* 100)
               (Math/round))]
  (if (or (.contains info "MUTE") (= vol 0))
    (print "婢")
    (if (< vol 33)
      (printf "%s%%" vol)
      (if (< vol 66) (printf " %s%%" vol) (printf " %s%%" vol)))))
