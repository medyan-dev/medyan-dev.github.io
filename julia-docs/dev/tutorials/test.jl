### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ 6218a9f4-5198-11ec-2435-97718321d345
begin
    import Pkg
    # activate a temporary environment
    Pkg.activate(mktempdir())
	Pkg.add(name="MeshCat", version="0.14")
	parentdir= try
		basename(cd(pwd,".."))
	catch e
		@warn "Couldn't read parent directory"
	end
	if parentdir=="src"
		#track local changes with revise
		Pkg.develop(path="../../../")
		try
		    using Revise
		catch e
		    @warn "Error initializing Revise" exception=(e, catch_backtrace())
		end
		Pkg.instantiate()
	elseif parentdir=="build"
		Pkg.develop(path="../../../")
	else
Pkg.add(url="git@github.com:medyan-dev/MEDYAN.jl.git", rev="ed298de")
	end

	
    using MeshCat
	
	using MEDYAN
end


# ╔═╡ eb4d33f9-8ae8-483c-adc8-a034edf0cb14
statedef = MEDYAN.StateDef(
	diffusingspeciesnames= [:a,:b,:c],
)

# ╔═╡ 8df2bc91-0121-4d4d-81e4-a9f2e83e14a4
grid= CubicGrid((10,10,10),500.0)

# ╔═╡ 34c09a62-adcd-42da-a55d-8fd5efb710e5
s= MEDYAN.SysDef(statedef)

# ╔═╡ 1ec02642-e097-4140-9225-bf8f94cfa7f9
diffusion_coeffs= [1.0E6,4.0E6,9.0E6]

# ╔═╡ 2a5d951c-31fa-4504-bfd6-9ba08eeb7f01
vis = Visualizer()

# ╔═╡ b6abfd7e-18cb-428a-b2a4-5b227ac0604d
vis2 = Visualizer()

# ╔═╡ ce4026e3-5a45-4160-911d-b90f701e2cb3
begin
	delete!(vis)
	delete!(vis2)
	c= MEDYAN.Context(s,grid;diffusion_coeffs)
	MEDYAN.setdiffusingspeciescount!(c,1,s.diffusing.a,2000)
	MEDYAN.setdiffusingspeciescount!(c,1,s.diffusing.b,2000)
	MEDYAN.setdiffusingspeciescount!(c,1,s.diffusing.c,2000)
	setvisible!(vis["/Grid"], false)
	setvisible!(vis["/Axes"], false)
	setvisible!(vis["/Background"], false)
	MEDYAN.drawcontext!(vis, c, s)
	MEDYAN.run_chemistry!(c,0.1)
	#draw after
	setvisible!(vis2["/Grid"], false)
	setvisible!(vis2["/Axes"], false)
	setvisible!(vis2["/Background"], false)
	MEDYAN.drawcontext!(vis2, c, s)
	setvisible!(vis2["grid/inner"], false)
end

# ╔═╡ 31dba8c9-2a4a-48f7-8d10-80844b229cb1


# ╔═╡ 2981c305-bd96-42b9-955a-ef4df1ecf19d
pwd()

# ╔═╡ 52edd7a2-46fe-4e7b-b303-230b2eda07f6
function render_ci(vis)
	#static render if creating html or on binder
	if parentdir=="build" || parentdir=="pkg" 
		render_static(vis)
	else
		render(vis)
	end
end

# ╔═╡ 947bef04-6dd6-4fa2-85d2-33ce8b8ecf4e
render_ci(vis)

# ╔═╡ 3733547c-1ea7-431e-8142-0f6dd8e262f7
render_ci(vis2)

# ╔═╡ Cell order:
# ╠═eb4d33f9-8ae8-483c-adc8-a034edf0cb14
# ╠═8df2bc91-0121-4d4d-81e4-a9f2e83e14a4
# ╠═34c09a62-adcd-42da-a55d-8fd5efb710e5
# ╠═1ec02642-e097-4140-9225-bf8f94cfa7f9
# ╠═2a5d951c-31fa-4504-bfd6-9ba08eeb7f01
# ╠═b6abfd7e-18cb-428a-b2a4-5b227ac0604d
# ╠═ce4026e3-5a45-4160-911d-b90f701e2cb3
# ╠═31dba8c9-2a4a-48f7-8d10-80844b229cb1
# ╠═947bef04-6dd6-4fa2-85d2-33ce8b8ecf4e
# ╠═3733547c-1ea7-431e-8142-0f6dd8e262f7
# ╠═2981c305-bd96-42b9-955a-ef4df1ecf19d
# ╠═52edd7a2-46fe-4e7b-b303-230b2eda07f6
# ╠═6218a9f4-5198-11ec-2435-97718321d345
