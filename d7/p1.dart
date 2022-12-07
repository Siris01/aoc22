import 'dart:async';
import 'dart:io';
import 'dart:convert';

bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}

var disk = new Map();

Future<void> iterate(Stream<String> stream) async {
  var dir = "/";
  await for (final line in stream) {
    if (line.startsWith("\$ cd ")) {
      var d = line.substring(5);
      if (d == "/") {
        dir = d;
      } else if (d == "..") {
        var l = dir.split("/");
        l.removeLast();
        dir = l.length != 1 ? l.join("/"): "/";
      } else {
        dir += dir == "/" ? d : "/" + d;
      }
      if (!disk.containsKey(dir)) disk[dir] = {"size":0, "subs": []};
    } else if (!line.startsWith("\$")){
      var temp = line.split(" ");

      if (isNumeric(line[0])) disk[dir]["size"] += int.parse(temp[0]);
      else disk[dir]["subs"].add(temp[1]);
    }
  }
}

main() async {
  var stream = new File("input.txt")
    .openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter());

  await iterate(stream);
  
  while (true) {
    var noOp = true;
    disk.removeWhere((k, v) => v["size"] > 100000);
    
    disk.forEach((k, v) {
        if (v["subs"].length > 0) {
            noOp = false;
            for (String s in List.from(v["subs"])) {
                if (disk.containsKey(k + "/" + s)) {
                    if (disk[k + "/" + s]["subs"].isEmpty) {
                        disk[k]["size"] += disk[k + "/" + s]["size"];
                        disk[k]["subs"].remove(s);
                    }
                } else {
                    disk[k]["delete"] = true;
                    break;
                }
            }
        } 
    });
    
    disk.removeWhere((k, v) => v["delete"] == true);
    
    if (noOp) break;
  }

  int sum = 0;

  disk.forEach((k, v) {
    if (v["size"] <= 100000) sum += v["size"] as int;
  });

  print(sum);
}