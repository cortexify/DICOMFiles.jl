# import FileIO: File, @format_str
module DICOMFiles

include("./DicomTagDicts.jl")
include("./DicomUtils.jl")
include("./DicomParserConsts.jl")
include("./DicomTag.jl")
include("./DicomImage.jl")
include("./DicomParser.jl")

end