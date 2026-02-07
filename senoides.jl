### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 9adef71e-de60-4794-b721-c2ea7c128aab
using PlutoUI, CairoMakie, LaTeXStrings, Markdown

# ╔═╡ ec48964c-ebc3-11f0-8691-9b760cc0aa0e
md"""
# Senoides e Fasores
## Senoides
Uma corrente senoidal é normalmente conhecida como *corrente alternada (CA)*. Essa corrente se inverte em intervalos de tempo regulares, e possui, alternadamente, valores positivos e negativos.

!!! info "Senoide"
	**Senóide** é um sinal que possui a forma da função seno ou cosseno.

- Consideremos a tensão senoidal

```math
v(t) = V_m \sin{\omega t}
```

onde

``V_m`` = *Amplitude da senoide* \
``\omega`` = *Frequência angular em radiados/s* \
``\omega t`` = *Argumento da senoide*

Fica evidente que a senoide se repete a cada ``T`` segundos, portanto ``T`` é chamado *período* da senoide. Abaixo, observamos que ``\omega t = 2 \pi``.

```math
T = \frac{2\pi}{\omega}
```
"""

# ╔═╡ eeee2496-16a3-4e9a-8b64-4df4999afd9c
LocalResource("imagens/senoide.png")

# ╔═╡ 195bf467-d56d-4df6-bbc0-68dcbd175d33
md"""
O fato de ``v(t)`` repetir-se a cada ``T`` segundos é demonstrado substituindo-se ``t`` por ``t + T`` na equação anterior. Obetemos então:

```math
\begin{aligned}
v(t + T) &= V_m \sin{\omega(t + T)} = V_m \sin{\omega(t + \frac{2 \pi}{\omega})}\\
V_m \sin{\omega t + 2 \pi} &= V_m \sin{\omega t} = v(t) 
\end{aligned}
```

Portanto:

```math
v(t + t) = v(t)
```

!!! info "Função Periódica"
	**Função periódica** é aquela que satisfaz ``f(t) = f(t + nT)``,
	para todo t e para todos os inteiros n.


A frequência cíclica é o inverso do período 
```math
f = \frac{1}{T}
```
A partir das equações acima, fica evidente que:
```math
\omega = 2 \pi f
```

!!! warning "Atenção"
	Enquanto ``\omega`` é lido em radianos por segundo (rad/s),
	``f`` é dado em **hertz** (Hz).

Consideremos agora, uma expressão mais genérica para senóide,
```math
v(t) = V_m \cdot \sin{\omega t + \phi}
```

onde ``\omega t + \phi`` é o argumento e ``\phi`` é a fase. Tanto um como outro podem ser radianos ou graus.
"""

# ╔═╡ da16197d-656a-4c91-9ed0-eddbcb6088ff
md"""
### Comparando duas Senoides
Examinemos as duas senoides a seguir:

``v_1(t) = V_m \sin{\omega t}`` e ``v_2(t) = V_m \sin{\omega t + \phi}``

Dizemos que ``v_2`` está avançada em relação a ``v_1`` em ``\phi``. Se ``\phi=0`` dizemos que ``v_1`` e ``v_2`` estão em fase. Se ``\phi \neq 0``, dizemos que ``v_1`` e ``v_2`` estão fora de fase. 
"""

# ╔═╡ aa4418f3-0711-48f7-a322-9115e69255f1
LocalResource("imagens/fase.png")

# ╔═╡ f9ec4b5f-4384-4179-91a8-231d7c6902d0
md"""
!!! info "Expressando Senoides"
	Uma senoide pode ser expressa em termos de seno ou cosseno. Ao compararmos duas senoides, é indicado que expressemos ambas como seno, ou então como cosseno, e com amplitudes positivas.

Conseguimos usando-se as seguintes indentidades trigonométricas:
```math
\begin{aligned}
\sin{A \pm B} = \sin{A} \cos{B} \pm \cos{A} \sin{B} \\
\cos{A \pm B} = \cos{A} \cos{B} \mp \sin{A} \sin{B}
\end{aligned}
```

Com essas indentidades trigonométricas, fica fácil demonstrar que:
```math
\begin{aligned}
\sin{\omega t \pm 180\degree} &= -\sin{\omega t} \\
\cos{\omega t \pm 180\degree} &= -\cos{\omega t} \\
\sin{\omega t \pm 90\degree} &= \pm \cos{\omega t} \\
\cos{\omega t \pm 90\degree} &= \mp \sin{\omega t} \\
\end{aligned}
```
"""

# ╔═╡ 061c5606-ee63-432c-9bfb-1ff93613f52d
md"""
### Exemplo 9.1
Determine a amplitude, a fase, o período e a frequência da senoide ``v(t)=12\cos{50t + 10\degree}``.
"""

# ╔═╡ 1098a831-13fc-4819-a80c-9e65fce964de
let
	vm = 12
	ω = 50 # rad/s.
	ϕ = 10
	T = round((2π)/ω, digits=4) # em segundos.
	f = round(1/T, digits=4) # em hz.
	@info "Resultados:" vm ω ϕ T f
	v(t) = 12*cos(2π*f*t+ϕ)
	x = LinRange(0, 1, 500)
	# Desenha a senoide
	y = v.(x)
	f = Figure(size=(600, 250))
	ax = Axis(f[1, 1], title=L"v(t)=12\cos{50 t 10}",
			 xlabel=L"t(s)", ylabel=L"V_m")
	lines!(ax, x, y, linewidth=3)
	f
end

# ╔═╡ 11cd3feb-92b1-4ca0-a619-4a37234439bf
md"""
### Problema Prático 9.1
Dada a senoide ``30 \sin(4\pi t – 75°)``, calcule sua amplitude, fase, frequência angular, período e frequência.
"""

# ╔═╡ 81bab0c6-1333-42ec-b086-91cbd9e7a2c3
let
    vm = 30
    ϕ = deg2rad(-75) # em graus para radianos.
    T = 2π/4π # em segundos.
    f = 1/T # em Hz.
    ω = round(2π * f, digits=3) # em radianos/s

    @info "Resultados:" vm ω ϕ T f

    # Desenha a senoide.
    v(t) = 30*sin(ω*t + ϕ)
    x = LinRange(0, 1, 300)
    y = v.(x)
    f = Figure(size=(600, 250))
    ax = Axis(f[1, 1], title=L"v(t)=30 \sin{\omega t + \phi}",
            xlabel=L"Tempo (s)", ylabel=L"V_m")
    lines!(ax, x, y, linewidth=3)
    f
end

# ╔═╡ 97c91ba9-6c00-4645-ac36-c5a9aabd4336
md"""
### Circulo Trigonométrico
Necessário para os exercícios a seguir.
"""

# ╔═╡ 225fc9f9-a16a-4a58-94c4-55166e04a55c
LocalResource("imagens/ctrig.svg")

# ╔═╡ 618601bf-3032-4350-97e5-2be66c6c13e7
md"""
### Exemplo 9.2
Calcule o ângulo de fase entre ``v_1 = –10 \cos(\omega t + 50^\circ)`` e ``v_2 = 12 sin(\omega t – 10^\circ)``. Indique
qual senoide está avançada.

- **Solução**

1 - Precisamos expressar ``v_1`` e ``v_2`` da mesma forma. Com todos na forma de senos ou cossenos. Iremos expressá-las em termos de cossenos positivos.
```math
\begin{aligned}
v_1 = -10 \cos(\omega t + 50^\circ) &= 10 \cos(\omega t + 50^\circ - 180^\circ) \\
v_1 &= 10 \cos(\omega t -130^\circ)
\end{aligned}
```

Observe que, ``-\cos(x - 180^\circ) = \cos(y)``.

```math
\begin{aligned}
v_2 = 12 \sin(\omega t -10^\circ) &= 12 \cos(\omega t -10^\circ - 90^\circ) \\
v_2 = & 12 \cos(\omega t -100^\circ)
\end{aligned}
```

Logo, a diferença dos módulos ``\big|v_1\big| - \big|v_2\big| = 30^\circ``. O que responde a questão, pois ``v_2`` está adiantado em ``30^\circ`` em relação a ``v_1``.

2 - De forma alternativa, podemos expressar ``v_1`` na forma de seno.

```math
\begin{aligned}
    v_1 = -10 \cos(\omega t + 50^\circ) &= 10 \sin(\omega t + 50^\circ - 90^\circ) \\
    &= 10 \sin(\omega t -40^\circ) = 10 \sin(\omega t -10^\circ -30^\circ)    
\end{aligned}
```

Comparando com ``v_2 = 12 sin(\omega t – 10^\circ)``, vemos que ``v_1`` está atrasada com relação a ``v2``.

"""

# ╔═╡ eb2f8fb3-ac62-497e-9df9-5dccbc04170f
LocalResource("imagens/ex92.png")

# ╔═╡ 56cc696a-8e30-4d09-aa60-757be528992e
md"""
3 - Podemos considerar ``v_1`` simplesmente como ``v_1 = –10 \cos(\omega t)`` com um
deslocamento de fase de ``+50^\circ``. Logo, ``v_1`` fica conforme exibido na figura acima. De modo similar, ``v_2`` é ``12 \sin(\omega t)`` com um deslocamento de fase de ``–10^\circ``, conforme mostra a figura acima. É fácil notar que ``v_2`` está avançado em relação a ``v_1`` em ``30^\circ``, isto é, ``90^\circ – 50^\circ – 10^\circ``.

### Problema Prático 9.2
Determine o ângulo de fase entre
```math
i_1 = -4 \sin(377t + 55^\circ) \text{ e } i_2 = 5 \cos(377t - 65^\circ)
```

Podemos transformar ``i_1`` em cosseno subtraindo ``90^\circ``. De modo que:
```math
\begin{aligned}
    \sin(x) &= cos(x - 90^\circ) \\ 
    i_1 &= -4 \sin(377t + 55^\circ - 90^\circ) = -4\cos(377t -35^\circ) \\
    &= -4\cos(377t + -35^\circ + 180^\circ) = 4\cos(377t + 145^\circ)
    
\end{aligned}
```

Logo ``i_1`` está adiantada em relação a ``i_2`` em ``210^\circ``.
"""

# ╔═╡ 408def6c-444a-42ba-8d37-c1355c84adb0
md"""
## Fasores
As senoides são facilmente expressas em termos de fasores, que são mais convenientes de serem trabalhados que as funções de seno e cosseno.

!!! info "Fasor"
	Fasor é um número complexo que representa a amplitude e a fase de uma senoide.

Um número complexo ``z`` pode ser descrito na sua forma polar ou exponencial, como segue:

```math
\begin{aligned}
z &= x + jy \\
z &= r \angle{\phi} = re^{j \phi}
\end{aligned}
```

Onde ``r`` é a magnitude de ``z`` e ``\phi`` é a fase de ``z``. Nota-se que ``z`` pode ser representado de três maneiras:

``z = x + jy`` **Forma retangular** \
``z = r \angle{\phi}`` **Forma polar** \
``z = re^{j \phi}`` **Forma exponencial** \
"""

# ╔═╡ 261c1203-8569-4a1b-ada7-ed8731732341
LocalResource("imagens/eixonumcomplex.png")

# ╔═╡ 26c360d8-5819-4a11-bf34-475e47102ffc
md"""
A relação entre a forma retangular e a forma polar é mostrada na figura acima, onde o eixo ``x`` representa a parte real e o eixo ``y`` representa a parte imaginária de um número complexo. Dados ``x \text{ e } y``, podemos obter ``r \text{ e } \phi`` como segue:

```math
r = \sqrt{x^2 + y^2} \text{, } \phi = tg^{-1 \frac{y}{x}}
```

Por outro lado, se conhecermos ``r \text{ e } \phi``, podemos obter ``x \text{ e } y`` como:

```math
x = r \cos(\phi) \text{, } y = r \sin{\phi}
```

!!! warning "Atenção"
	Portanto, ``z`` poderia ser expresso como indicado a seguir:
	```math
	z = x + jy = r\angle{\phi} = r(\cos(\phi) + j \sin(\phi))
	```
"""

# ╔═╡ cd6717b3-e739-403a-a496-e1360e2bcc06
md"""
A adição e subtração de números complexos são mais bem realizadas na forma retangular; a multiplicação e a divisão são mais bem efetuadas na forma polar. Dados os números complexos:

```math
\begin{aligned}
z = x + jy = r\angle{\phi} \text{,} \qquad z_1 &= x_1 + jy_1 = r_1\angle{\phi_1} \\
z_2 = x_2 + jy_2 &= r_2\angle{\phi_2}
\end{aligned}
```
!!! info "Operações"
	- Adição: ``z_1 + z_2 = (x_1 + x_2) + j(y_1 + y_2)``
	- Subtração: ``z_1 - z_2 = (x_1 - x_2) + j(y_1 - y_2)``
	- Multiplicação: ``z_1 \cdot z_2 = r_1 \cdot r_2 \angle \phi_1 + \phi_2``
	- Divisão: ``\frac{z_1}{z_2} = \frac{r_1}{r_2} \angle \phi_1 - \phi_2``
	- Inverso: ``\frac{1}{z} = \frac{1}{r}\angle -\phi``
	- Raiz Quadrada: ``\sqrt{z} = \sqrt{r} \angle \phi/2``
	- Conjugado Complexo: ``z^*=x-jy=r\angle -\phi = re^{-j\phi}``

Essas são as propriedades básicas dos números complexos que precisaremos.

A ideia de representação de **fasor** se baseia na **identidade de Euler**. Em geral
```math
e^{\pm j\phi} = \cos(\phi) \pm j \sin(\phi)
```

que demonstra que podemos considerar ``\cos(\phi) \text{ e } \sin{\phi}`` como as partes real e imaginária de ``e^{j\phi}``. Então podemos escrever:

```math
\begin{aligned}
\cos(\phi) &= Re(e^{j\phi}) \\
\sin(\phi) &= Im(e^{j\phi})
\end{aligned}
```

onde Re e Im significam a **parte real de** e a **parte imaginária de**, respectivamente. Dada a senoide $v(t) = V_m \cos(\omega t + \phi)$, usamos a equação acima para expressar $v(t)$ como

```math
v(t) = V_m \cos(\omega t + \phi) = Re(V_m e^{j(\omega t + \phi)})
```

ou

```math
v(t) = Re(V_m e^{j \phi} e^{j\omega t})
```

Portanto,
```math
v(t) = Re(Ve^{j\omega t}) 
```

onde
```math
V = V_m e^{j\phi} = V_m \angle \phi
```

**V** é, portanto, a **representação fasorial** da senoide $v(t)$.
"""

# ╔═╡ ae846e01-0992-4f63-84e9-aa9c986fe4b2
md"""
### Exemplo 9.3
Calcule os números complexos a seguir:

a) ``(40\angle 50^\circ + 20\angle -30^\circ)^{1/2}``

b) ``\frac{10\angle -30^\circ + (3 - j4)}{(2 + j4)(3-j5)^*}``
"""

# ╔═╡ e86b97fc-079d-46df-9ab0-0e1cd92b19bd
let
    # Exercício a)
    # Precisamos converter graus para radianos, pois
    # as funções da linguagem Julia trabalham com radianos.
    θ₁ = deg2rad(50)
    r₁ = 40
    θ₂ = deg2rad(-30)
    r₂ = 20

    z₁ = round(r₁ * cis(θ₁), digits=3)
    z₂ = round(r₂ * cis(θ₂), digits=3)
    z₃ = round(sqrt(z₁ + z₂), digits=3)

    # Realizando o caminho inverso
    # 1. Obtendo o raio (módulo)
    rₐ = round(abs(z₃), digits=3)

    # 2. Obtendo o ângulo de fase - radianos para graus
    θₐ = round(rad2deg(angle(z₃)), digits=3)

    # Exercício b)
    θ₁ = deg2rad(-30)
    r₁ = 10
    
    z₁ = round(r₁ * cis(θ₁), digits=3)
    z₂ = 3 - 4im
    z₃ = 2 + 4im
    z₄ = conj(3 - 5im)

    z₅ = round((z₁ + z₂)/(z₃ * z₄), digits=3)
    θₓ = round(rad2deg(angle(z₅)), digits=3)
    rₓ = round(abs(z₅), digits=3)

	data=
	"""
	**Resultado dos Exercícios a e b:**
	
	a. $rₐ ∠ $θₐ \\
	a. $rₓ ∠ $θₓ
	"""
	Markdown.parse(data)
end

# ╔═╡ 8e760db2-e38b-4e19-9341-fafffb86a38f
md"""
### Problema Prático 9.3
Calcule os seguintes números complexos:

a) ``[(5 + j2)(-1 + j4)] - 5 \angle 60^\circ``

b) ``\frac{10 + j5 + 3 \angle 40^\circ}{-3 + j4} + 10 \angle 30^\circ + j5``
"""

# ╔═╡ a1829730-7c0f-4055-8b76-2de2c1561fbc
let
	polar2rect(r, ϕ) = r*(cos(ϕ) + sin(ϕ)im)
	# Exercício a.
	r = 5
	ϕ = deg2rad(60)
	z₁ = 5 + 2im
	z₂ = -1 + 4im
	z₃ = polar2rect(r, ϕ)

	resultado = round(conj((z₁ * z₂) - z₃), digits=3)

	# Exercício b.
	z₁ = 10 + 5im
	r₁ = 3
	ϕ₁ = deg2rad(40)
	z₂ = polar2rect(r₁, ϕ₁)
	z₃ = -3 + 4im
	z₄ = polar2rect(10, deg2rad(30))
	resultadob = round(((z₁ + z₂)/z₃) + z₄ + 5im, digits=3)
	
	data = """
	**Resultado dos exercícios a e b:**

	a. $resultado

	b. $resultadob
	"""

	Markdown.parse(data)
end

# ╔═╡ 999fc068-76cd-4a56-8e3a-94437672b61b
md"""
!!! danger "Posição do Eixo Real"
	É comum(na engenharia elétrica) que o eixo da parte real esteja adiantada em $90^\circ$ para que a senoide possa ser projetada no domínio do tempo.
"""

# ╔═╡ 323a34d9-2961-43e8-a581-7d2e2ce56d46
LocalResource("imagens/fasorsenoiderel.png")

# ╔═╡ 140641ec-d75a-4a9c-947b-d67084a86fcd
md"""
### Exemplo 9.4
Transforme as senoides seguintes em fasores:

1. ``i =6\cos(50t - 40\degree) A``

2. ``-4\sin(30t + 50 \degree) V``

Resolvendo o exercício 1.

Apenas pegamos a amplitude e a transformamos no raio do fasor. O ângulo também é aproveitado. Descartamos ``\omega t`` pois, no domínio dos fasores, ``\omega`` 
é uma constante:

```math
6 \angle -40 \degree A
```

Resolvendo o exercício 2.

Aqui teremos de converter o -seno para cosseno somando ``90 \degree`` ao cosseno. Logo:

```math
\begin{aligned}
-4 \sin(30t + 50\degree) &= -4 \cos(30t + 50\degree + 90\degree) \\
&= 4\cos(30t + 140\degree)
\end{aligned}
```

Nosso resultado é:

```math
4 \angle 140\degree V
```

### Problema Prático 9.4
Transforme as senoides seguintes em fasores.
1. ``v = 7\cos(2t + 40^\circ)``
2. ``i = -4\sin(10t + 10^\circ)``

- Resolvendo o exercício 1
```math
7 \angle 40^\circ
```

- Resolvendo o exercício 2
Precisamos transformar o seno em cosseno nesse exercício, logo:

```math
\begin{aligned}
-4\sin(10t + 10^\circ) &= 4\cos(10t + 10^\circ + 90^\circ) \\
4\cos(10t + 100^\circ) &= 4 \angle 100^\circ
\end{aligned}
```
"""

# ╔═╡ c249754d-e492-42fc-90f4-042fd48f94d8
md"""
### Exemplo 9.5
Determine as senóides representadas pelos fasores seguintes:
1. ``I = -3 + j4 A``
2. ``V = j8e^{-j20^\circ}V``

- Solução:
1. ``I = -3 + j4 = 5 \angle 126.87\degree``. Transformando para o domínio do tempo resulta em:

```math
i(t) = 5 cos(\omega t + 126.87\degree) A
```

2. Já que ``j = 1 \angle 90\degree``,

```math
\begin{aligned}
V = j8 \angle -20\degree &= (1 \angle 90\degree)(8 \angle -20\degree) \\
&= 8 \angle 90\degree - 20\degree = 8 \angle 70\degree V
\end{aligned}
```

Convertendo para o domínio do tempo temos:
```math
v(t) = 8 cos(\omega t + 70\degree)
```
"""

# ╔═╡ 62e37237-38c5-4234-a8e8-6e86aa591894
let
	v(t) = 8*cos(2*π*5*t + deg2rad(70))
	i(t) = 5*cos(2*π*5*t + deg2rad(126.87))
	x = LinRange(0, 1, 200)
	y = v.(x)

	f = Figure(size=(500, 300))
	ax = Axis(f[1, 1], xlabel=L"t", ylabel=L"f(t)")
	lines!(ax, x, y, linewidth=3, label=L"v(t)=8\cos(\omega t + 70\degree)V")
	y = i.(x)
	lines!(ax, x, y, linewidth=3, label=L"i(t)=5\cos(\omega t + 126.87\degree)A")
	axislegend(ax; position=:rb, backgroundcolor=RGBAf(1., 1., 1., .85),
			  framevisible=true)
	f
end

# ╔═╡ 53a78ee2-21e8-4971-b938-9a317e9a4cd3
md"""
### Problema Prático 9.5
Determine as senóides representadas pelos fasores seguintes:
1. ``V = -25 \angle 40\degree V``.

Para esse exercício, tudo é muito simples. Precisamos apenas remover o sinal negativo do raio somando ``180\degree``.

```math
\begin{aligned}
-25 \angle 40\degree &= 25 \angle 40\degree + 180\degree \\
&= 25 \cos(\omega t + 220\degree) V
\end{aligned}
```
2. ``I = j(12 - j5)A``.

Nesse exercício, precisamos multiplicar j e converter ambos os números para sua forma polar.
"""

# ╔═╡ 5b76deb6-4d77-45de-b192-2511661d079f
let
	r₁ = 1
	ϕ₁ = round(90, digits=3)
	z = 12 - 5*im
	r₂ = round(abs(z), digits=3)
	ϕ₂ = round(rad2deg(angle(z)), digits=3)

	@info "j na sua forma polar" r₁ ϕ₁
	@info "z na sua forma polar" r₂ ϕ₂

	r₃ = r₁ * r₂
	ϕ₃ = ϕ₁ + ϕ₂

	markd = """
	- **Resultado**

	Na sua forma polar:
		
	**raio:** $r₃

	**ângulo:** $ϕ₃

	**senoide:** ``$r₃ \\cos(\\omega t + $ϕ₃) A``
	"""
	
	Markdown.parse(markd)
end

# ╔═╡ 669fda38-8aef-4e4e-b51a-f5dfc5bfb5f8
md"""
### Exemplo 9.6
Dados ``i(t)=4\cos(\omega t + 30\degree) A`` e ``5 \sin(\omega t + 20\degree)A``, determine sua soma.

- **Solução:** Eis um importante uso dos fasores - a soma de senoides de mesma frequência. A corrente ``i_1(t)`` se encontra na sua forma padrão. Seu fasor é

```math
I_1 = 4 \angle 30\degree
```

Precisamos expressar ``i_2(t)`` na forma de cosseno. A regra para conversão de seno em cosseno é subtrair ``90\degree``. Portanto,

```math
i_2 = 5 \cos(\omega t + 20\degree - 90\degree) = 5\cos(\omega t - 70\degree)
```

seu fasor é

```math
I_2 = 5 \angle - 70\degree
```

Se fizermos ``i = i_1 + i_2``, então

```math
I = I_1 + I_2 = 4 \angle 30\degree + 5 \angle - 70\degree
```
Iremos converter os dois fasores para a forma retangular e somá-los.
"""

# ╔═╡ 0dc9c342-4b78-4629-a9ae-2188604226cf
let
	z₁ = round(4 * cis(deg2rad(30)))
	z₂ = round(5 * cis(deg2rad(-70)))
	@info "Numeros que devem ser somados" z₁ z₂
	z₃ = z₁ + z₂

	result="""
	- Resultado:

	Forma Retangular: $z₃

	Senoide: ``$(round(abs(z₃))) \\cos(\\omega t $(round(rad2deg(angle(z₃))))  \\degree)``
	"""
	Markdown.parse(result)
end

# ╔═╡ 4516e2ae-6021-4b86-b0ab-f75d1f970b1f
md"""
### Problema Prático 9.6
Se ``v_1(t) = -10 \sin(\omega t -30\degree)V`` e ``v_2(t) = 20 \cos(\omega t + 45\degree)``, determine ``v = v_1 + v_2``.

O primeiro passo para a solução é converter -seno para cosseno adicionando 90° na fase.

```math
\begin{aligned}
v_1(t) &= -10 \sin(\omega t -30\degree) = 10 \cos(\omega t -30\degree + 90\degree) \\
&= 10 \cos(\omega t + 60\degree)
\end{aligned}
```

A seguir convertemos os dois números para a forma retangular e somamos.
"""

# ╔═╡ 49cd52de-8495-4570-b022-804f76b387e3
md"""
### Exemplo 9.7
Usando o método de fasores, determine a corrente ``i(t)`` em um circuito descrito pela equação diferencial:

```math
4i + 8 \int{i \cdot dt} - 3 \frac{di}{dt} = 50 \cos(2t + 75°)
```

- **Solução:** Transformamos cada termo da equação no domínio do tempo para o domínio dos fasores. Obtemos a forma em termos de fasores da equação dada como segue:

- ``i(t) \to I``
- ``\frac{di}{dt} \to j\omega I``
- ``\int{i dt} \to \frac{I}{j\omega}``

Aplicando à equação:

```math
4I + 8\cdot \frac{I}{j \omega} - 3 \cdot(j \omega I) = 50 \angle 75\degree
```

- **Substituindo pela Frequência Angular**
  
  O problema nos dá $\cos(2t + 75\degree)$, então $\omega = 2$ rad/s.

  ```math
  \begin{aligned}
    4I + \frac{8I}{j2} - 3 \cdot j(2)I &= 50 \angle 75\degree \\
    &= 4I + \frac{8I}{j2} -6jI = 50 \angle 75\degree
  \end{aligned}
  ```
- **Simplificando os Termos**
  ```math
    \frac{8}{j2} = \frac{8}{2j} = \frac{4}{j} = -j4
  ```
  Logo:

  ```math
  \begin{aligned}
    4I -j4I - j6I &= 50 \angle 75\degree \\
    I(4 - j10) &= 50 \angle 75\degree
  \end{aligned}
  ```

- **Isolamos o fator da corrente**:
  ```math
    I = \frac{50 \angle 75\degree}{4 - j10}
  ```

- **Transformamos para Forma Polar**
  
  Transformamos o denominador para a forma polar:
  ```math
    I = \frac{50 \angle 75\degree}{10.77\angle -68.2\degree}
  ```
    + Efetuamos a divisão de fasores:
        
  ```math
    4.642 \angle 143.2\degree
  ```
- **Resultado no Domínio do Tempo**

```math
	i(t) = 4.642 \cos(2t + 143.2\degree)
```
"""

# ╔═╡ 7ea14af2-b75d-46ad-a1ea-de159eb01267
let
	# Definição dos parâmetros
    ω = 2
    # cis(θ) = e^(jθ), cria um número complexo na forma polar.
    V = 50 * cis(deg2rad(75)) 
    # Denominador (impledância equivalente).
    z = 4 - 10im

    # Corrente fasorial
    I = round(V / z, digits=3)

    @info "Corrente fasorial I = $I"

    # Módulo e fase. Para forma polar.
    rᵢ = round(abs(I), digits=3)
    ϕᵢ = round(rad2deg(angle(I)), digits=3)

    @info "Raio: $rᵢ, Fase: $ϕᵢ"
end

# ╔═╡ b201ae0a-908a-4850-a410-fbee4283bdfc
md"""
### Problema Prático 9.7
Determine a tensão $v(t)$ em um circuito descrito pela equação a seguir:

```math
    2\frac{dv}{dt} + 5v + 10 \int{v \cdot dt} = 50 \cos(5t - 30\degree)
```

- **Solução:** Transformar o lado direito da equação para o **domínio dos fasores**
  
- ``v(t) = V``
- ``\frac{dv}{dt} = j\omega V``
- ``\int{vdt} = \frac{V}{j\omega}``

Como nosso ``\omega = 5``:

```math
\begin{aligned}
    2 \cdot j\omega V + 5V + \frac{10V}{j\omega} = 50 \cos(5t - 30\degree) \\
    2j5V + 5V + \frac{10V}{j5} = 50 \cos(5t - 30\degree) \\
    2j5V + 5V - j2V =  50 \cos(5t - 30\degree) \\
    j10V + 5V - j2V =  50 \cos(5t - 30\degree) \\
    j8V + 5V = 50 \cos(5t - 30\degree) \\
    V(5 + j8) = 50 \cos(5t - 30\degree) \\
\end{aligned}
```

- Convertemos as equações para a forma polar e depois para senoide.
```math
\begin{aligned}
     V(5 + j8) &= 50 \angle -30\degree \\
     V &= \frac{50 \angle -30\degree}{5 + j8} \\
     V &= \frac{50 \angle -30\degree}{9.434 \angle 57.995}\degree \\
     V &= 5.299 \angle -87.995\degree \\
     V &= 5.3 \cos(5t - 87.995\degree)
\end{aligned}
```
"""

# ╔═╡ 3594a1bf-efc3-4431-aae6-002d0c84f235
md"""
### Relações entre Fasores para Elementos de Circuitos

Agora que sabemos como representar tensão e corrente no domínio da frequência, precisamos aplicar esse conceito a circuitos contendo elementos passivos *R*, *L* e *C*. Para isso, precisamos transformar a relação tensão-corrente do domínio do tempo para o domínio da frequência em cada um dos elementos.

Comecemos pelo resistor. Se a corrente através de um resistor ``R`` for ``i = I_m cos(\omega t + \phi)``, a tensão nele será dada pela **Lei de Ohm**, como segue

```math
v = iR = RI_m\cos(\omega t + \phi)
```

Na forma de fasores, essa tensão é

```math
V = RI_m\angle \phi
```

Porém, a representação fasorial da corrente é ``I = I_m \angle \phi``. Logo

```math
V = RI
```

Para o resistor, a corrente e a tensão estão **em fase**.

mostrando que a relação tensão-corrente para o resistor no domínio da frequência continua ser a lei de Ohm, como acontece no domínio do tempo.

Para o indutor ``L``, suponha que a corrente através dele seja ``i = I_m \cos(\omega t + \phi)``.

A tensão no indutor é
```math
v = L \frac{di}{dt} = - \omega LI_m \sin(\omega t + \phi)
```

Sabemos que ``-sin(A)=\cos(A + 90\degree)``, podemos escrever a tensão como

```math
v = \omega LI_m \cos(\omega t + \phi + 90\degree)
```
que pode ser transformada no fasor

```math
\begin{aligned}
V = \omega LI_m e^{j(\phi + 90\degree)} &= \omega LI_m e^{j\phi} e^{j90\degree} \\
&= \omega LI_m \angle \phi + 90\degree
\end{aligned}
```

Porém, ``I_m\angle \phi=I``. Logo

```math
V = j\omega LI
```
"""

# ╔═╡ 84de9a21-9cf9-4761-af75-b79da2d02922
md"""
revelando que a tensão tem magnitude igual a ``\omega LI_m`` e fase ``\phi + 90\degree``. A tensão e corrente estão a 90° fora de fase. A corrente está atrasada em 90°.

Para o capacitor ``C``, suponha que a tensão nele seja ``v = V_m \cos(\omega t + \phi)``. A corrente através de capacitor é

```math
i = C \frac{dv}{dt}
```

Seguindo as mesmas etapas do caso do indutor, obtemos

```math
I = j\omega CV \rightarrow V=\frac{I}{j\omega C}
```

demonstrando que corrente e tensão estão 90° fora de fase. Neste caso, a corrente está adiantada em 90° em relação a tensão.
A tabela abaixo sintetiza as representações dos elementos de circuitos nos domínios do tempo e da frequência.

| Elemento | Domínio do Tempo | Domínio da Frequência|
| :--- | :---: | ---: |
| ``R`` | ``v = Ri`` |  ``V = RI`` |
| ``L`` | ``v = L\frac{di}{dt}`` | ``V=j\omega LI`` |
| ``C`` | ``i = C\frac{dv}{dt}`` | ``V= \frac{I}{j\omega C}`` |
"""



# ╔═╡ 07123b9b-6b73-4af0-ba9c-b9cf9a62e3ad
md"""
### Exemplo 9.8
A tensão ``v = 12 \cos(60t + 45\degree)`` é aplicada a um indutor de ``0.1H``. Determine a corrente em regime estacionário através do indutor.

**Solução:** Para o indutor, ``V = j\omega LI``, onde ``\omega = 60`` rad/s e ``V = 12 \angle 45\degree V``. Portanto,

```math
I = \frac{V}{j\omega L} = \frac{12 \angle 45\degree}{j60 \cdot 0.1} = \frac{12 \angle 45\degree}{6 \angle 90\degree} = 2 \angle -45\degree A
```

### Problema Prático 9.8
Se a tensão ``v = 10 \cos(100t + 30\degree)`` for aplicada a um capacitor de ``50 \mu F``, calcule a corrente através do capacitor.

**Solução:** A tensão no capacitor é ``V = \frac{I}{j\omega C}``, logo a corrente

```math
I = j\omega C \cdot V = j100 \cdot 50*10^{-6} \cdot 10\angle 30\degree
```

A partir daqui **podemos usar uma calculadora** ou, **linguagem Julia**, já que sabemos todas as regras para calcular números complexos tanto na forma retangular como polar.
"""

# ╔═╡ a89d721b-a403-40fa-b50a-29133cafbaff
md"""
## Recursos
Mude a propriedade das células para visível, para ver o código fonte Julia.
"""

# ╔═╡ d19de826-6dd7-400e-a8fd-8864d5b710aa
begin
	TableOfContents()
end

# ╔═╡ 3d9a7c6f-ba53-48a8-994d-958af0fa98ae
begin
	# Converte de polar para retangular
	function polar2rect(r::Float64, θ::Float64)
		return r * exp(im * θ)
	end

	# Converte de retangular para polar
	function rect2polar(z::Complex{Float64})
		r = abs(z)
		θ = angle(z)
		return (r, θ)
	end
	nothing
end

# ╔═╡ e85eebc2-d82b-44ad-9105-fc8b6a13da4f
let
	r₁ = 10.0
	ϕ₁ = deg2rad(60.0)
	z₁ = polar2rect(r₁, ϕ₁)

	r₂ = 20.0
	ϕ₂ = deg2rad(45)
	z₂ = polar2rect(r₂, ϕ₂)

	result = z₁ + z₂
	presult = rect2polar(result)

	markd ="""
	- Resultado
	``v = $(round(presult[1]))\\cos(\\omega t + $(round(rad2deg(presult[2]))))V``
	"""
	Markdown.parse(markd)
end

# ╔═╡ 2c9c7175-5326-4882-b376-ef85aa8d860e
let
	z₁ = round(100im*50e-6, digits=5)
	z₂ = round(polar2rect(10.0, deg2rad(30)), digits=5)
	I = z₁ * z₂
	r, θ = rect2polar(I)
	
	md"""
	O resultado é **r: $(round(r, digits=3)), θ: $(round(θ, digits=3))** na forma
	de fasor, e **0.05 cos(100t + 2.095)V** na forma de senoide.
	"""
end

# ╔═╡ bf03cc83-eff5-4263-9e3a-3a9aa5a1b628
md"""
## Bibliografia
Fundamentos de Circuitos Elétricos, ``5^a`` Edição
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CairoMakie = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CairoMakie = "~0.15.8"
LaTeXStrings = "~1.4.0"
PlutoUI = "~0.7.66"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.4"
manifest_format = "2.0"
project_hash = "d3c2be656d04e5631b14d3c9069f85db1481d74a"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "7e35fca2bdfba44d797c53dfe63a51fabf39bfc0"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.4.0"
weakdeps = ["SparseArrays", "StaticArrays"]

    [deps.Adapt.extensions]
    AdaptSparseArraysExt = "SparseArrays"
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AdaptivePredicates]]
git-tree-sha1 = "7e651ea8d262d2d74ce75fdf47c4d63c07dba7a6"
uuid = "35492f91-a3bd-45ad-95db-fcad7dcfedb7"
version = "1.2.0"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e092fa223bf66a3c41f9c022bd074d916dc303e7"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Automa]]
deps = ["PrecompileTools", "SIMD", "TranscodingStreams"]
git-tree-sha1 = "a8f503e8e1a5f583fbef15a8440c8c7e32185df2"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "1.1.0"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "4126b08903b777c88edf1754288144a0492c05ad"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.8"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BaseDirs]]
git-tree-sha1 = "bca794632b8a9bbe159d56bf9e31c422671b35e0"
uuid = "18cc8868-cbac-4acf-b575-c8ff214dc66f"
version = "1.3.2"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.CRC32c]]
uuid = "8bf52ea8-c179-5cab-976a-9e18b702a9bc"
version = "1.11.0"

[[deps.CRlibm]]
deps = ["CRlibm_jll"]
git-tree-sha1 = "66188d9d103b92b6cd705214242e27f5737a1e5e"
uuid = "96374032-68de-5a5b-8d9e-752f78720389"
version = "1.0.2"

[[deps.CRlibm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e329286945d0cfc04456972ea732551869af1cfc"
uuid = "4e9b3aee-d8a1-5a3d-ad8b-7d824db253f0"
version = "1.0.1+0"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "71aa551c5c33f1a4415867fe06b7844faadb0ae9"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.1.1"

[[deps.CairoMakie]]
deps = ["CRC32c", "Cairo", "Cairo_jll", "Colors", "FileIO", "FreeType", "GeometryBasics", "LinearAlgebra", "Makie", "PrecompileTools"]
git-tree-sha1 = "5017d6849aff775febd36049f7d926a5fb6677ec"
uuid = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
version = "0.15.8"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "fde3bf89aead2e723284a8ff9cdf5b551ed700e8"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+0"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e4c6a16e77171a5f5e25e9646617ab1c276c5607"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.26.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON"]
git-tree-sha1 = "07da79661b919001e6863b81fc572497daa58349"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b0fd3f56fa442f81e0a47815c92245acfaaa4e34"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.31.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "8b3b6f87ce8f65a2b4f857528fd8d70086cd72b1"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ComputePipeline]]
deps = ["Observables", "Preferences"]
git-tree-sha1 = "76dab592fa553e378f9dd8adea16fe2591aa3daa"
uuid = "95dc2771-c249-4cd0-9c9f-1f3b4330693c"
version = "0.1.6"

[[deps.ConstructionBase]]
git-tree-sha1 = "b4b092499347b18a015186eae3042f72267106cb"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.0"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "e357641bb3e0638d353c4b29ea0e40ea644066a6"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.3"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DelaunayTriangulation]]
deps = ["AdaptivePredicates", "EnumX", "ExactPredicates", "Random"]
git-tree-sha1 = "c55f5a9fd67bdbc8e089b5a3111fe4292986a8e8"
uuid = "927a84f5-c5f4-47a5-9785-b46e178433df"
version = "1.6.6"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "fbcc7610f6d8348428f722ecbe0e6cfe22e672c6"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.123"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EnumX]]
git-tree-sha1 = "bddad79635af6aec424f53ed8aad5d7555dc6f00"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.5"

[[deps.ExactPredicates]]
deps = ["IntervalArithmetic", "Random", "StaticArrays"]
git-tree-sha1 = "83231673ea4d3d6008ac74dc5079e77ab2209d8f"
uuid = "429591f6-91af-11e9-00e2-59fbe8cec110"
version = "2.2.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "27af30de8b5445644e8ffe3bcb0d72049c089cf1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.3+0"

[[deps.Extents]]
git-tree-sha1 = "b309b36a9e02fe7be71270dd8c0fd873625332b4"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.6"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "01ba9d15e9eae375dc1eb9589df76b3572acd3f2"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.0.1+0"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "Libdl", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "97f08406df914023af55ade2f843c39e99c5d969"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.10.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d6219a004b8cf1e0b4dbe27a2860b8e04eba0be"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.11+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "d60eb76f37d7e5a40cc2e7c36974d864b82dc802"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.1"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[[deps.FilePaths]]
deps = ["FilePathsBase", "MacroTools", "Reexport"]
git-tree-sha1 = "a1b2fbfe98503f15b665ed45b3d149e5d8895e4c"
uuid = "8fc22ac5-c921-52a6-82fd-178b2807b824"
version = "0.9.0"

    [deps.FilePaths.extensions]
    FilePathsGlobExt = "Glob"
    FilePathsURIParserExt = "URIParser"
    FilePathsURIsExt = "URIs"

    [deps.FilePaths.weakdeps]
    Glob = "c27321d9-0574-5035-807b-f59d2c89b15c"
    URIParser = "30578b45-9adc-5946-b283-645ec420af67"
    URIs = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "3bab2c5aa25e7840a4b065805c0cdfc01f3068d2"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.24"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "5bfcd42851cf2f1b303f51525a54dc5e98d408a3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.15.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["BaseDirs", "ColorVectorSpace", "Colors", "FreeType", "GeometryBasics", "Mmap"]
git-tree-sha1 = "4ebb930ef4a43817991ba35db6317a05e59abd11"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.8"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "IterTools", "LinearAlgebra", "PrecompileTools", "Random", "StaticArrays"]
git-tree-sha1 = "1f5a80f4ed9f5a4aada88fc2db456e637676414b"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.5.10"

    [deps.GeometryBasics.extensions]
    GeometryBasicsGeoInterfaceExt = "GeoInterface"

    [deps.GeometryBasics.weakdeps]
    GeoInterface = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Giflib_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6570366d757b50fabae9f4315ad74d2e40c0560a"
uuid = "59f7168a-df46-5410-90c8-f2779963d0ec"
version = "5.2.3+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "6b4d2dc81736fe3980ff0e8879a9fc7c33c44ddf"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.2+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "93d5c27c8de51687a2c70ec0716e6e76f298416f"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.11.2"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "e12629406c6c4442539436581041d372d69c55ba"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.12"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "eb49b82c172811fd2c86759fa0553a2221feb909"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.7"

[[deps.ImageCore]]
deps = ["ColorVectorSpace", "Colors", "FixedPointNumbers", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "PrecompileTools", "Reexport"]
git-tree-sha1 = "8c193230235bbcee22c8066b0374f63b5683c2d3"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.10.5"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs", "WebP"]
git-tree-sha1 = "696144904b76e1ca433b886b4e7edd067d76cbf7"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.9"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "2a81c3897be6fbcde0802a0ebe6796d0562f63ec"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.10"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dcc8d0cd653e55213df9b75ebc6fe4a8d3254c65"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.2.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "ec1debd61c300961f98064cfb21287613ad7f303"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2025.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "65d505fa4c0d7072990d659ef3fc086eb6da8208"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.16.2"

    [deps.Interpolations.extensions]
    InterpolationsForwardDiffExt = "ForwardDiff"
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalArithmetic]]
deps = ["CRlibm", "MacroTools", "OpenBLASConsistentFPCSR_jll", "Printf", "Random", "RoundingEmulator"]
git-tree-sha1 = "02b61501dbe6da3b927cc25dacd7ce32390ee970"
uuid = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
version = "1.0.2"

    [deps.IntervalArithmetic.extensions]
    IntervalArithmeticArblibExt = "Arblib"
    IntervalArithmeticDiffRulesExt = "DiffRules"
    IntervalArithmeticForwardDiffExt = "ForwardDiff"
    IntervalArithmeticIntervalSetsExt = "IntervalSets"
    IntervalArithmeticLinearAlgebraExt = "LinearAlgebra"
    IntervalArithmeticRecipesBaseExt = "RecipesBase"
    IntervalArithmeticSparseArraysExt = "SparseArrays"

    [deps.IntervalArithmetic.weakdeps]
    Arblib = "fb37089c-8514-4489-9461-98f9c8763369"
    DiffRules = "b552c78f-8df3-52c6-915a-8e097449b14b"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.IntervalSets]]
git-tree-sha1 = "d966f85b3b7a8e49d034d27a189e9a4874b4391a"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.13"

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

    [deps.IntervalSets.weakdeps]
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.IrrationalConstants]]
git-tree-sha1 = "b2d91fe939cae05960e760110b328288867b5758"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.6"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "9496de8fb52c224a2e3f9ff403947674517317d9"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.6"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6893345fd6658c8e475d40155789f4860ac3b21"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.4+0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "ba51324b894edaf1df3ab16e2cc6bc3280a2f1a7"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.10"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3acf07f130a76f87c041cfb2ff7d7284ca67b072"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.2+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2a7a12fc0a4e7fb773450d17975322aa77142106"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.2+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "282cadc186e7b2ae0eeadbd7a4dffed4196ae2aa"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2025.2.0+0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Makie]]
deps = ["Animations", "Base64", "CRC32c", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "ComputePipeline", "Contour", "Dates", "DelaunayTriangulation", "Distributions", "DocStringExtensions", "Downloads", "FFMPEG_jll", "FileIO", "FilePaths", "FixedPointNumbers", "Format", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageBase", "ImageIO", "InteractiveUtils", "Interpolations", "IntervalSets", "InverseFunctions", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MacroTools", "Markdown", "MathTeXEngine", "Observables", "OffsetArrays", "PNGFiles", "Packing", "Pkg", "PlotUtils", "PolygonOps", "PrecompileTools", "Printf", "REPL", "Random", "RelocatableFolders", "Scratch", "ShaderAbstractions", "Showoff", "SignedDistanceFields", "SparseArrays", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "TriplotBase", "UnicodeFun", "Unitful"]
git-tree-sha1 = "d1b974f376c24dad02c873e951c5cd4e351cd7c2"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.24.8"

    [deps.Makie.extensions]
    MakieDynamicQuantitiesExt = "DynamicQuantities"

    [deps.Makie.weakdeps]
    DynamicQuantities = "06fc5a27-2a28-4c7c-a15d-362465fb6821"

[[deps.MappedArrays]]
git-tree-sha1 = "0ee4497a4e80dbd29c058fcee6493f5219556f40"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.3"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "UnicodeFun"]
git-tree-sha1 = "7eb8cdaa6f0e8081616367c10b31b9d9b34bb02a"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.6.7"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
git-tree-sha1 = "117432e406b5c023f665fa73dc26e79ec3630151"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.17.0"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLASConsistentFPCSR_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "567515ca155d0020a45b05175449b499c63e7015"
uuid = "6cdc7f73-28fd-5e50-80fb-958a8875b1af"
version = "0.3.29+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "df9b7c88c2e7a2e77146223c526bf9e236d5f450"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.4.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "39a11854f0cba27aa41efaedf43c77c5daa6be51"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.0+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.44.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "e4cff168707d441cd6bf3ff7e4832bdf34278e4a"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.37"
weakdeps = ["StatsBase"]

    [deps.PDMats.extensions]
    StatsBaseExt = "StatsBase"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "cf181f0b1e6a18dfeb0ee8acc4a9d1672499626c"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.4"

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "bc5bf2ea3d5351edf285a06b0016788a121ce92c"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.5.1"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0662b083e11420952f2e62e17eddae7fc07d5997"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.57.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "26ca162858917496748aad52bb5d3be4d26a228a"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.4"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2b2127e64c1221b8204afe4eb71662b641f33b82"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.66"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "522f093a29b31a93e34eaea17ba055d850edea28"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "fbb92c6c56b34e1a2c4c36058f68f332bec840e7"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "472daaa816895cb7aee81658d4e7aec901fa1106"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "5b3d50eb374cea306873b371d3f8d3915a018f0b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.9.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RoundingEmulator]]
git-tree-sha1 = "40b9edad2e5287e05bd413a38f61a8ff55b9557b"
uuid = "5eaf0fd0-dfba-4ccb-bf02-d820a40db705"
version = "0.2.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "e24dc23107d426a096d3eae6c165b921e74c18e4"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.2"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.ShaderAbstractions]]
deps = ["ColorTypes", "FixedPointNumbers", "GeometryBasics", "LinearAlgebra", "Observables", "StaticArrays"]
git-tree-sha1 = "818554664a2e01fc3784becb2eb3a82326a604b6"
uuid = "65257c39-d410-5151-9873-9b3e5be5013e"
version = "0.5.0"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Statistics"]
git-tree-sha1 = "3949ad92e1c9d2ff0cd4a1317d5ecbba682f4b92"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.1"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "be8eeac05ec97d379347584fa9fe2f5f76795bcb"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.5"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "0494aed9501e7fb65daba895fb7fd57cc38bc743"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.5"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "64d974c2e6fdf07f8155b5b2ca2ffa9069b608d9"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.2"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.12.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f2685b435df2613e25fc10ad8c26dddb8640f547"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.6.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "4f96c596b8c8258cc7d3b19797854d368f243ddc"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.4"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "be1cf4eb0ac528d96f5115b4ed80c26a8d8ae621"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.2"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "eee1b9ad8b29ef0d936e3ec9838c7ec089620308"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.16"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6ab403037779dae8c514bad259f32a447262455a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "be5733d4a2b03341bdcab91cea6caa7e31ced14b"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.9"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "91f091a8716a6bb38417a6e6f274602a19aaa685"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.5.2"
weakdeps = ["ChainRulesCore", "InverseFunctions"]

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "a2c37d815bf00575332b7bd0389f771cb7987214"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.7.2"

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = ["GPUArraysCore", "KernelAbstractions"]
    StructArraysLinearAlgebraExt = "LinearAlgebra"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

    [deps.StructArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.8.3+2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "f2c1efbc8f3a609aadf318094f8fc5204bdaf344"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "PrecompileTools", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "98b9352a24cb6a2066f9ababcc6802de9aed8ad8"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.11.6"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.TriplotBase]]
git-tree-sha1 = "4d4ed7f294cda19382ff7de4c137d24d16adc89b"
uuid = "981d1d27-644d-49a2-9326-4793e63143c3"
version = "0.1.0"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "c25751629f5baaa27fef307f96536db62e1d754e"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.27.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    ForwardDiffExt = "ForwardDiff"
    InverseFunctionsUnitfulExt = "InverseFunctions"
    LatexifyExt = ["Latexify", "LaTeXStrings"]
    NaNMathExt = "NaNMath"
    PrintfExt = "Printf"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"
    LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
    Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
    NaNMath = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
    Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.WebP]]
deps = ["CEnum", "ColorTypes", "FileIO", "FixedPointNumbers", "ImageCore", "libwebp_jll"]
git-tree-sha1 = "aa1ca3c47f119fbdae8770c29820e5e6119b83f2"
uuid = "e3aaa7dc-3e4b-44e0-be63-ffb868ccd7c1"
version = "0.1.3"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9cce64c0fdd1960b597ba7ecda2950b5ed957438"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.2+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "b5899b25d17bf1889d25906fb9deed5da0c15b3b"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.12+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a4c0ee07ad36bf8bbce1c3bb52d21fb1e0b987fb"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.7+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "de8ab4f01cb2d8b41702bab9eaad9e8b7d352f73"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.53+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "libpng_jll"]
git-tree-sha1 = "c1733e347283df07689d71d61e14be986e49e47a"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.5+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.libwebp_jll]]
deps = ["Artifacts", "Giflib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Libtiff_jll", "libpng_jll"]
git-tree-sha1 = "4e4282c4d846e11dce56d74fa8040130b7a95cb3"
uuid = "c5f90fcd-3b7e-5836-afba-fc50a0988cb2"
version = "1.6.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "1350188a69a6e46f799d3945beef36435ed7262f"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2022.0.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"
"""

# ╔═╡ Cell order:
# ╟─ec48964c-ebc3-11f0-8691-9b760cc0aa0e
# ╟─eeee2496-16a3-4e9a-8b64-4df4999afd9c
# ╟─195bf467-d56d-4df6-bbc0-68dcbd175d33
# ╟─da16197d-656a-4c91-9ed0-eddbcb6088ff
# ╟─aa4418f3-0711-48f7-a322-9115e69255f1
# ╟─f9ec4b5f-4384-4179-91a8-231d7c6902d0
# ╟─061c5606-ee63-432c-9bfb-1ff93613f52d
# ╟─1098a831-13fc-4819-a80c-9e65fce964de
# ╟─11cd3feb-92b1-4ca0-a619-4a37234439bf
# ╟─81bab0c6-1333-42ec-b086-91cbd9e7a2c3
# ╟─97c91ba9-6c00-4645-ac36-c5a9aabd4336
# ╟─225fc9f9-a16a-4a58-94c4-55166e04a55c
# ╟─618601bf-3032-4350-97e5-2be66c6c13e7
# ╟─eb2f8fb3-ac62-497e-9df9-5dccbc04170f
# ╟─56cc696a-8e30-4d09-aa60-757be528992e
# ╟─408def6c-444a-42ba-8d37-c1355c84adb0
# ╟─261c1203-8569-4a1b-ada7-ed8731732341
# ╟─26c360d8-5819-4a11-bf34-475e47102ffc
# ╟─cd6717b3-e739-403a-a496-e1360e2bcc06
# ╟─ae846e01-0992-4f63-84e9-aa9c986fe4b2
# ╟─e86b97fc-079d-46df-9ab0-0e1cd92b19bd
# ╟─8e760db2-e38b-4e19-9341-fafffb86a38f
# ╟─a1829730-7c0f-4055-8b76-2de2c1561fbc
# ╟─999fc068-76cd-4a56-8e3a-94437672b61b
# ╟─323a34d9-2961-43e8-a581-7d2e2ce56d46
# ╟─140641ec-d75a-4a9c-947b-d67084a86fcd
# ╟─c249754d-e492-42fc-90f4-042fd48f94d8
# ╟─62e37237-38c5-4234-a8e8-6e86aa591894
# ╟─53a78ee2-21e8-4971-b938-9a317e9a4cd3
# ╟─5b76deb6-4d77-45de-b192-2511661d079f
# ╟─669fda38-8aef-4e4e-b51a-f5dfc5bfb5f8
# ╟─0dc9c342-4b78-4629-a9ae-2188604226cf
# ╟─4516e2ae-6021-4b86-b0ab-f75d1f970b1f
# ╟─e85eebc2-d82b-44ad-9105-fc8b6a13da4f
# ╟─49cd52de-8495-4570-b022-804f76b387e3
# ╟─7ea14af2-b75d-46ad-a1ea-de159eb01267
# ╟─b201ae0a-908a-4850-a410-fbee4283bdfc
# ╟─3594a1bf-efc3-4431-aae6-002d0c84f235
# ╟─84de9a21-9cf9-4761-af75-b79da2d02922
# ╟─07123b9b-6b73-4af0-ba9c-b9cf9a62e3ad
# ╟─2c9c7175-5326-4882-b376-ef85aa8d860e
# ╟─a89d721b-a403-40fa-b50a-29133cafbaff
# ╟─9adef71e-de60-4794-b721-c2ea7c128aab
# ╟─d19de826-6dd7-400e-a8fd-8864d5b710aa
# ╟─3d9a7c6f-ba53-48a8-994d-958af0fa98ae
# ╟─bf03cc83-eff5-4263-9e3a-3a9aa5a1b628
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
