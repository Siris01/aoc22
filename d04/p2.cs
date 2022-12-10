using System;

class Program
{
    public static void Main(string[] args)
    {
        Int32 x = 0, lines=0;

        foreach (string line in System.IO.File.ReadLines(@"input.txt"))
        {
            string[] jobs = line.Split(',');
            int[] a = Array.ConvertAll(jobs[0].Split('-'), s => int.Parse(s));
            int[] b = Array.ConvertAll(jobs[1].Split('-'), s => int.Parse(s));

            lines++;

            if (a[1] < b[0]) x++;
            else if (b[1] < a[0]) x++;
        }

        Int32 ans = lines - x;
        Console.WriteLine(ans);
    }
}