### A Pluto.jl notebook ###
# v0.20.21

#> custom_attrs = ["hide-enabled"]

using Markdown
using InteractiveUtils

# ╔═╡ 66ce0fd3-11f4-425e-a9b7-69c7d348f6a6
using SymPy, PlutoUI, Printf

# ╔═╡ 33e236ec-1b11-4fc3-bf6f-d3082906d4c6
TableOfContents()

# ╔═╡ 84a881a0-5802-11f0-327b-e55b1f5cd21e
md"""
# Exemplos e Problemas Práticos do Capítulo 6 - Indutores
## Fundamentos de Circuitos Elétricos 5th Edição - Sadiku
### Exemplo 6.8
A corrente que passa por um indutor de $0.1 H$ é $i(t)=10te^{-5t} A$. Calcule a tensão no indutor e a energia armazenada nele.

Lembrando:
```math
	v = L \cdot \frac{di}{dt}
```
```math
	w = \frac{1}{2} \cdot Li^2
```
"""

# ╔═╡ 8dc5eaa1-f635-4a48-886d-e20fbbe84dd4
let
	# Define variaveis
	@syms L i w v t
	iexpression = 10t*exp(-5t)
	vexpression = v ~ L*diff(iexpression, t)
	wexpression = w ~ (1/2)L*i^2

	vexpression = first(solve(subs(vexpression, L=>0.1), v))
	@printf("A tensão no indutor é %s V.\n", vexpression)
	wresult = first(solve(subs(wexpression, L=>0.1, i=>iexpression), w))
	@printf("A energia no armazenada é %s J.\n", wresult)
end

# ╔═╡ d09f83aa-4dda-48d7-a10a-645f6364b859
md"""
### Problema Prático 6.8
Se a corrente através de um indutor de $1 mH$ for $i(t) = 60 cos 100t mA$, determine a tensão nos terminais e a energia armazenada.
"""

# ╔═╡ d3d4c3f6-ccbc-4364-883a-41ee0745a340
let
	# Define variáveis e expressões
	@syms t L v w i
	
	iexpression = 60cos(100t) * 10^-3 # Em milli amperes.
	vexpression = v ~ L*diff(iexpression, t)
	wexpression = w ~ (1/2)L*i^2

	vresult = first(solve(subs(vexpression, L=>1e-3), v))
	# Saída em V.
	@info vresult
	wresult = first(solve(subs(wexpression, i=>iexpression, L=>1e-3), w))
	# Saída em μJ.
	@info wresult
	
end

# ╔═╡ ec53321d-aa44-42c2-8946-957d17258b53
md"""
### Exemplo 6.9
Determine a corrente através de um indutor de $5H$ se a tensão nele for 
```math
v(t) = 
\begin{cases}
30t^2 & \text{se } t > 0 \\
0 & \text{se } t < 0
\end{cases}
```

Determine também a energia armazenada no instante $t = 5s$. Suponha que $i(t) > 0$.

Uma vez que $i$:
```math
\begin{aligned}
i(t) &= \frac{1}{L} \int_{t_0}^{t} v(t)dt + i(t_0) \\
p &= v \cdot i \\
w &= \int p \cdot dt
\end{aligned}
```
"""

# ╔═╡ 99177dcc-afec-46ce-b7c0-bab829e7e62b
let
	# Define variaveis e expressões
	@syms t L
	v = sympy.Piecewise(
		(30t^2, Gt(t, 0)),
		(0, Lt(t, 0))
	)

	@info v
	# Calcula a corrente - Resposta em A
	iexpression = simplify(subs((1/L)*integrate(v, t), L=>5))
	# Calcula a potência
	presult = simplify(iexpression * v).args[2].args[1]
	# Calcula a energia - Resposta em kJ
	wresult = integrate(presult, (t, 0, 5))
	@info iexpression.args[2].args[1]
	@info sympy.Float(wresult, 5)
end

# ╔═╡ 6ad23a54-d25b-4300-b27e-9976142c2172
md"""
### Problema Prático 6.9
A tensão entre os terminais de um indutor de $2H$ é $v=10(1-t) V$. Determine a corrente que passa através dele no instante $t=4s$ e a energia armazenada nele no $t=4s$. Suponha $i(0)=2A$.

Detalhe importante. Alternativamente podemos obter a energia instantânea armazenada usando a equação abaixo:
```math
w \bigg|_0^t \frac{1}{2}Li^2(4) - \frac{1}{2}Li^2(0)

```
"""

# ╔═╡ 1caf01f8-b0e0-4d56-b894-c135625a05bb
let
	# Define variáveis e expressões.
	@syms L t i
	l1 = 2
	i0 = 2
	vexpression = 10(1 - t)
	# Calcula corrente - resposta em A.
	iexpression = (1/L)integrate(vexpression, (t, 0, 4)) + 2
	iresult = subs(iexpression, L=>l1)
	@info iresult # Resposta em amperes.

	# Calcula a potência
	presult = simplify(iresult * vexpression)
	# Calcula a energia no instante 4s. Resposta em jaules.
	wexpression = 0.5L*iresult^2 - 0.5*L*i^2
	wresult = subs(wexpression, L=>l1, i=>i0)
	@info wresult
end

# ╔═╡ bb821385-d193-430c-b6b0-7c81936a6c0f
md"""
### Exemplo 6.10

Considere o circuito da figura 6.27a. Em CC, determine:

a) $i, v_c$ e $i_L$.

b) A energia armazenada no indutor e no capacitor.

Lembre-se que as equações de energia para o capacitor e para o indutor são respectivamente:
```math
\begin{aligned}
w_C &= \frac{1}{2} \cdot Cv^2 \\
w_L &= \frac{1}{2} \cdot Li^2
\end{aligned}
```
"""

# ╔═╡ 72c971ed-02cd-44fa-8fba-8f8a3dffcb6c
let
	@syms C v L
	r1 = 1
	r2 = 5
	r3 = 4
	vcc = 12
	c1 = 1
	l1 = 2

	i = 12/(r1 + r2)

	il = i
	@printf("A corrente em i e iₗ são a mesma: %.2f A.\n", il)
	vc = i*r2
	@printf("A tensão vc é %.2f V.\n", vc)
	wexpression = (1/2)C*v^2
	wexpression1 = (1/2)L*i^2
	wresult1 = subs(wexpression, v=>vc, C=>c1)
	@printf("A energia armazenada no capacitor é %.f J.\n", wresult1)
	wresult1 = subs(wexpression1, i=>i, L=>l1)
	@printf("A energia armazenada no capacitor é %.f J.\n", wresult1)
end

# ╔═╡ a9d16619-4a50-4c1a-93cf-8272fb7224aa
md"""
### Problema Prático 6.10
Determine $vC$, $iL$ e a energia armazenada no capacitor e no indutor no circuito da figura 6.28 em CC.
"""

# ╔═╡ 2c8b0a78-eb25-4a33-a55b-c0dc319f45bc
let
	@syms C L v i r[1:2]
	icc = 10
	l1 = 6
	c1 = 4
	r1 = 6
	r2 = 2

	ildivisor = icc * (r[1]/sum(r))
	ilresult = sympy.Float(subs(ildivisor, r[1]=>r1, r[2]=>r2), 3)
	@printf("A corrente iₗ é %.3f A.\n", ilresult)
	vc = vr2 = ilresult * 2
	@printf("A tensão em vc é %.3f A.\n", vc)
	wcexpression = 0.5C*v^2
	wcresult = subs(wcexpression, C=>c1, v=>vc)
	@printf("A energia armazenada em c1 é %.3f A.\n", wcresult)
	wlexpression = 0.5L*i^2
	wlresult = subs(wlexpression, L=>l1, i=>ilresult)
	@printf("A energia armazenada em l1 é %.3f A.\n", wlresult)
end

# ╔═╡ a326969a-c301-4aba-b81d-bd91ff803d1d
md"""
## Indutores em Série e em Paralelo
### Exemplo 6.11
Determine a indutância equivalente do circuito mostrado na figura 6.31.
"""

# ╔═╡ f624a2a0-a619-49f4-8e0e-04f2dfa2f50b
let
	@syms l[1:6]
	l1 = 4
	l2 = 8
	l3 = 7
	l4 = 20
	l5 = 10
	l6 = 12

	series1 = l[4] + l[5] + l[6]
	s1result = subs(series1, l[4]=>l4, l[5]=>l5, l[6]=>l6)
	paralelo1 = (s1result * l[3]) / (s1result + l[3])
	p1result = subs(paralelo1, l[3]=>l3)
	series2 = l[1] + l[2] + p1result
	s2result = subs(series2, l[1]=>l1, l[2]=>l2)
	@printf("A indutância equivalente do circuito é %.2f H.", s2result)
end

# ╔═╡ 1209697a-f9a7-4ef6-94d5-147de29c483b
md"""
### Problema prático 6.11
Determine a indutância equivalente para o circuito indutivo em escada da figura 6.32.
"""

# ╔═╡ 59262384-fbba-4018-afe9-0b0f6ee2724f
let
	@syms l[1:7]
	l1 = 50e-3
	l2 = 40e-3
	l3 = 30e-3
	l4 = 20e-3
	l5 = 40e-3
	l6 = 100e-3
	l7 = 20e-3

	s1result = subs(l[4] + l[5], l[4]=>l4, l[5]=>l5)
	p1result = subs((s1result * l[3]) / (s1result + l[3]), l[3]=>l3)
	s2result = subs(p1result + l[6], l[6]=>l6)
	p2result = subs((s2result * l[2]) / (s2result + l[2]), l[2]=>l2)
	s3result = subs(p2result + l[7], l[7]=>l7)
	p4result = subs((s3result * l[1]) / (s3result + l[1]), l[1]=>l1)
	@printf("A indutância equivalente do circuito é %.3f H.", p4result)
end

# ╔═╡ 5df546b1-08ea-4d6b-8cef-b4917cb554c2
md"""
### Exemplo 6.12
Para o circuito da figura 6.33, $i(t)=4(2-e^{-10t})$ $mA$. Se $i_2(0) = -1$ $mA$, determine:

a) $i_1(0)$

b) $v(t)$, $v_1(t)$ e $v_2(t)$.

c) $i_1$ e $i_2(t)$.
"""

# ╔═╡ 6ee9d42c-56d8-4330-88ee-2ba30e3df39f
let
	@syms t i i1 i2 L
	l1 = 2
	l2 = 4
	l3 = 12
	iexpression = 4(2 - exp(-10t)) * 10^-3
	i2v = -1e-3
	i0v = sympy.Float(subs(iexpression, t=> 0))
	lkc = i ~ i1 + i2
	# Calcula i1.
	i1v = first(solve(subs(lkc, i=>i0v, i2=>i2v), i1))
	# Calcula a indutância equivalente.
	leq = ((l3 * l2)/(l3 + l2)) + l1

	# Calcula v.
	vt = L*diff(iexpression)
	v = subs(vt, L=>leq)
	@info v
	# Calcula v₁.
	v1 = subs(vt, L=>l1)
	@info v1
	v2 = v - v1
	@info v2

	# Está errado
	i1expression = (1/L)*integrate(v2, (t, 0, t)) + i1
	i1result = subs(i1expression, L=>l2, i1=>i1v)
	@info i1result
	i2expression = (1/L)*integrate(v2, (t, 0, t)) + i2
	i2result = subs(i2expression, L=>l3, i2=>i2v)
	@info i2result
	i2result + i1result
end

# ╔═╡ aebe643a-014e-44a8-9a73-4f2708b9a9a0
md"""
### Problema Prático 6.12
No circuito da figura 6.34, $i_1(t)=0,6e^{-2t}$ $A$. Se $i(0)=1m4$ $A$, determine:

a) $i_2(0)$ = $0.8A$.

b) $i_2(t)$ e $i(t)$ = $-0.4 + 1.2e^{-2t}$, $-0.4 + 1.8e^{-2t}$.

c) $v_1(t)$, $v_2(t)$ e $v(t)$= $-7.2e^{-2t}$, $-28.8e^{-2t}$ e $-36.0e^{-2t}$. 
"""

# ╔═╡ f1720d18-c6da-4aee-be14-4cbe1153d011
let
	l1 = 3
	l2 = 6
	l3 = 8
	leq = ((l1 * l2)/(l1 + l2)) + l3
	i₀ = 1.4
	@syms t L i i1 i2
	lkc = i ~ i1 + i2
	i₁t = 0.6*exp(-2t)
	i₁₀ = subs(i₁t, t=>0)
	@info i₁₀
	i₂₀ = first(solve(subs(lkc, i1=>i₁₀, i=>i₀)))
	@info i₂₀
	v₁t = L*diff(i₁t)
	v₁ = subs(v₁t, L=>l2)
	@info v₁
	i₂ₜ = simplify(subs((1/L)*integrate(v₁, (t, 0, t)) + i₂₀, L=>l1))
	@info i₂ₜ
	iₜ = i₁t + i₂ₜ
	@info iₜ
	v₂ = subs(L*diff(iₜ), L=>l3)
	@info v₂
	v = v₁ + v₂
	@info v
end

# ╔═╡ a5c22b09-1964-4bf7-baf9-5edc5b4de936
md"""
## Aplicações
### Exemplo 6.13
Se $v_1 = 10 cos 2t mV$ e $v_2 = 0.5t mV$, determine $v_0$ no circuito de amplificadores operacionais da figura 6.36. Suponha que a tensão no capacitor seja inicialmente zero.
"""

# ╔═╡ e86ec3eb-2f09-45fb-858e-9c7cb5122f6d
let
	@syms v[1:2] r[1:2] C t
	v₁ = 10cos(2t)*10^-3
	v₂ = 0.5t*10^-3

	vexpression₀ = ((-1/(r[1]*C)) * integrate(v₁) - (-1/(r[2]*C))*integrate(v₂))
	v₀ = subs(vexpression₀, r[1]=>3e6, r[2]=>100e3, C=>2e-6)
	@info v₀
end

# ╔═╡ 21b1241a-fe93-4ccc-9a16-71b818f0ebf7
md"""
### Problema Prático 6.13
O integrador da figura 6.35b tem $R = 100k \Omega$ e C = $20 \mu F$. Determine a tensão de saída quando uma tensão CC de $2.5 mV$ é aplicada no instante $t=0$. Suponha que o amplificador operacional esteja com o offset ajustado.

Lembre-se:
```math
\begin{aligned}
dv_0 &= - \frac{1}{RC} \cdot v_i(t)dt \\
v_0 &= -\frac{1}{RC} \cdot \int_{0}^{t} \cdot v_i(t)dt
\end{aligned}
```
"""

# ╔═╡ 2967944d-cdea-47b7-948f-d5e3fb611b41
let
	@syms t C R vi

	c = 20e-6
	r = 100e3
	vᵢₜ = 2.5e-3 # no instante t=0.

	vₒ = -1/(R*C)*integrate(vi, (t, 0, t))
	vₒ = subs(vₒ, R=> r, C=>c, vi=>vᵢₜ)
	@info vₒ
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
PlutoUI = "~0.7.66"
SymPy = "~2.3.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.3"
manifest_format = "2.0"
project_hash = "646a21e97f32159747e17cd1e70ca5e69e100aa1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CommonEq]]
git-tree-sha1 = "6b0f0354b8eb954cdba708fb262ef00ee7274468"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.1"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "b19db3927f0db4151cb86d073689f2428e524576"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.10.2"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DocStringExtensions]]
git-tree-sha1 = "7442a5dfe1ebb773c29cc2962a8980f47221d76c"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.5"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "4f34eaabe49ecb3fb0d58d6015e32fd31a733199"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.8"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

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

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

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

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "2b2127e64c1221b8204afe4eb71662b641f33b82"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.66"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "9816a3826b0ebf49ab4926e2b18842ad8b5c8f04"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.96.4"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "41852b8679f78c8d8961eeadc8f62cef861a52e3"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SymPy]]
deps = ["CommonEq", "CommonSolve", "LinearAlgebra", "PyCall", "SpecialFunctions", "SymPyCore"]
git-tree-sha1 = "d3c2de8adc6e36352d2a2dae3ae87099964fcbc0"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "2.3.3"

[[deps.SymPyCore]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "RecipesBase", "SpecialFunctions", "TermInterface"]
git-tree-sha1 = "504598903177dfb6a07921289e03eb442eb14fcd"
uuid = "458b697b-88f0-4a86-b56b-78b75cfb3531"
version = "0.3.2"

    [deps.SymPyCore.extensions]
    SymPyCoreSymbolicUtilsExt = "SymbolicUtils"

    [deps.SymPyCore.weakdeps]
    SymbolicUtils = "d1185830-fcd6-423d-90d6-eec64667417b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TermInterface]]
git-tree-sha1 = "d673e0aca9e46a2f63720201f55cc7b3e7169b16"
uuid = "8ea1fca8-c5ef-4a55-8b96-4e9afe9c9a3c"
version = "2.0.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

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

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╠═66ce0fd3-11f4-425e-a9b7-69c7d348f6a6
# ╠═33e236ec-1b11-4fc3-bf6f-d3082906d4c6
# ╟─84a881a0-5802-11f0-327b-e55b1f5cd21e
# ╠═8dc5eaa1-f635-4a48-886d-e20fbbe84dd4
# ╟─d09f83aa-4dda-48d7-a10a-645f6364b859
# ╠═d3d4c3f6-ccbc-4364-883a-41ee0745a340
# ╟─ec53321d-aa44-42c2-8946-957d17258b53
# ╠═99177dcc-afec-46ce-b7c0-bab829e7e62b
# ╟─6ad23a54-d25b-4300-b27e-9976142c2172
# ╠═1caf01f8-b0e0-4d56-b894-c135625a05bb
# ╟─bb821385-d193-430c-b6b0-7c81936a6c0f
# ╠═72c971ed-02cd-44fa-8fba-8f8a3dffcb6c
# ╟─a9d16619-4a50-4c1a-93cf-8272fb7224aa
# ╠═2c8b0a78-eb25-4a33-a55b-c0dc319f45bc
# ╟─a326969a-c301-4aba-b81d-bd91ff803d1d
# ╠═f624a2a0-a619-49f4-8e0e-04f2dfa2f50b
# ╟─1209697a-f9a7-4ef6-94d5-147de29c483b
# ╠═59262384-fbba-4018-afe9-0b0f6ee2724f
# ╟─5df546b1-08ea-4d6b-8cef-b4917cb554c2
# ╠═6ee9d42c-56d8-4330-88ee-2ba30e3df39f
# ╟─aebe643a-014e-44a8-9a73-4f2708b9a9a0
# ╠═f1720d18-c6da-4aee-be14-4cbe1153d011
# ╟─a5c22b09-1964-4bf7-baf9-5edc5b4de936
# ╠═e86ec3eb-2f09-45fb-858e-9c7cb5122f6d
# ╟─21b1241a-fe93-4ccc-9a16-71b818f0ebf7
# ╠═2967944d-cdea-47b7-948f-d5e3fb611b41
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
