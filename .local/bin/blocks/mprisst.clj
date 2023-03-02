#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])
(require '[clojure.string])

(let [exitcode (-> (sh "playerctl" "metadata")
                   :exit)]
  (if (= exitcode 1)
    (print "♬ No playback")
    (let [artist (clojure.string/trim (-> (sh "playerctl" "metadata" "artist")
                                          :out))
          track (clojure.string/trim (-> (sh "playerctl" "metadata" "title")
                                         :out))
          len (count (str artist track))
          max-len 50]
      (if (<= len max-len)
        (if (= artist "")
          (printf "♫ %s" track)
          (if (= track "")
            (printf "♫ %s" artist)
            (printf "♫ %s - %s" artist track)))
        (if (= artist "")
          (if (> (count track) max-len)
            (printf "♫ %s%s" (subs track 0 max-len) "...")
            (printf "♫ %s" track))
          (if (= track "")
            (if (> (count artist) max-len)
              (printf "♫ %s%s" (subs artist 0 max-len) "...")
              (printf "♫ %s" artist))
            (printf "♫ %s%s"
                    (subs (str artist " - " track) 0 max-len)
                    "...")))))))
