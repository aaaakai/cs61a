;;; Homework 09: Scheme List, Tail Recursion and Macro

;;; Required Problems
(define (list-append item-to-append pair-list)
  (if (null? pair-list)
    (list (list item-to-append))
    (if (null? (cdr pair-list))
      (list (append (list item-to-append) (car pair-list)))
      (cons (append (list item-to-append) (car pair-list))
            (list-append item-to-append (cdr pair-list)))))
)

(define (make-change total biggest)
  (if (= total 0)
    nil
    (if (< total biggest)
      (make-change total (- biggest 1))
      (if (= biggest 1)
        (list-append 1 (make-change (- total 1) biggest))
        (append (list-append biggest (make-change (- total biggest) biggest))
                (make-change total (- biggest 1))))))
)


(define (find n lst)
  (if (= n (car lst))
    0
    (+ 1 (find n (cdr lst))))
)


(define (find-nest n sym)
  (define (in item pair)
    (if (null? pair)
      #f
      (if (number? pair)
        (if (= item pair)
          #t
          #f)
        (if (in n (car pair))
          #t
          (in n (cdr pair)))))
  )
  (define (helper item pair outer-process)
    (if (number? pair)
      outer-process
      (if (in item (car pair))
        (helper item (car pair) (cons 'car (cons outer-process nil)))
        (helper item (cdr pair) (cons 'cdr (cons outer-process nil)))))
  )
  (if (in n (car (eval sym)))
    (helper n (car (eval sym)) (list 'car sym))
    (helper n (cdr (eval sym)) (list 'cdr sym)))
)


(define-macro (def func args body)
  `(define ,func (lambda ,args ,body))
)

(define (k-curry-helper1 args vals indices index)
  (if (null? indices)
    args
    (if (= index (car indices))
      (cons (car vals)
            (k-curry-helper1 (cdr args) (cdr vals) (cdr indices) (+ 1 index)))
      (cons (car args)
            (k-curry-helper1 (cdr args) vals indices (+ 1 index)))))
)

(define (k-curry-helper2 args vals indices index)
  (if (null? indices)
    args
    (if (= index (car indices))
      (k-curry-helper2 (cdr args) (cdr vals) (cdr indices) (+ 1 index))
      (cons (car args)
            (k-curry-helper2 (cdr args) vals indices (+ 1 index)))))
)

(define-macro (k-curry fn args vals indices)
  `(lambda ,(k-curry-helper2 args vals indices 0)
    ,(cons fn (k-curry-helper1 args vals indices 0)))
)


(define-macro (let* bindings expr)
  `(if (null? ',(cdr bindings))
    (let ,(list (car bindings)) ,expr)
    (let ,(list (car bindings)) (let* ,(cdr bindings) ,expr)))
)

;;; Just For Fun Problems

; Tree ADT
(define (tree label branches) (cons label branches))
(define (label t) (car t))
(define (branches t) (cdr t))
(define (is-leaf t) (null? (branches t)))

; A tree for test
(define t1 (tree 1
  (list
    (tree 2
      (list
        (tree 3 nil)
        (tree 7 (list
          (tree 7 nil)))))
    (tree 3 nil)
    (tree 6
      (list
        (tree 7 nil))))))

(define (find-in-tree t goal)
  (define (in-branches bran target)
    (if (null? bran)
      #f
      (or (in-tree (car bran) target)
        (in-branches (cdr bran) target)))
  )
  (define (in-tree tre target)
    (if (= (label tre) target)
      #t
      (in-branches (branches tre) target))
  )
  (define (helper bran target)
    (append (find-in-tree (car bran) target)
            (if (in-branches (cdr bran) target)
              (helper (cdr bran) target)
              nil))
  )
  (if (= goal (label t))
    (cons (list goal) 
          (if (in-branches (branches t) goal)
            (list-append (label t)(helper (branches t) goal))
            nil))
    (if (in-branches (branches t) goal)
      (list-append (label t)(helper (branches t) goal))
      nil))    
)

; Helper Functions for you
(define (cadr lst) (car (cdr lst)))
(define (cddr lst) (cdr (cdr lst)))
(define (caddr lst) (car (cdr (cdr lst))))
(define (cdddr lst) (cdr (cdr (cdr lst))))

(define-macro (infix expr)
	`(,(car (cdr expr)) 
		  (if (pair? ',(car expr))
		  	(infix ,(car expr))
		  	,(car expr))
		  (if (pair? ',(car (cdr (cdr expr))))
		  	(infix ,(car (cdr (cdr expr))))
		  	,(car (cdr (cdr expr)))))
)
