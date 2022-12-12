import java.io.File;
import java.util.Scanner; 
import java.util.ArrayList;

class Pos {
    int x;
    int y;

    public Pos(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getDistance(Pos p) {
        return Math.abs(this.x - p.x) + Math.abs(this.y - p.y);
    }

    public Pos move(int dirX, int dirY) {
        return new Pos(this.x + dirX, this.y + dirY);
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;
        if (!(o instanceof Pos)) return false;
         
        Pos pos = (Pos)o;

        return this.x == pos.x && this.y == pos.y;
    }
}

public class p2 {
    static int[][] map;
    static int srcX;
    static int srcY;
    static int destX;
    static int destY;
    static int rows;
    static int cols;
    static ArrayList<Pos> visited;

    static void initDimensions() {
        try {
            File file = new File("input.txt");
            Scanner sc = new Scanner(file);
            rows = 0;
            cols = 0;

            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                if (rows == 0) cols = line.length();

                rows++;
            }

            map = new int[rows][cols];

            sc.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    static void init() {
        initDimensions();

        try {
            File file = new File("input.txt");
            Scanner sc = new Scanner(file);
            int row = 0;

            while (sc.hasNextLine()) {
                String line = sc.nextLine();

                for (int i = 0; i < line.length(); i++) {
                    if (line.charAt(i) == 'S') {
                        map[row][i] = 1;
                        srcX = row;
                        srcY = i;
                    } else if (line.charAt(i) == 'E') {
                        map[row][i] = 26;
                        destX = row;
                        destY = i;
                    } else {
                        map[row][i] = ((int)line.charAt(i)) - 96;
                    }
                }

                row++;
            }

            sc.close();
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
    }

    static ArrayList<ArrayList<Pos>> explore(ArrayList<Pos> current) {
        ArrayList<ArrayList<Pos>> paths = new ArrayList<ArrayList<Pos>>();

        Pos currentPos = current.get(current.size() - 1);
        int currentHeight = map[currentPos.x][currentPos.y];

        Pos down = currentPos.move(1, 0);
        if ((!visited.contains(down)) && (currentPos.x != rows - 1) && (map[down.x][down.y] <= currentHeight + 1)) {
            ArrayList<Pos> newPath = new ArrayList<Pos>(current);
            newPath.add(down);
            visited.add(down);
            paths.add(newPath);
        }

        Pos up = currentPos.move(-1, 0);
        if ((!visited.contains(up)) && (currentPos.x != 0) && (map[up.x][up.y] <= currentHeight + 1)) {
            ArrayList<Pos> newPath = new ArrayList<Pos>(current);
            newPath.add(up);
            visited.add(up);
            paths.add(newPath);
        }

        Pos right = currentPos.move(0, 1);
        if ((!visited.contains(right)) && (currentPos.y != cols - 1) && (map[right.x][right.y] <= currentHeight + 1)) {
            ArrayList<Pos> newPath = new ArrayList<Pos>(current);
            newPath.add(right);
            visited.add(right);
            paths.add(newPath);
        }

        Pos left = currentPos.move(0, -1);
        if ((!visited.contains(left)) && (currentPos.y != 0) && (map[left.x][left.y] <= currentHeight + 1)) {
            ArrayList<Pos> newPath = new ArrayList<Pos>(current);
            newPath.add(left);
            visited.add(left);
            paths.add(newPath);
        }

        return paths;
    }

    static ArrayList<ArrayList<Pos>> solve(int x, int y) {
        ArrayList<ArrayList<Pos>> queue = new ArrayList<ArrayList<Pos>>();
        ArrayList<ArrayList<Pos>> solutions = new ArrayList<ArrayList<Pos>>();
        Pos destination = new Pos(destX, destY);
        visited = new ArrayList<Pos>();

        ArrayList<Pos> start = new ArrayList<Pos>();
        start.add(new Pos(x, y));
        visited.add(new Pos(x, y));
        queue.add(start);

        while (queue.size() > 0) {
            int min = 999999999;
            int index = 0;
            ArrayList<Pos> path = queue.get(0);

            for (int i = 0; i < queue.size(); i++) {
                ArrayList<Pos> p = queue.get(i);
                Pos last = p.get(p.size() - 1);
                int heuristic = destination.getDistance(last) + p.size();

                if (heuristic < min) {
                    min = heuristic;
                    path = p;
                    index = i;
                }
            }

            queue.remove(index);
            Pos last = path.get(path.size() - 1);
            if (last.equals(destination)) {
                solutions.add(path);
            } else {
                ArrayList<ArrayList<Pos>> newPaths = explore(path);
                for (int i = 0; i < newPaths.size(); i++) {
                    queue.add(newPaths.get(i));
                }
            }
        }

        return solutions;
    } 

    static ArrayList<Pos> getStartingLocations() {
        ArrayList<Pos> startingLocations = new ArrayList<Pos>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (map[i][j] == 1) {
                    startingLocations.add(new Pos(i, j));
                }
            }
        }

        return startingLocations;
    }

    public static void main(String[] args) {
        init();

        ArrayList<Integer> answers = new ArrayList<Integer>();
        ArrayList<Pos> start = getStartingLocations();

        for (int i = 0; i < start.size(); i++) {
            Pos s = start.get(i);
            ArrayList<ArrayList<Pos>> solutions = solve(s.x, s.y);

            for (int j = 0; j < solutions.size(); j++) {
                answers.add(solutions.get(j).size());                
            }
        }
        
        int ans = 999999999;

        for (int i = 0; i < answers.size(); i++) {
            if (answers.get(i) < ans) {
                ans = answers.get(i);
            }
        }

        ans -= 1;
        System.out.println(ans);
    }
}