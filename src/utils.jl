mutable struct TupleGen
    tuple::Expr
    function TupleGen()
        new(Expr(:tuple))
    end
end

function Base.push!(t::TupleGen, it)
    push!(t.tuple.args, it)
    t
end

const eq = Symbol("=")

function Base.push!(t::TupleGen, name::Symbol, val)
    ex = Expr(eq, name, val)
    push!(t.tuple.args, ex)
    t
end

Base.push!(t::TupleGen, name::String, val) = push!(t, Symbol(name), val)

function build(t::TupleGen)
    eval(t.tuple)
end
