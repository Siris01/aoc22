File file = new File("input.txt")
cycle = 1
x = 1
crtPos = 0
crtWidth = 40
crtCycles = 240

def check() {
    dist = x - crtPos
    if (dist == 0 || dist == -1 || dist == 1) {
        print "#"
    } else {
        print "."
    }

    crtPos++;
    if (crtPos == crtWidth) {
        crtPos = 0;
        print "\n"
    }
}
    
file.withReader { reader ->
    while ((line = reader.readLine()) != null) {
        check();
        
        switch ("${line[0..3]}") {
            case "noop": break;
            case "addx": 
                cycle++;
                check();
                x += line.split(' ')[1] as int;
        }
        
        cycle++;
    }
}