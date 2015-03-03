fs = require("fs")

###
    File magic numbers
    Hex digits: xx = variable
    Ascii digits: . = not an ascii char
###
MAGIC_DATA =
    "png": "89504e47"
    "jpg": "ffd8ffe0"
    "gif": "47494638"
    "bmp": "424d"
    "bz": "425a"
    "gz": "1f8b"
    "zip": "504b0304"

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
