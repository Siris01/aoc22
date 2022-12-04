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

            bool cond1 = a[0] == b[0] || a[0] == b[1] || b[1] == a[1] || b[0] == a[1];
            bool cond2 = a[0] >= b[0] && a[0] <= b[1];
            bool cond3 = a[1] >= b[0] && a[1] <= b[1];
            bool cond4 = b[0] >= a[0] && b[0] <= a[1];
            bool cond5 = b[1] >= a[0] && b[1] <= a[1];

            if (cond1 || cond2 || cond3 || cond4 || cond5) ans += 1;
        }

        Console.WriteLine(ans);
    }
}