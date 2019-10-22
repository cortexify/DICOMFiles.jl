import DICOMFiles: Parser, parse, Image, getRawData


dcm = open("0003.DCM")
buffer = IOBuffer(read(dcm, String))
parser = Parser()
image = parse(parser, buffer)
show(image)
show(getRawData(image).data)
# println(image)