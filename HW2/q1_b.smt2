; Lines that start with a semicolon are comments


; Define the function for which you are constructing a transformer

; f(x) = x^3
(define-fun f ((x Real)) Real
(* x (* x x)))


; Define the transformer as two functions
; one for the lower bound of the range and one for the upper bound


(define-fun Tf_lower ((l Real) (u Real)) Real
(* l (* l l)))

(define-fun Tf_upper ((l Real) (u Real)) Real
(* u (* u u )))

; To state the correctness of the transformer, ask the solver if there is
; (1) a Real number x and (2) an interval [l,u]
; that violate the soundness property, i.e., satisfy the negation of the soundness property.


(declare-const x Real)
(declare-const l Real)
(declare-const u Real)


; store complex expressions in intermediate variables
; output under the function
(declare-const fx Real)
(assert (= fx (f x)))
; lower bound of range interval
(declare-const l_Tf Real)
(assert (= l_Tf (Tf_lower l u)))
; upper bound of range interval
(declare-const u_Tf Real)
(assert (= u_Tf (Tf_upper l u)))




(assert (not ; negation of soundness property
(=>
(and (<= l x) (<= x u)) ; if input is within given bounds
(and (<= l_Tf fx) (<= fx u_Tf)) ; then output is within transformer bounds
)))




; This command asks the solver to check the satisfiability of your query
; If you wrote a sound transformer, the solver should say 'unsat'
(check-sat)
; If the solver returns 'sat', uncommenting the line below will give you the values of the various variables that violate the soundness property. This will help you debug your solution.
;(get-model)
