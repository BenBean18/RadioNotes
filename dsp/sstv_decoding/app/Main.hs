module Main where

import Data.ByteString.Lazy as B
import Streaming
import Streaming.Binary
import Data.Binary (Binary, get, put)
import qualified Streaming.Prelude as S
import System.IO (withFile, IOMode(..))
import qualified Data.ByteString.Streaming.Char8 as Q
import qualified GHC.Int
import Utilities

main :: IO ()
main = putStrLn "Hello, Haskell!"

-- Use streaming library to print the complex floats read

-- readRaw :: FilePath -> IO ()
-- readRaw path =
--     withFile path ReadMode $ \h -> do
        
--         -- Read streaming byte string from file
--         let byteString = Q.fromHandle h

--         -- Decode the byte string into a stream of ComplexFloats
--         let complexFloats = decode byteString :: Stream (Of ComplexFloat) IO (Q.ByteString (Stream (Of ComplexFloat) IO) (), GHC.Int.Int64, Either String ComplexFloat)

--         -- Print the complex floats
--         S.print complexFloats

printFirstComplexFloat :: FilePath -> IO ()
printFirstComplexFloat path = do
    withFile path ReadMode $ \h -> do
        let byteString = Q.fromHandle h
        let complexFloats = decode byteString :: Stream (Of ComplexFloat) IO (Q.ByteString (Stream (Of ComplexFloat) IO) (), GHC.Int.Int64, Either String ComplexFloat)
        S.print $ S.take 1 complexFloats