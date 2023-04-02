(define-macro (test-control bindings expr)
	`(if (null? ,(cdr bindings))
		1
		0)
)

(test-control ((0 1) (2 3)) (+ 1 2))
