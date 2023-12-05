; Lines that start with a semicolon are comments


; Define the function for which you are constructing a transformer


(define-fun h ((x Real)) Real
(ite (> x 0) x (- x))
)

(define-fun f ((x Real)) Real
(- x (ite (> x 0) x (- x)))
)

(define-fun Tf_lower ((x Real) (y Real)) Real (- x (h x)))
(define-fun Tf_upper ((x Real) (y Real)) Real (- y (h y)))

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




; This command asks the solver to check the satisfiability of your query
; If you wrote a sound transformer, the solver should say 'unsat'
(check-sat)
; If the solver returns 'sat', uncommenting the line below will give you the values of the various variables that violate the soundness property. This will help you debug your solution.
;(get-model)