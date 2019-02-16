
module tagsdata

const HIGH = UInt32(2 ^ 16)

struct RegistryElement
    tag::UInt32
    mask::UInt32
    name::AbstractString
    vr::AbstractString
    vm::AbstractString
    notes::AbstractString
    function RegistryElement(tagh, tagl, mh, ml, name, vr, vm, notes)
        new(UInt32(parse(UInt32, tagh) * HIGH + parse(UInt32, tagl)),
            UInt32(parse(UInt32, mh) * HIGH + parse(UInt32, ml)),
            name, vr, vm, notes)
    end
end

function readtags()
    tgs = Dict{UInt32, RegistryElement}()
    open((@__DIR__) * "/tags.csv", "r") do io
        line = readline(io)
        while !eof(io) && length(line) > 20
            el = RegistryElement( split(line, ",")... )
            tgs[el.tag] = el
            line = readline(io)
        end
    end
    tgs
end

function scangrougs(ids)
    grps = Dict{UInt32, Array{UInt32}}()
    for id in ids
        key = id >> 16
        if haskey(grps, key)
            push!(grps[key], (id & 0x0000ffff))
        else
            grps[key] = [id & 0x0000ffff]
        end
    end
    grps
end

function scannames(tgs)
    nms = Dict{String, UInt32}()
    for tag in tgs
        nms[tag.name] = tag.tag
    end
    nms
end

tags = readtags()
groups = scangrougs(collect(keys(tags)))
names = scannames(values(tags))

end # module tagsdata

struct Registry end
registry = Registry()

el2tuple(el) = (
    tag = (UInt16(el.tag >> 16), UInt16(el.tag & 0x0000ffff)),
    name = el.name,
    vr = el.vr,
    vm = el.vm
)

function Base.getindex(r::Registry, i::Integer)
    el = get(tagsdata.tags, i, missing)
    el === missing && return el
    el2tuple(el)
end

function Base.getindex(r::Registry, h::Integer, l::Integer)
    el = get(tagsdata.tags, h * tagsdata.HIGH + l, missing)
    el === missing && return el
    el2tuple(el)
end

function Base.getindex(r::Registry, name::AbstractString)
    tag = get(tagsdata.names, name, missing)
    tag === missing && return missing
    el2tuple(tagsdata.tags[tag])
end
