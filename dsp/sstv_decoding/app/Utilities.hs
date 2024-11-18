module Utilities where

data ComplexFloat = ComplexFloat Float Float deriving Show
instance Binary ComplexFloat where
    put (ComplexFloat r i) = do
        put r
        put i
    get = do
        r <- get
        i <- get
        return (ComplexFloat r i)

-- Functions needed: FM decoding, SSTV decoding from FM samples (probably all amplitude measurements? or is frequency easier/FFT), FFT, etc

-- Input: I/Q data