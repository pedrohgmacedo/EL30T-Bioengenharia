# BIOENGENHARIA - LABORATORIO 06
# Aluno: Pedro Henrique Garcia Macedo
# R.A.: 1829696

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import pywt
import scipy.fftpack as ft
import scipy.signal as sg

# Ex 1.

# Importando os dados
df = pd.read_excel("p_10_1.xls")

# lendo os canais 0 e 8
ch0 = df["Chan 0"]
ch8 = df["Chan 8"]
n, = ch0.shape
CH0 = abs(ft.fft(ch0.to_numpy()))[0:int(n/2)]
CH8 = abs(ft.fft(ch8.to_numpy()))[0:int(n/2)]

# criando vetores auxiliares
fs = 256
t = np.r_[0:n/fs:1/fs]*1e3
freq = ft.fftfreq(n, d=1/fs)[0:int(n/2)]

# aplicando um filtro passa-alta:
CH0[0:2] = 0
CH8[0:2] = 0

# frequências dominantes, onde freq é o vetor de frequência
freq_dom1 = freq[CH0.argmax()]
freq_dom8 = freq[CH8.argmax()]

# a.) plots
# a estrelinha amarela indica a frequência dominante
plt.subplot(211)
plt.plot(freq, CH0)
plt.plot(freq_dom1, CH0.max(), '*')
plt.title("Canal 0")
plt.grid()

plt.subplot(212)
plt.plot(freq, CH8)
plt.plot(freq_dom8, CH8.max(), '*')
plt.title("Canal 8")
plt.grid()

plt.xlabel("Frequência (Hz)")
plt.tight_layout()
plt.show()

# b.) plots
st = sg.detrend(ch0, type="linear")

plt.subplot(311)
plt.psd(ch0)
plt.ylabel("")

plt.subplot(312)
plt.psd(st)
plt.ylabel("PSD (dB/Hz)")

plt.subplot(313)
plt.plot(st - ch0)
plt.ylabel("Signal trend")
plt.grid()

plt.tight_layout()
plt.show()

# Ex 2.

# o modulo de wavelets é chamado pywavelets

# lendo os dados
df = pd.read_excel("p_10_2.xls")

# info que vamos usar
fs = 100
n, _ = df.shape
n = int(n/4)
t = np.r_[0:n/fs:1/fs]
freq = ft.fftfreq(n, d=1/fs)[0:int(n/2)]

I = df[0:1000]
II = df[1000:2000]
III = df[2000:3000]
IV = df[3000:4000]

_, I_cD2, _ = pywt.wavedec(I.T, 'db2', level=2)
_, II_cD2, _ = pywt.wavedec(II.T, 'db2', level=2)
_, III_cD2, _ = pywt.wavedec(III.T, 'db2', level=2)
_, IV_cD2, _ = pywt.wavedec(IV.T, 'db2', level=2)

plt.subplot(411)
# plot acontece conforme a linha
plt.plot(I_cD2.T)
plt.title("Detalhe cD2 Sinal I")
plt.grid()

plt.subplot(412)
plt.plot(II_cD2.T)
plt.title("Detalhe cD2 Sinal II")
plt.grid()

plt.subplot(413)
plt.plot(III_cD2.T)
plt.title("Detalhe cD2 Sinal III")
plt.grid()

plt.subplot(414)
plt.plot(IV_cD2.T)
plt.title("Detalhe cD2 Sinal IV")
plt.grid()

plt.tight_layout()
plt.show()


# Ex 3.

# lendo os dados
df = pd.read_excel("p_10_3.xls")

n, _ = df.shape
SIG = abs(ft.fft(df))[0:int(n/2)]

fs = 173.61
t = np.r_[0:n/fs:1/fs]
freq = ft.fftfreq(n, d=1/fs)[0:int(n/2)]

plt.plot(t, df)
plt.plot(freq, SIG)
plt.show()
