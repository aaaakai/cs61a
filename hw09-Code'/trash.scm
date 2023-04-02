(define (find-nest n sym)
  (define (in item pair)
    (if (null? pair)
      #f
      (if (number? pair)
        (if (= item pair)
          #t
          #f)
        (if (find-nest n (car sym))
          #t
          (find-nest n (cdr sym)))))
  )
  (define (helper item pair outer-process)
    (if (number? pair)
      outer-process
      (if (in item (car pair))
        (helper item (car pair) (cons 'car outer-process))
        (helper item (cdr pair) (cons 'cdr outer-process))))
  )
  (if (in item (car sym))
    (helper item (car sym) (cons 'car 'sym))
    (helper item (cdr sym) (cons 'cdr 'sym')))
)