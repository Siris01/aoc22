(require '[clojure.string :as str])

(defmacro for-loop [[sym init check change :as params] & steps]
  `(loop [~sym ~init value# nil]
     (if ~check
       (let [new-value# (do ~@steps)]
         (recur ~change new-value#))
       value#)))

(def s1 [])
(def s2 [])
(def s3 [])
(def s4 [])
(def s5 [])
(def s6 [])
(def s7 [])
(def s8 [])
(def s9 [])

(def i 0)
(def j 0)

(defn push [item k]
  (case (+ k 1)
    1 (def s1 (conj s1 item))
    2 (def s2 (conj s2 item))
    3 (def s3 (conj s3 item))
    4 (def s4 (conj s4 item))
    5 (def s5 (conj s5 item))
    6 (def s6 (conj s6 item))
    7 (def s7 (conj s7 item))
    8 (def s8 (conj s8 item))
    9 (def s9 (conj s9 item))))

(defn pop-list [k]
  (case k
    1 (def s1 (pop s1))
    2 (def s2 (pop s2))
    3 (def s3 (pop s3))
    4 (def s4 (pop s4))
    5 (def s5 (pop s5))
    6 (def s6 (pop s6))
    7 (def s7 (pop s7))
    8 (def s8 (pop s8))
    9 (def s9 (pop s9))))

(defn last-n-from-src [src n]
  (case src
    1 (take-last n s1)
    2 (take-last n s2)
    3 (take-last n s3)
    4 (take-last n s4)
    5 (take-last n s5)
    6 (take-last n s6)
    7 (take-last n s7)
    8 (take-last n s8)
    9 (take-last n s9)))

(defn parse-stack []
  (reverse (drop-last (str/split (nth (str/split (slurp "input.txt") #"\n\n") 0) #"\n"))))

(defn parse-actions []
  (str/split (nth (str/split (slurp "input.txt") #"\n\n") 1) #"\n"))

(defn fill-row [row]
  (for-loop [i 0 (< i 9) (inc i)]
            (def element (subs row (* i 4) (+ (* i 4) 3)))
            (if (str/starts-with? element "[") (push (subs element 1 2) i) ())))

(defn fill-stack [items]
  (for-loop [i 0 (< i (count items)) (inc i)]
            (fill-row (nth items i))))

(defn parse-int
  "Reads a number from a string. Returns nil if not a number."
  [s]
  (if (re-find #"^-?\d+\.?\d*$" s)
    (read-string s)))

(fill-stack (parse-stack))

(let [actions (parse-actions)]
  (for-loop [i 0 (< i (count actions)) (inc i)]
            (let [action (str/split (nth actions i) #" ") src (parse-int (nth action 3)) dest (parse-int (nth action 5)) n (parse-int (nth action 1)) buff (last-n-from-src src n)]
              (for-loop [j 0 (< j n) (inc j)] (push (nth buff j) (- dest 1)) (pop-list src)))))

(println (clojure.string/join [(peek s1) (peek s2) (peek s3) (peek s4) (peek s5) (peek s6) (peek s7) (peek s8) (peek s9)]))