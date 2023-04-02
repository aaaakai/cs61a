test = {
  'name': 'filter-stream',
  'points': 1,
  'suites': [
    {
      'cases': [
        {
          'code': r"""
          scm> (define (natral n) (cons-stream n (natral (+ 1 n))))
          natral
          scm> (define x (natral 0))
          x
          scm> (define y (filter-stream even? x))
          y
          scm> (car y)
          0
          scm> (car (cdr-stream y))
          2
          scm> (car (cdr-stream (cdr-stream y)))
          4
          """,
          'hidden': False,
          'locked': False,
          'multiline': False
        }
      ],
      'scored': True,
      'setup': r"""
      scm> (load-all ".")
      """,
      'teardown': '',
      'type': 'scheme'
    }
  ]
}
