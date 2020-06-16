function mag_correct = magCorrectEqu(x,A,b,k)
mag_correct = k*(x-b)*A;