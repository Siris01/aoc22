using System;

class Program
{
    public static void Main(string[] args)
    {
        Int32 ans = 0;

        foreach (string line in System.IO.File.ReadLines(@"input.txt"))
        {
            string[] jobs = line.Split(',');
            int[] a = Array.ConvertAll(jobs[0].Split('-'), s => int.Parse(s));
            int[] b = Array.ConvertAll(jobs[1].Split('-'), s => int.Parse(s));

            if (a[0] == b[0] || a[0] == b[1] || b[1] == a[1] || b[0] == a[1]) ans++;
            else if (a[0] >= b[0] && a[0] <= b[1]) ans++;
            else if (a[1] >= b[0] && a[1] <= b[1]) ans++;
            else if (b[0] >= a[0] && b[0] <= a[1]) ans++;
            else if (b[1] >= a[0] && b[1] <= a[1]) ans++;
        }

        Console.WriteLine(ans);
    }
}