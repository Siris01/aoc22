File file = new File("input.txt")
cycle = 1
x = 1
ans = 0
cycles = [20, 60, 100, 140, 180, 220]

def check() {
    if (cycles.size() > 0 && cycles[0] == cycle) {
        ans += cycles[0] * x;
        cycles.remove(0);
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

println ans