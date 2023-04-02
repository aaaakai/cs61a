;;; Lab 10: Stream

;;; Required Problems

(define (filter-stream f s)
  (if (null? s) nil
    (if (f (car s))
        (cons-stream (car s) (filter-stream f (cdr-stream s)))
        (filter-stream f (cdr-stream s))))
)


(define (slice s start end)
  (if (null? s) nil
    (if (= start end) nil
      (if (= 0 start)
        (cons (car s)
              (slice (cdr-stream s) 0 (- end 1)))
        (slice (cdr-stream s) (- start 1) (- end 1)))))
)


(define (naturals n)
  (cons-stream n (naturals (+ n 1))))


(define (combine-with f xs ys)
  (if (or (null? xs) (null? ys))
      nil
      (cons-stream
        (f (car xs) (car ys))
        (combine-with f (cdr-stream xs) (cdr-stream ys)))))


(define factorials
  (cons-stream 1 (combine-with * (naturals 1) factorials))
)


(define fibs
  (cons-stream 0 (cons-stream 1 (combine-with + fibs (cdr-stream fibs))))
)


(define (exp x)
  (define x-serial (cons-stream x x-serial))
  (cons-stream 1 
              (combine-with + (exp x)
                (combine-with / (combine-with expt x-serial (naturals 1))
                  (cdr-stream factorials))))
)


(define (list-to-stream lst)
  (if (null? lst) nil
      (cons-stream (car lst) (list-to-stream (cdr lst)))))

(define (nondecrease-helper1 s prenum)
  (if (null? s) nil
    (if (> prenum (car s)) nil
      (cons (car s) 
            (nondecrease-helper1 (cdr-stream s) (car s)))))
)

(define (nondecrease-helper2 s prenum)
  (if (null? s) nil
    (if (> prenum (car s)) s
      (nondecrease-helper2 (cdr-stream s) (car s))))
)

(define (nondecrease s)
  (if (null? s) nil
    (cons-stream (cons (car s) (nondecrease-helper1 (cdr-stream s) (car s)))
                  (nondecrease (nondecrease-helper2 (cdr-stream s) (car s)))))
)


;;; Just For Fun Problems

(define-macro (my-cons-stream first second) ; Does this line need to be changed?
  `(cons ,first ',second)
)

(define (my-car stream)
  (car stream)
)

(define (my-cdr-stream stream)
  (eval (cdr stream))
)


(define (sieve s)
  (define (helper1 nums num)
    (if (= num (car nums))
      #t
      (if (= 0 (modulo num (car nums)))
        #f
        (helper1 (cdr-stream nums) num)))
  )
  (define (helper2 num)
    (helper1 s num))
  (filter-stream helper2 s)
)

(define primes (sieve (naturals 2)))
