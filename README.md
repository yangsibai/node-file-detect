## node-file-detect

Detect file type.

### Usage

    var fd = require("file-detect");
    fd.is("/example/sample.png", ".png", function(err, isPNG){
        // some more code with the result
    });

### Supported file type

+ .png
+ .jpg
+ .gif
+ .bmp
+ .bz
+ .gz
+ .zip

### Reference

1. <http://en.wikipedia.org/wiki/List_of_file_signatures>
2. <http://stackoverflow.com/a/8475542/1778658>
3. <http://www.astro.keele.ac.uk/oldusers/rno/Computing/File_magic.html>
