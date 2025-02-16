### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ a3512503-3d31-4a79-be73-58b7407e18cd
using SymPy, PlutoUI, Printf

# ╔═╡ f6b2ac70-e486-11ef-26d1-992031b33bfd
md"""
# Nodal Analysis
Nodal analysis provides a general procedure for analyzing circuits using node voltages as the circuit variables. Choosing node voltages instead of element voltages as circuit variables is convenient and reduces the number of equations one must solve simultaneously. In nodal analysis, we are interested in finding the node voltages.
"""

# ╔═╡ a6ae3079-e020-48a8-828b-a778fc55c1f1
TableOfContents()

# ╔═╡ b7f141a6-d840-4420-9ebe-63205d7889b9
md"""
## Nodal Analysis without Voltage Sources
Given a circuit with n nodes **without voltage sources**, the nodal analysis of the circuit involves taking the following three steps.

* Select a node as the reference node. Assign voltages v1, v2, . . . , vn − 1 to the remaining n − 1 nodes. The voltages are referenced with respect to the reference node.

* Apply KCL to each of the n − 1 nonreference nodes. Use Ohm’s law to express the branch currents in terms of node voltages.

* Solve the resulting simultaneous equations to obtain the un-known node voltages.

### Example 3.1
Calculate the node voltages in the circuit.
"""

# ╔═╡ a7fd01f4-61ff-4f51-bb3a-740ee72914d0
let
	@syms i1 i2 i3 i4 i5 v1 v2
	lkc1 = simplify(subs(i1 ~ i2 + i3, i1=>5, i2=>(v1 - v2)/4, i3=>(v1-0)/2))
	lkc2 = simplify(subs(i2 + i4 ~ i1 + i5, i2=>(v1-v2)/4, i4=>10, i1=>5, i5=>(v2-0)/6))
	result = solve((lkc1, lkc2), (v1, v2))
	nv1, nv2 = getindex.(Ref(result), (v1, v2))
	@info @sprintf("V₁: %.3f V, V₂: %.3f V", Float64(nv1), Float64(nv2))
end

# ╔═╡ 8addfee1-bfde-490e-84d8-0401dda24cee
md"""
### Practice Problem 3.1
Determine the voltages at the nodes 1 e 2.
"""

# ╔═╡ 135d76a8-fb15-401f-8abb-1775ef4ddd65
let
	@syms i1 i2 i3 i4 i5 v1 v2
	lkc1 = subs(i1 ~ i2 + i3, i1=>3, i2=>(v1-0)/2, i3=>(v1-v2)/6)
	lkc1 = simplify(lkc1)
	lkc2 = subs(i3 ~ i4 + i5, i3=>(v1-v2)/6, i4=>(v2-0)/7, i5=>12)
	lkc2 = simplify(lkc2)
	result = solve((lkc1, lkc2), (v1, v2))
	nv1, nv2 = getindex.(Ref(result), (v1, v2))
	@info @sprintf("V₁: %.3f V, V₂: %.3f V", nv1, nv2)
end

# ╔═╡ de4a9349-69b9-40e0-a8f0-50a82d88da99
md"""
### Practice Problem 3.2
Determine the voltages at the nodes
"""

# ╔═╡ 03829bbd-cd54-4ee7-89af-38025f7ee7c4
let
	@syms i1 i2 i3 ix i5 v1 v2 v3
	lkc1 = simplify(subs(i1 ~ i3 + i2, i1=>4, i2=>(v1-v3)/2, i3=>(v1-v2)/3))
	lkc2 = simplify(subs(i3 + 4ix ~ ix, ix=>(v2-0)/4, i3=>(v1-v2)/3))
	lkc3 = simplify(subs(i2 ~ 4ix + i5, ix=>(v2-0)/4, i2=>(v1-v3)/2, i5=>(v3-0)/6))
	result = solve((lkc1, lkc2, lkc3), (v1, v2, v3))
	ni1, ni2, ni3 = Float64.(getindex.(Ref(result), (v1, v2, v3)))
	@info @sprintf("V₁: %.3f V, V₂: %.3f V, V₃: %.3f V", ni1, ni2, ni3)
end

# ╔═╡ 8de6d155-d3d4-4205-9d93-4fd3722bb60f
md"""
## Nodal Analysis with Voltage Sources
Consider the following two possibilities:

* Case 1
If a voltage source is connected between the reference
node and a nonreference node, we simply set the voltage at the nonreference node equal to the voltage of the voltage source
* Case 2
If the voltage source (dependent or independent) is connected between two nonreference nodes, the two nonreference nodes form a generalized node or supernode; we apply both KCL and KVL to determine the node voltages.

*A supernode is formed by enclosing a (dependent or independent) volt-
age source connected between two nonreference nodes and any ele-
ments connected in parallel with it*.

### Example 3.3
Find the node voltages.
"""

# ╔═╡ 6229d461-6b7f-477b-b713-c436630d3bf0
let
	@syms i1 i2 v1 v2
	lkc1 = simplify(subs(2 ~ i1 + i2 + 7, i1=> (v1-0)/2, i2=>(v2-0)/4))
	lkt1 = simplify(-v1 -2 + v2 ~ 0)
	result = solve((lkt1, lkc1), (v1, v2))
	nv1, nv2 = Float64.(getindex.(Ref(result), (v1, v2)))
	@info @sprintf("V₁: %.3f V, V₂: %.3f V", nv1, nv2)
end

# ╔═╡ 2cfd0a5c-854a-4c51-9be4-aeab1f17f6f4
md"""
### Practice Problem 3.3
Find $v$ and $i$ in the circuit.
"""

# ╔═╡ 739d8869-3d06-4875-877d-b337118ae02d
let
	@syms I i1 i2 i3 v1 v2 v3
	nv1=14
	lkc1 = subs(i1 ~ i2 + I + i3, i1=>(nv1-v2)/4, i2=>v2/3, I=>v3/2, i3=>v3/6)
	lkt1 = -v2 - 6 + v3 ~ 0
	result = solve((lkt1, lkc1), (v2, v3))
	nv2, nv3 = Float64.(getindex.(Ref(result), (v2, v3)))
	nv = nv2
	ni = nv3/2
	@info @sprintf("V: %.3f V, I: %.3f A", nv, ni)
end

# ╔═╡ 78af1beb-5154-4615-b663-f994877e9eba
md"""
### Example 3.4
Find the node voltages in the circuit.
"""

# ╔═╡ 14c1c066-c8a9-4bf3-8456-080a106c3887
let
	@syms v1 v2 v3 i i1 i2
	lkc1 = simplify(subs(0 ~ i + i1 + i2, i=>v1/2, i1=>v2/4, i2=>v3/3))
	lkt1 = simplify(-v1 + 25 + v2 ~ 0)
	lkt2 = simplify(subs(-v2 - 5i + v3, i=>v1/2))
	result = solve((lkt1, lkt2, lkc1), (v1, v2, v3))
	nv1, nv2, nv3 = Float64.(getindex.(Ref(result), (v1, v2, v3)))
	@info @sprintf("V₁: %.3f V, V₂: %.3f V, V₃: %.3f", nv1, nv2, nv3)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
PlutoUI = "~0.7.61"
SymPy = "~2.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "808034353fdac4e8c374f4c9b4bfed5c5a41d171"

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
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

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
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

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
git-tree-sha1 = "cd714447457c660382fe634710fb56eb255ee42e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.6"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
git-tree-sha1 = "1833212fd6f580c20d4291da9c1b4e8a655b128e"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.0.0"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

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
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

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
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"

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
git-tree-sha1 = "355cfab2f6ff3be24404d31509d19db6a76b62b5"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "2.2.2"

[[deps.SymPyCore]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "2908058016900cf30d9c21c44d02198c78da4cba"
uuid = "458b697b-88f0-4a86-b56b-78b75cfb3531"
version = "0.2.9"

    [deps.SymPyCore.extensions]
    SymPyCoreTermInterfaceExt = "TermInterface"

    [deps.SymPyCore.weakdeps]
    TermInterface = "8ea1fca8-c5ef-4a55-8b96-4e9afe9c9a3c"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
# ╟─f6b2ac70-e486-11ef-26d1-992031b33bfd
# ╟─a3512503-3d31-4a79-be73-58b7407e18cd
# ╟─a6ae3079-e020-48a8-828b-a778fc55c1f1
# ╟─b7f141a6-d840-4420-9ebe-63205d7889b9
# ╠═a7fd01f4-61ff-4f51-bb3a-740ee72914d0
# ╟─8addfee1-bfde-490e-84d8-0401dda24cee
# ╠═135d76a8-fb15-401f-8abb-1775ef4ddd65
# ╟─de4a9349-69b9-40e0-a8f0-50a82d88da99
# ╠═03829bbd-cd54-4ee7-89af-38025f7ee7c4
# ╟─8de6d155-d3d4-4205-9d93-4fd3722bb60f
# ╠═6229d461-6b7f-477b-b713-c436630d3bf0
# ╟─2cfd0a5c-854a-4c51-9be4-aeab1f17f6f4
# ╠═739d8869-3d06-4875-877d-b337118ae02d
# ╟─78af1beb-5154-4615-b663-f994877e9eba
# ╠═14c1c066-c8a9-4bf3-8456-080a106c3887
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
