fs = require("fs")

###
    File magic numbers
    Hex digits: xx = variable
    Ascii digits: . = not an ascii char
###
MAGIC_DATA =
    "png": "89 50 4e 47"
    "jpg": "ff d8 ff e0"
    "gif": "47 49 46 38"
    "bmp": "42 4d"
    "bz": "42 5a"
    "gz": "1f 8b"
    "zip": "50 4b 03 04"

_firstBytes = (filePath, cb)->
    fs.open filePath, 'r', (err, fd)->
        return cb(err) if err
        buffer = new Buffer(READ_BUFFER_LENGTH)
        fs.read fd, buffer, 0, READ_BUFFER_LENGTH, 0, (err, num)->
            fileFirstBytes = buffer.toString('hex', 0, num)
            cb null, fileFirstBytes

###
    detect file
###
exports.is = (filePath, extension, cb)->
    return cb(new Error("has not extension")) unless extension
    _firstBytes filePath, (err, bytes)->
        return cb(err) if err
        extension = extension.substr(1, extension.length - 1) if extension[0] is "."
        shouldStartWith = MAGIC_DATA[extension]
        if shouldStartWith
            return cb null, bytes.indexOf(shouldStartWith) is 0
        cb null, false
