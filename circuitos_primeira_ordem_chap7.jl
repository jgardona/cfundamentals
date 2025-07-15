### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ 4acf9170-095a-4b91-a213-97fd282d374c
using SymPy, Latexify, LaTeXStrings, Markdown, PlutoUI

# ╔═╡ 7a0a00c7-ca82-49bb-b031-67a079f19049
md"""
# Capítulo 7 - Circuitos de Primeira Ordem
### Fundamentos de Circuitos Elétricos
## Circuitos RC sem Fonte
O segredo para se trabalhar com um circuito RC sem fonte é encontrar:

- A tensão inicial $v(0)=Vₒ$ no capacitor.
- A constante de tempo $\tau$.
"""

# ╔═╡ 92a1800f-8efc-4386-a37f-9981c9c7b2a1
begin
	function parallel(r::Number...)::Number
		req = sum(1/i for i in r)
		1/req
	end
	@syms τ R C V₀ t
	τ = R*C
	vₜ = V₀*exp(-t/τ)
	TableOfContents()
end

# ╔═╡ a7d047dc-2dd3-4a28-bde2-1dd11c6a7808
md"""
* **Equações Importantes**:

```math
\begin{aligned}
\tau &= R \cdot C \\
v_t &= v_t(0)e^{-t/\tau} \\
w_c &= \frac{1}{2} \cdot Cv_c^2
\end{aligned}
```

- ** O segredo para se trabalhar
"""

# ╔═╡ 0533914a-0a1a-4fff-8073-7894486872ad
md"""
### Exemplo 7.1
Na figura 7.5, façamos $v_c(0)=15V$. Determine $v_c$, $v_x$ e $i_x$ para $t \gt 0$.
"""

# ╔═╡ 42bda48c-2693-47cd-931b-ec5652e4ec41
let
	# Primeiro precisamos adequar o circuito ao RC padrão. Determinamos a resistência equivalente ou a resistência de Thevenin nos terminais do capacitor. Nosso objetivo é sempre conseguir em primeiro lugar, a tensão v_c no capacitor.
	r1 = 5
	r2 = 8
	r3 = 12
	c = 0.1
	v0 = 15

	# Calcula resistência de Thevenin.
	req = parallel(r2 + r3, r1)

	# Calcula τ.
	tau = subs(τ, C=>c, R=>req)

	# Calcula v_c.
	vc = subs(vₜ, V₀=>15, τ=>tau)

	# Calcula vₓ
	vₓ = (r3/(r3+r2)) * vc

	# Calcula iₓ
	iₓ = vₓ / r3

	vcstr = latexraw(vc)
	vxstr = latexraw(vₓ)
	ixstr = latexraw(iₓ)

	md_text = """
	* **Resultados das variávies requeridas**:

	```math
	\\begin{aligned}
	v_c &= $vcstr \\\\
	v_x &= $vxstr \\\\
	i_x &= $ixstr
	
	\\end{aligned}
	```
	"""
	
	Markdown.parse(md_text)
end

# ╔═╡ e2aa16ae-6f62-4c15-9cfc-0999d28f934a
md"""
### Problema Prático 7.1
Consulte o circuito da figura 7.7. Seja, $vc(0)=60V$. Determine $v_c$, $v_x$ e $i_0$, para $t \ge 0$.
"""

# ╔═╡ 6fe2c01e-cfe5-4ed3-95ef-ab3bbaca52c1
let
	# Define variáveis do circuito.
	c = 1/3
	r1 = 12
	r2 = 6
	r3=8
	v0 = 60

	# Encontra a resistência de Thevenin. Lembre-se que é necessário reduzirmos o circuito a fim de encontrar v_c.
	req = parallel(r1, r2) + r3

	# Encontra a constante de tempo τ dos circuitos RC.
	tau = subs(τ, R=>req, C=>c)

	# Encontra vc.
	vc = subs(vₜ, V₀=>v0, τ=>tau)

	# Para encontrarmos vx, precisamos encontrar a tensão no nó A. Podemos conseguir
	# essa tensão calculando os resistores paralelos r1 e r2.
	# Então encontrar a queda de tensão neles.

	r1₁ = parallel(r1, r2)
	vx = r1₁/(r1₁ + r3) * vc
	ix = (vx - vc)/r3

	vcstr = latexraw(vc)
	vxstr = latexraw(vx)
	ixstr = latexraw(ix)

	mdtext = """
	* **Resultado das variáveis do circuito**

	```math
	\\begin{aligned}
	v_c &= $vcstr \\\\
	v_x &= $vxstr \\\\
	i_x &= $ixstr
	\\end{aligned}
	```
	"""

	Markdown.parse(mdtext)
end

# ╔═╡ faa5291e-423a-4383-880d-6517f3bf35b5
md"""
### Exemplo 7.2
A chave do circuito da figura 7.8 foi fechada por um longo período e é aberta em $t = 0$. Determine $v(t)$ para $t \ge 0$. Calcule a energia inicial armazenada no capacitor.
"""

# ╔═╡ 4df33522-a1d5-4807-b44e-4f868b835ce5
let
	r1 = 3
	r2 = 1
	r3 = 9
	v = 20
	c = 20e-3
	# Para t < 0, a chave está fechada; o capacitor é um circuito aberto em cc,
	# conforme representado na figura 7.9a. Usando a divisão de tensão:
	vcₜ₀ = (r3/(r3 + r1))v

	# Para t > 0, a chave é aberta e temos um circuito RC mostrado na figura 7.9b.
	# Note que esse circuito é sem fonte; a fonte independente na figura 7.8 é
	# necessária para fornecer V₀ ou a energia inicial para o capacitor.
	# Os resistores de 1 Ω e 9 Ω em série fornecem:
	req = 1 + 9
	# A constante de tempo τ é:
	tau = subs(τ, C=>c, R=>req)

	# Assim a tensão no capacitor para t ≥ 0 é:
	vcₜ = subs(vₜ, V₀=>vcₜ₀, τ=>tau)

	# Podemos então calcular a energia armazenada no capacitor.
	wc = (1/2)c*vcₜ^2

	vcstr = latexraw(vcₜ)
	wcstr = latexraw(wc)

	mdtext = """
	* A tensão no capacitor para t ≥ 0 é: ``$vcstr`` ``V``.

	* A energia armazenada no capacitor é: ``$wcstr`` ``J``.
	"""

	Markdown.parse(mdtext)
end

# ╔═╡ 9a898450-5edf-4118-99cb-ed737eba39f0
md"""
### Problema Prático 7.2
Se a chave da figura 7.10 abrir em $t=0$, determine $v(t)$ para $t \geq 0$ e $w_c(0)$.
"""

# ╔═╡ f2e05ad6-f1a8-4941-891d-68fc9af1061d
let
	r1 = 6
	r2 = 12
	r3 = 4
	v = 24
	c = 1/6
	req = parallel(r3, r2) + r1

	# Para t < 0, calculamos a tensão em cima do capacitor.
	vc = (parallel(r2, r3) / req)*v
	# Calcula τ. Lembre-se que quando o circuito se encontra aberto em t ≥ 0,
	# o resistor r1 estará desligado. Logo teremos uma resistência equivalente 
	# diferente de quando a chave estava fechada.
	req₁ = parallel(r2, r3)
	tau = subs(τ, R=>req₁, C=>c)
	# A tensão no capacitor para t ≥ 0.
	vcₜ = subs(vₜ, V₀=>vc, τ=>tau)
	# Queremos a energia armazenada no capacitor no instante t=0, wc(0).
	wc = sympy.Float(subs((1/2)*c*vcₜ^2, t=>0), 4)

	vcstr = latexraw(vcₜ)
	wcstr = latexraw(wc)

	mdtext = """
	* A tensão no capacitor para t ≥ 0 é: ``$vcstr`` ``V``.

	* A energia armazenada no capacitor é: ``$wcstr`` ``J``.
	"""

	Markdown.parse(mdtext)
end

# ╔═╡ 2f409c1e-bf7e-48b1-b4ea-eb075c80a8ca
md"""
## Circuitos RL sem Fonte.
O segredo para se trabalhar com circuitos RL sem fonte é determinar:

- A corrente inicial $i(0)=I_0$ por meio do indutor.
- A constante de tempo $\tau$ do circuito.
- Equações importantes:

```math
\begin{aligned}
\tau &= \frac{L}{R} \\
i(t) &= I_0e^{-t/\tau}
\end{aligned}
```
"""

# ╔═╡ deb5eafb-08a8-475d-ba92-1d68130b626c
md"""
### Exemplo 7.3
Supondo que $i(0)=10A$, calcule $i(t)$ e $i_x(t)$.
"""

# ╔═╡ cd7955ee-837a-4866-a1d9-34dfb8617e29
let
	@syms i1 i2 t

	l1 = 0.5
	v₀ = 1
	i₀ = 10
	r1 = 2
	r2 = 4
	
	# Por causa da fonte dependente precisamos substituir o indutor por uma fonte
	# de tensão com v₀ = 1V nos terminais a b do indutor. Aplicamos a LKT aos dois
	# laços:
	loop1 = 2(i1 - i2) + 1 ~ 0
	loop2 = -3i1 + 4i2 + 2(i2 - i1) ~ 0
	i₂ = first(solve(loop2, i2))
	i₁ = first(solve(subs(loop1, i2=>i₂)))
	i₁ = -i₁
	req = Rₜₕ = v₀/i₁
	# A constante de tempo é em segundos:
	τ = l1/req
	# A corrente no indutor é
	i = i₀*exp(-t/τ)
	v = l1*diff(i)
	iₓ = v/r1

	istr = latexraw(i)
	ixstr = latexraw(iₓ)
	
	mdtext = """
	* A corrente no indutor para t ≥ 0 é: ``$istr`` ``A``.

	* A corrente no resistor R₂ é: ``$ixstr`` ``A``.
	"""

	Markdown.parse(mdtext)
	
end

# ╔═╡ 11f8335e-5743-4334-9fb7-262b616980c4
md"""
### Problema Prático 7.3
Determine $i$ e $v_x$ no circuito da figura 7.15. Façamos $i(0) = 12 A$.
"""

# ╔═╡ 9e7988e0-405b-41b9-bfc4-11218647121e
let
	@syms i1 i2 i3 vx va

	r1 = 1
	r2 = 2
	r3 = 6
	l1 = 2
	v = 1
	i₀ = 12

	vₓ = 1 - va

	lkc = ((1 - va)/1) ~ ((va - 2vx)/r2) + ((va - 0)/r3)
	lkc = subs(lkc, vx=>vₓ)
	vₐ = sympy.Float(first(solve(lkc, va)))
	i₁ = (v - vₐ)/1
	req = v / i₁
	τ = l1/req
	iₜ = i₀ * exp(-t/τ)
	vₓ = iₜ * -1

	iₜstr = latexraw(iₜ)
	vₓstr = latexraw(vₓ)

	mdtext = """
	* A corrente no indutor para t ≥ 0 é: ``$iₜstr`` ``A``.

	* A tensão ``v_x`` no resistor R₁ é: ``$vₓstr`` ``A``.
	"""

	Markdown.parse(mdtext)
end

# ╔═╡ 0fdbfa11-6976-4c3b-b5ac-ff36aaf1c492
md"""
### Exemplo 7.4
A chave do circuito da figura 1.16 foi fechada por um longo período. Em $t=0$, a chave é aberta. Calcule $i(t)$ para $t > 0$.
"""

# ╔═╡ 0ad085cd-7328-41f8-a0ca-a57aa8cc8eae
let
    # Quando t < 0, a chave está fechada e o indutor atua como
    # um curto circuito em CC. O resistor de 16Ω é curto circuitado.
    # Associamos os resistores 4Ω e 12Ω em paralelo, e 2Ω em série para chegar a i₁.
    r1 = 2
    r2 = 12
    r3 = 4
    r4 = 16
    v = 40
    l1 = 2
    req = parallel(r2, r3) + r1
    i₁ = v/req
    # Obtemos i(t) a partir de 1₁, usando o princípio da divisão de corrente.
    iₜ = (r2/(r2+r3)) * i₁
    # Uma vez que a corrente através de um indutor não pode mudar instantaneamente: i(0) = 6 A.
    i₀ = 6
    # Quando t > 0, a chave está aberta e a fonte de tensão é desconectada.
    # Agora temos um circuito RL sem fonte. Combinando os resistores, temos:
    req = parallel(r2 + r3, r4)
    # A constante de tempo é
    tau = l1/req
    # Portanto:
    iₜ = i₀*exp(-t/τ)
    iₜ = subs(iₜ, τ=>tau)

    mdtext = """
    A corrente ``i(t)`` para ``t \\gt 0`` é ``$(latexraw(iₜ)) A``.
    """
    Markdown.parse(mdtext)
end

# ╔═╡ 93bed4f5-a789-42e1-a458-2f9805a3dec9
md"""
### Problema Prático 7.4
Para o circuito da Figura 7.18, determine $i(t)$ para $t \gt 0$.
"""

# ╔═╡ 4f61588a-d8c7-4c87-9044-388690f1cb8a
let
	# Para o instante t < 0, o circuito está fechando fazendo com que o indutor
	# se torne um curto circuito, anulando o resistor de 5Ω.
	r₁ = 12
	r₂ = 8
	r₃ = 24
	r₄ = 5
	l₁ = 2
	i = 15

	# Precisamos utilizar a LKC para encontrar a tensão no nó vₐ.
	# ** Importante ** : Prestar atenção no sentido da corrente
	# para não errar sinais."
	@syms va r1 r2 r3
	lkc = i ~ ((va - 0)/r3) + ((va - 0)/r1) + ((va - 0)/r2)
	vₐ = first(solve(subs(lkc, r1=>r₁, r2=>r₂, r3=>r₃), va))
	i₀ = Float64(vₐ / r₁)

	# Com a corrente i(0)=5 A, podemos analisar o segundo estado do circuito.
	# t > 0.
	# Precisamos reduzir o circuito a uma resistência e um indutor.
	req = parallel(r₁ + r₂, r₄)
	tau = l₁/req
	iₜ = i₀*exp(-t/tau)

	iₜ = latexraw(iₜ)
	mdtext = """
	``i(t)`` para ``t \\gt`` é: ``$iₜ``
	"""
	Markdown.parse(mdtext)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
LaTeXStrings = "~1.4.0"
Latexify = "~0.16.8"
PlutoUI = "~0.7.66"
SymPy = "~2.3.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.5"
manifest_format = "2.0"
project_hash = "c374a6505fd78247a5438916c085f6efa0737f09"

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

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

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
version = "1.1.1+0"

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
version = "1.6.0"

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
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

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
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.5+0"

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
version = "1.11.0"

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
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─7a0a00c7-ca82-49bb-b031-67a079f19049
# ╠═4acf9170-095a-4b91-a213-97fd282d374c
# ╠═92a1800f-8efc-4386-a37f-9981c9c7b2a1
# ╟─a7d047dc-2dd3-4a28-bde2-1dd11c6a7808
# ╟─0533914a-0a1a-4fff-8073-7894486872ad
# ╠═42bda48c-2693-47cd-931b-ec5652e4ec41
# ╟─e2aa16ae-6f62-4c15-9cfc-0999d28f934a
# ╠═6fe2c01e-cfe5-4ed3-95ef-ab3bbaca52c1
# ╟─faa5291e-423a-4383-880d-6517f3bf35b5
# ╠═4df33522-a1d5-4807-b44e-4f868b835ce5
# ╟─9a898450-5edf-4118-99cb-ed737eba39f0
# ╠═f2e05ad6-f1a8-4941-891d-68fc9af1061d
# ╟─2f409c1e-bf7e-48b1-b4ea-eb075c80a8ca
# ╟─deb5eafb-08a8-475d-ba92-1d68130b626c
# ╠═cd7955ee-837a-4866-a1d9-34dfb8617e29
# ╟─11f8335e-5743-4334-9fb7-262b616980c4
# ╠═9e7988e0-405b-41b9-bfc4-11218647121e
# ╟─0fdbfa11-6976-4c3b-b5ac-ff36aaf1c492
# ╠═0ad085cd-7328-41f8-a0ca-a57aa8cc8eae
# ╟─93bed4f5-a789-42e1-a458-2f9805a3dec9
# ╠═4f61588a-d8c7-4c87-9044-388690f1cb8a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
