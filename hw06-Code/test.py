def f1(x):
    def f2(y):
        if x > y:
            return False
        else:
            return True
    return f2
