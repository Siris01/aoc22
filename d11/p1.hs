import Data.List

slice :: Int -> Int -> String -> String
slice start len s = drop start (take (start+len) s)

toInt :: String -> Int
toInt s = read s :: Int

modifyArray :: [Int] -> Int -> Int -> [Int]
modifyArray array i new = do
    let (before, after) = splitAt i array
    before ++ [new] ++ tail after

modify2dArray :: [[Int]] -> Int -> [Int] -> [[Int]]
modify2dArray array i new = do
    let (before, after) = splitAt i array
    before ++ [new] ++ tail after

parse :: String -> (Int -> Int)
parse s = do
    if slice 0 1 s == "*" then do
        if slice 2 1 s == "o"
        then (\x -> x * x)
        else (\x -> x * toInt (slice 2 10 s))
    else if slice 0 1 s == "+"
    then (\x -> x + toInt (slice 2 10 s))
    else (\x -> x)

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sb str = split' sb str [] []
    where
    split' _   []  subacc acc = reverse (reverse subacc:acc)
    split' sb str subacc acc
        | sb `isPrefixOf` str = split' sb (drop (length sub) str) [] (reverse subacc:acc)
        | otherwise            = split' sb (tail str) (head str:subacc) acc

processRound :: String -> [[Int]] -> [Int] -> Int -> Int
processRound _ _ counts 20  =  product (take 2 (reverse (sort counts)))
processRound str levels counts i = do
    let (l, c) = processMonkeys (splitStr "\n\n" str) levels counts
    processRound str l c (i+1)

processMonkeys :: [String] -> [[Int]] -> [Int] -> ([[Int]], [Int])
processMonkeys [] levels counts = (levels, counts) 
processMonkeys (x:xs) levels counts = do
    let (monkeyNumber, op, d, t, f) = parseMonkey (lines x)
    let (l, c) = inspect (levels !! monkeyNumber) levels counts op d t f monkeyNumber
    processMonkeys xs l c

inspect :: [Int] -> [[Int]] -> [Int] -> (Int -> Int) -> Int -> Int -> Int -> Int -> ([[Int]], [Int])
inspect [] levels counts _ _ _ _ i = (modify2dArray levels i [], counts)
inspect (x:xs) levels counts op d t f monkeyNumber = do
    let worry = op x `div` 3
    let cnts = modifyArray counts monkeyNumber ((counts !! monkeyNumber) + 1)
    if worry `mod` d == 0 then do
        let stack = (levels !! t) ++ [worry]
        inspect xs (modify2dArray levels t stack) cnts op d t f monkeyNumber
    else do
        let stack = (levels !! f) ++ [worry]
        inspect xs (modify2dArray levels f stack) cnts op d t f monkeyNumber
        
parseMonkey :: [String] -> (Int, Int -> Int, Int, Int, Int)
parseMonkey ls = do
    let monkeyNumber = toInt (slice 7 1 (ls !! 0))
    let op = parse (splitStr "d " (ls !! 2) !! 1)
    let d = toInt (splitStr "divisible by " (ls !! 3) !! 1)
    let t = toInt (splitStr "monkey " (ls !! 4) !! 1)
    let f = toInt (splitStr "monkey " (ls !! 5) !! 1)

    (monkeyNumber, op, d, t, f)

initLevels :: [String] -> [[Int]] -> Int -> [[Int]]
initLevels [] levels _ = levels
initLevels (x:xs) levels i = do
    let stack = map toInt (splitStr ", " (splitStr ": " x !! 1))
    initLevels xs (modify2dArray levels i stack) (i+1)

main :: IO ()
main = do
    file <- readFile "input.txt"
    let levels = initLevels (filter ("Starting items" `isInfixOf`) (splitStr "\n" file)) (replicate 8 []) 0
    print (processRound file levels (replicate 8 0) 0)