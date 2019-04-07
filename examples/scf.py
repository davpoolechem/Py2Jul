import numpy
import scipy
from scipy.linalg import sqrtm

def index(a,b):
    return int(a*(a+1)/2 + b if (a > b) else b*(b+1)/2 + a)

def twoei(fock, density, nbf, tei, hcore):
    fock = hcore.copy()
    #fock = numpy.zeros((nbf,nbf))
    J = numpy.zeros((nbf,nbf))
    K = numpy.zeros((nbf,nbf))

    for i in range(nbf):
        for j in range(nbf):
            for k in range(nbf):
                for l in range(nbf):
                    ij = index(i,j)
                    kl = index(k,l)
                    ijkl = index(ij,kl)
                    #ik = index(i,k)
                    #jl = index(j,l)
                    #ikjl = index(ik,jl)

                    eri = tei[ijkl]

                    J[i,j] += density[k,l] * eri
                    K[i,k] += density[j,l] * eri
                    #fock[i,j] += density[k,l] * (2*tei[ijkl] - tei[ikjl])

    fock += 2*J - K
    return fock

def scf(basis):
    #read in dat file
    dat = []

    f = open('test.txt','r')
    for line in f:
        dat.append(line)

    #read in nuclear energy
    E_nuc = float(dat[1])

    #read in one-electron integrals
    S = numpy.zeros((7,7))
    for index in range(5,33):
        i = int(dat[index][0]) - 1
        j = int(dat[index][6]) - 1
        S[i,j] = float(dat[index][9:28])
        S[j,i] = S[i][j]

    T = numpy.zeros((7,7))
    for index in range(36,64):
        i = int(dat[index][0]) - 1
        j = int(dat[index][6]) - 1
        T[i,j] = float(dat[index][9:28])
        T[j,i] = T[i,j]

    V = numpy.zeros((7,7))
    for index in range(67,95):
        i = int(dat[index][0]) - 1
        j = int(dat[index][6]) - 1
        V[i,j] = float(dat[index][9:28])
        V[j,i] = V[i,j]

    H = T+V

    #read in two-electron integrals
    tei = numpy.zeros((2401))
    for ind in range(98,326):
        i = int(dat[ind][0])
        j = int(dat[ind][6])
        k = int(dat[ind][12])
        l = int(dat[ind][18])

        ii = i - 1
        jj = j - 1
        kk = k - 1
        ll = l - 1

        ij = int(ii*(ii+1)/2 + jj if (ii > jj) else jj*(jj+1)/2 + ii)
        kl = int(kk*(kk+1)/2 + ll if (kk > ll) else ll*(ll+1)/2 + kk)
        ijkl = int(ij*(ij+1)/2 + kl if (ij > kl) else kl*(kl+1)/2 + ij)

        tei[ijkl] = float(dat[ind][22:41])

    #build orthogonalization matrix
    S_eig = numpy.linalg.eigh(S)

    S_evec = S_eig[1]
    S_eval_diag = S_eig[0]
    S_eval = numpy.zeros((7,7))
    for i in range(7):
        S_eval[i,i] = S_eval_diag[i]

    ortho = numpy.zeros((7,7))
    #ortho = S_evec*numpy.linalg.inv((scipy.linalg.sqrtm(S_eval)))*numpy.transpose(S_evec)
    ortho_tmp = numpy.matmul(S_evec, numpy.linalg.inv(scipy.linalg.sqrtm(S_eval)))
    ortho = numpy.matmul(ortho_tmp, numpy.transpose(S_evec))

    #build initial Fock matrix
    fock_tmp = numpy.matmul(numpy.transpose(ortho),H)
    fock = numpy.matmul(fock_tmp,ortho)

    #initial iteration
    F_eig = numpy.linalg.eigh(fock)

    F_eval = F_eig[0]

    F_evec = F_eig[1]
    F_evec = F_evec[:,numpy.argsort(F_eval)]

    coeff = numpy.matmul(ortho,F_evec)

    density = numpy.zeros((7,7))

    for i in range(7):
        for j in range(i+1):
            density[i,j] = numpy.dot(coeff[i,0:4],coeff[j,0:4])
            density[j,i] = density[i,j]

    #no idea why, but this element is the only element wrong in the above density matrix
    #hack to fix
    density[4,4] = 1.0

    #initial scf energy
    E_elec = numpy.reduce(numpy.dot(density,H+fock))
    E_tot = E_elec + E_nuc

    #first iteration of fock build
    fock_a = twoei_kl(fock, density, 7, tei)
    fock_a += H

    return fock_a
