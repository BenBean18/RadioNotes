SamacSys ECAD Model
2191134/1542200/2.50/4/2/Inductor

DESIGNSPARK_INTERMEDIATE_ASCII

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r300_150"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 1.500) (shapeHeight 3.000))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(padStyleDef "s150"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 1.500) (shapeHeight 1.500))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Default"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 50 mils)
			(strokeWidth 5 mils)
		)
	)
	(patternDef "LQH43MN470K03L" (originalName "LQH43MN470K03L")
		(multiLayer
			(pad (padNum 1) (padStyleRef r300_150) (pt -1.500, 0.000) (rotation 0))
			(pad (padNum 2) (padStyleRef r300_150) (pt 1.500, 0.000) (rotation 0))
			(pad (padNum 3) (padStyleRef s150) (pt -3.000, 0.000) (rotation 90))
			(pad (padNum 4) (padStyleRef s150) (pt 3.000, 0.000) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0.000, 0.000) (textStyleRef "Default") (isVisible True))
		)
		(layerContents (layerNumRef 28)
			(line (pt -2.25 1.8) (pt 2.25 1.8) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 2.25 1.8) (pt 2.25 -1.8) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt 2.25 -1.8) (pt -2.25 -1.8) (width 0.2))
		)
		(layerContents (layerNumRef 28)
			(line (pt -2.25 -1.8) (pt -2.25 1.8) (width 0.2))
		)
		(layerContents (layerNumRef 30)
			(line (pt -4.25 2.8) (pt 4.25 2.8) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 4.25 2.8) (pt 4.25 -2.8) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 4.25 -2.8) (pt -4.25 -2.8) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt -4.25 -2.8) (pt -4.25 2.8) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -2.25 1.8) (pt 2.25 1.8) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -2.25 -1.8) (pt 2.25 -1.8) (width 0.1))
		)
	)
	(symbolDef "LQH43NH1R8J03L" (originalName "LQH43NH1R8J03L")

		(pin (pinNum 1) (pt 0 mils -100 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -125 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 2) (pt 0 mils -200 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -225 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 3) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -25 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(pin (pinNum 4) (pt 0 mils -300 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -325 mils) (rotation 0]) (justify "Left") (textStyleRef "Default"))
		))
		(line (pt 200 mils 100 mils) (pt 600 mils 100 mils) (width 6 mils))
		(line (pt 600 mils 100 mils) (pt 600 mils -400 mils) (width 6 mils))
		(line (pt 600 mils -400 mils) (pt 200 mils -400 mils) (width 6 mils))
		(line (pt 200 mils -400 mils) (pt 200 mils 100 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 650 mils 300 mils) (justify Left) (isVisible True) (textStyleRef "Default"))

	)
	(compDef "LQH43NH1R8J03L" (originalName "LQH43NH1R8J03L") (compHeader (numPins 4) (numParts 1) (refDesPrefix L)
		)
		(compPin "1" (pinName "1") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "2") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "3" (pinName "3") (partNum 1) (symPinNum 3) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "4" (pinName "4") (partNum 1) (symPinNum 4) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "LQH43NH1R8J03L"))
		(attachedPattern (patternNum 1) (patternName "LQH43MN470K03L")
			(numPads 4)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
				(padNum 3) (compPinRef "3")
				(padNum 4) (compPinRef "4")
			)
		)
		(attr "Mouser Part Number" "81-LQH43NH1R8J03L")
		(attr "Mouser Price/Stock" "https://www.mouser.co.uk/ProductDetail/Murata-Electronics/LQH43NH1R8J03L?qs=17u8i%2FzlE8%2FmRHE2WNlgfg%3D%3D")
		(attr "Manufacturer_Name" "Murata Electronics")
		(attr "Manufacturer_Part_Number" "LQH43NH1R8J03L")
		(attr "Description" "LQH43NH_03 Series Inductor 1.8uH +/-5% 1812 (4532)")
		(attr "Datasheet Link" "https://psearch.en.murata.com/inductor/product/LQH43NH1R8J03%23.html")
		(attr "Height" "2.8 mm")
	)

)
