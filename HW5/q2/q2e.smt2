; Lines that start with a semicolon are comments


; Define the function for which you are constructing a transformer

(define-fun g ((x Real)) Real
(* x x)
)


(define-fun h ((x Real)) Real
(* x (* x x))
)

; f(x) = max(x^2, x^3)
(define-fun f ((x Real)) Real
(ite (>= (g x) (h x)) (h x) (g x))
)

; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound


(define-fun Tf_lower ((x Real) (y Real)) Real (let ((_let_1 (g x))) (let ((_let_2 (h x))) (ite (> _let_1 _let_2) _let_2 _let_1))))
(define-fun Tf_upper ((x Real) (y Real)) Real (let ((_let_1 (h y))) (let ((_let_2 (g y))) (ite (> _let_2 _let_1) _let_2 _let_1))))

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