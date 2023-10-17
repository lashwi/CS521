; Lines that start with a semicolon are comments

; Define the function for which you are constructing a transformer
(declare-const c0 Real)
(declare-const c1 Real)
(declare-const c2 Real)
(declare-const c3 Real)
(declare-const d0 Real)
(declare-const d1 Real)
(declare-const d2 Real)
(declare-const d3 Real)

(define-fun f ((x Real) (y Real)) Bool
	(exists ((e1 Real)) 
		(and (>= e1 -1) (<= e1 1)
			(exists ((e2 Real)) 
				(and (>= e2 -1) (<= e2 1) 
					(exists ((eu Real))
						(and (>= eu -1) (<= eu 1) 
							and (= (+ c0 (* c1 e1) (* c2 e2) (* c3 eu)) x)
								and (= (+ d0 (* d1 e1) (* d2 e2) (* d3 eu)) y)))))))       ; absolute value function
)

;; e1=1,e2=1 => (6,2) and (0,2)
;; e1=1,e2=-1 => (2,0) and (4,0)
;; e1=-1,e2=1 => (4,0) and (-2, 0)
;; e1=-1,e2=-1 => (0,-2) and (2, -2)
(assert (
	and (f 6 2)
	and (f 0 2) 
	and (f 2 0)
	and (f 4 0)
	and (f -2 0)
	and (f 0 -2)
	and (f 2 -2)
	;; and (= d0 0)
	;; and (= d1 1)
	;; and (= d2 1)
	;; and (= d3 0)
	;; and (= c0 2)
))

; This command asks the solver to check the satisfiability of your query
; If you wrote a sound transformer, the solver should say 'unsat'
(check-sat)
; If the solver returns 'sat', uncommenting the line below will give you the values of the various variables that violate the soundness property. This will help you debug your solution.
(get-model)