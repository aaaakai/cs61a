;;; Homework 09: Scheme List, Tail Recursion and Macro

;;; Required Problems

(define (make-change total biggest)
  (define (list-append item-to-append pair-list)
    (if (null? pair-list)
      (list (list item-to-append))
      (if (null? (cdr pair-list))
        (list (append (list item-to-append) (car pair-list)))
        (cons (append (list item-to-append) (car pair-list))
              (list-append item-to-append (cdr pair-list)))))
  )
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
  'YOUR-CODE-HERE
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
            (k-curry-helper1 (cdr args) (cdr vals) indices (+ 1 index)))))
)

(define (k-curry-helper2 args vals indices index)
  (if (null? indices)
    args
    (if (= index (car indices))
      (k-curry-helper2 (cdr args) (cdr vals) (cdr indices) (+ 1 index))
      (cons (car args)
            (k-curry-helper2 (cdr args) (cdr vals) indices (+ 1 index)))))
)

(define-macro (k-curry fn args vals indices)
  (lambda `(k-curry-helper2 ,args ,vals ,indices 0)
    `(,fn `(k-curry-helper1 ,args ,vals ,indices 0)))
)


(define-macro (let* bindings expr)
  ''YOUR-CODE-HERE
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
  'YOUR-CODE-HERE
)

; Helper Functions for you
(define (cadr lst) (car (cdr lst)))
(define (cddr lst) (cdr (cdr lst)))
(define (caddr lst) (car (cdr (cdr lst))))
(define (cdddr lst) (cdr (cdr (cdr lst))))

(define-macro (infix expr)
  ''YOUR-CODE-HERE
)
