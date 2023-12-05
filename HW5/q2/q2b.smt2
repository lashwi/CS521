
(define-fun f ((x Real)) Real
(* x (* x x)))


(define-fun Tf_lower ((x Real) (y Real)) Real (* (* x x) x))
(define-fun Tf_upper ((x Real) (y Real)) Real (* (* y y) y))

(declare-const l Real)
(declare-const u Real)

; lower bound of range interval
(declare-const l_Tf Real)
(assert (= l_Tf (Tf_lower l u)))
; upper bound of range interval
(declare-const u_Tf Real)
(assert (= u_Tf (Tf_upper l u)))
(assert (<= l u))


(assert (not
(exists ((x Real))
(and (<= l x) (<= x u) (= (f x) l_Tf))
)))

(assert (not
(exists ((x Real))
(and (<= l x) (<= x u) (= (f x) u_Tf))
)))

(check-sat)
