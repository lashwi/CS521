(define-fun f ((x Int) (y Int) (z Int) (i Int)) Bool
(and (= i 0) (< i 10) (<= i 10) (> i 10) (not (= x y)) (not (= y z)) (not (= z x))) ; absolute value function
)

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)
(declare-const i Int)
;; (assert (= u_Tf (Tf_upper l u)))
;; (assert (<= l u))

;initial condition
;(assert (not (f 1 2 3 0)))

; inductive property
(assert (not ; negation of soundness property
(and (f 1 2 3 0) (=>
(and (< i 10) (f x y z i)) ; if input is within given bounds
(f y z x (+ i 1)) ; then output is within transformer bounds
))))

(check-sat)
(get-model)