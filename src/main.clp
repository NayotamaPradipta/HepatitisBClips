(deftemplate userInput
    (slot HBsAg)
    (slot AHDV)
    (slot AHBc)
    (slot AHBs)
    (slot AHBcIgM)
    (slot Hasil))
(deffacts initial-facts
    (
        userInput
        (HBsAg "")
        (AHDV "")
        (AHBc "")
        (AHBs "")
        (AHBcIgM "")
        (Hasil none)
    )
)
; akar pohon
(defrule inputHBsAg
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag "")))
    =>
    (printout t "HBsAg is positive?" crlf)
    (bind ?HBsAg (read))
    (modify ?x (HBsAg ?HBsAg))
)

; kiri pohon

(defrule inputAHDV
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHDV ?AHDV &:(eq ?AHDV "")) (HBsAg ?hbsag &:(eq ?hbsag positive)))
    =>
    (printout t "Anti-HDV is positive?" crlf)
    (bind ?AHDV (read))
    (modify ?x (AHDV ?AHDV))
)

(defrule inputAHBc-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBc ?AHBc &:(eq ?AHBc "")) (AHDV ?AHDV &:(eq ?AHDV negative)))
    =>
    (printout t "Anti-HBc is positive?" crlf)
    (bind ?AHBc (read))
    (modify ?x (AHBc ?AHBc))
)

(defrule inputAHBs-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBs ?AHBs &:(eq ?AHBs "")) (AHBc ?AHBc &:(eq ?AHBc positive)))
    =>
    (printout t "Anti-HBs is positive?" crlf)
    (bind ?AHBs (read))
    (modify ?x (AHBs ?AHBs))
)

(defrule inputAHBcIgM
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM "")) (AHBs ?AHBs &:(eq ?AHBs negative)))
    =>
    (printout t "IgM Anti-HBc is positive?" crlf)
    (bind ?AHBcIgM (read))
    (modify ?x (AHBcIgM ?AHBcIgM))
)

(defrule Uncertain-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHDV ?AHDV &:(eq ?AHDV negative)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs positive))) 
    =>
    (printout t "Uncertain Configuration" crlf)
    (modify ?x (Hasil "Uncertain"))
)

(defrule Uncertain-2
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc negative)))
    =>
    (printout t "Uncertain Configuration" crlf)
    (modify ?x (Hasil "Uncertain"))
)

(defrule Hepatitisbd
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV positive)))
    =>
    (printout t "Hepatitis B + D" crlf)
    (modify ?x (Hasil hepatitisbd))
)

(defrule Acuteinfect
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM positive)))
    =>
    (printout t "Acute Infection" crlf)
    (modify ?x (Hasil acuteinfect))
)

(defrule Chronicinfect
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM negative)))
    =>
    (printout t "Chronic Infection" crlf)
    (modify ?x (Hasil chronicinfect))
)
