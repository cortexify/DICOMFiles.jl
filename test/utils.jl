include("../src/utils.jl")

@testset "Tuple Generator" begin
    t = TupleGen()
    push!(t, 12)
    push!(t, 34)
    push!(t, 56)
    tt = build(t)
    @test tt[1] == 12
    @test tt[2] == 34
    @test tt[3] == 56

    nt = TupleGen()
    push!(nt, :a, 12)
    push!(nt, :b, 34)
    push!(nt, "c", 56)
    ntt = build(nt)
    @test ntt.a == 12
    @test ntt.b == 34
    @test ntt.c == 56
end