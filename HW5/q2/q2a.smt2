

(define-fun f ((x Real)) Real
(ite (> x 0) x (- x)) ; absolute value function
)


(define-fun Tf_lower ((x Real) (y Real)) Real (let ((_let_1 (f y))) (let ((_let_2 (f x))) (let ((_let_3 (* x y))) (ite (> 0 _let_3) 0.0 (ite (< _let_2 _let_1) _let_2 _let_1))))))
(define-fun Tf_upper ((x Real) (y Real)) Real (let ((_let_1 (f x))) (ite (< _let_1 (f y)) y _let_1)))

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
