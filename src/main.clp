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
    (while (and(neq ?HBsAg positive)(neq ?HBsAg negative)) 
        (printout t "HBsAg is positive?" crlf)
        (bind ?HBsAg (read))
    )
    (modify ?x (HBsAg ?HBsAg))
)

; kiri pohon

(defrule inputAHDV
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHDV ?AHDV &:(eq ?AHDV "")) (HBsAg ?hbsag &:(eq ?hbsag positive)))
    =>
    (printout t "Anti-HDV is positive?" crlf)
    (bind ?AHDV (read))
    (while (and(neq ?AHDV positive)(neq ?AHDV negative)) 
        (printout t "Anti-HDV is positive?" crlf)
        (bind ?AHDV (read))
    )    
    (modify ?x (AHDV ?AHDV))
)

(defrule inputAHBc-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBc ?AHBc &:(eq ?AHBc "")) (AHDV ?AHDV &:(eq ?AHDV negative)))
    =>
    (printout t "Anti-HBc is positive?" crlf)
    (bind ?AHBc (read))
    (while (and(neq ?AHBc positive)(neq ?AHBc negative)) 
        (printout t "Anti-HBc is positive?" crlf)
        (bind ?AHBc (read))
    )
    (modify ?x (AHBc ?AHBc))
)

(defrule inputAHBs-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBs ?AHBs &:(eq ?AHBs "")) (AHBc ?AHBc &:(eq ?AHBc positive)))
    =>
    (printout t "Anti-HBs is positive?" crlf)
    (bind ?AHBs (read))
    (while (and(neq ?AHBs positive)(neq ?AHBs negative)) 
        (printout t "Anti-HBs is positive?" crlf)
        (bind ?AHBs (read))
    )
    (modify ?x (AHBs ?AHBs))
)

(defrule inputAHBcIgM
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM "")) (AHBs ?AHBs &:(eq ?AHBs negative)) (HBsAg ?hbsag &:(eq ?hbsag positive)))
    =>
    (printout t "IgM Anti-HBc is positive?" crlf)
    (bind ?AHBcIgM (read))
    (while (and(neq ?AHBcIgM positive)(neq ?AHBcIgM negative)) 
        (printout t "IgM Anti-HBc is positive?" crlf)
        (bind ?AHBcIgM (read))
    )
    (modify ?x (AHBcIgM ?AHBcIgM))
)

(defrule Uncertain-1
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHDV ?AHDV &:(eq ?AHDV negative)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs positive))) 
    =>
    (modify ?x (Hasil "Uncertain Configuration"))
)

(defrule Uncertain-2
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc negative)))
    =>
    (modify ?x (Hasil "Uncertain Configuration"))
)

(defrule Hepatitisbd
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV positive)))
    =>
    (modify ?x (Hasil "Hepatitis B + D"))
)

(defrule Acuteinfect
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM positive)))
    =>
    (modify ?x (Hasil "Acute Infection"))
)

(defrule Chronicinfect
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag positive)) (AHDV ?AHDV &:(eq ?AHDV negative)) (AHBc ?AHBc &:(eq ?AHBc positive)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBcIgM ?AHBcIgM &:(eq ?AHBcIgM negative)))
    =>
    (modify ?x (Hasil "Chronic Infection"))
)


; right tree
(defrule inputAHBs-2
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBs ?AHBs &:(eq ?AHBs "")) (HBsAg ?hbsag &:(eq ?hbsag negative)))
    =>
    (printout t "Anti-HBs is positive?" crlf)
    (bind ?AHBs (read))
    (while (and(neq ?AHBs positive)(neq ?AHBs negative)) 
        (printout t "Anti-HBs is positive?" crlf)
        (bind ?AHBs (read))
    )
    (modify ?x (AHBs ?AHBs))
)

(defrule inputAHBc-2
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (AHBs ?AHBs &:(neq ?AHBs "")) (AHBc ?AHBc &:(eq ?AHBc "")) (HBsAg ?hbsag &:(eq ?hbsag negative)))
    =>
    (printout t "Anti-HBc is positive?" crlf)
    (bind ?AHBc (read))
    (while (and(neq ?AHBc positive)(neq ?AHBc negative)) 
        (printout t "Anti-HBc is positive?" crlf)
        (bind ?AHBc (read))
    )
    (modify ?x (AHBc ?AHBc))
)

(defrule Cured
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag negative)) (AHBs ?AHBs &:(eq ?AHBs positive)) (AHBc ?AHBc &:(eq ?AHBc positive)))
    => 
    (modify ?x (Hasil "Cured"))
)

(defrule Vaccinated
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag negative)) (AHBs ?AHBs &:(eq ?AHBs positive)) (AHBc ?AHBc &:(eq ?AHBc negative)))
    =>
    (modify ?x (Hasil "Vaccinated"))
)

(defrule Unclear
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag negative)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBc ?AHBc &:(eq ?AHBc positive)))
    =>
    (modify ?x (Hasil "Unclear (possible resolved)"))
)

(defrule HealthynotVacOrSus
    ?x <- (userInput (Hasil ?h &:(eq ?h none)) (HBsAg ?hbsag &:(eq ?hbsag negative)) (AHBs ?AHBs &:(eq ?AHBs negative)) (AHBc ?AHBc &:(eq ?AHBc negative)))
    =>
    (modify ?x (Hasil "Healthy not vaccinated or suspicious"))
)

(defrule printResult
    ?x <- (userInput (Hasil ?h &:(neq ?h none)))
    => 
    (printout t "Hasil Prediksi = " ?h crlf)
)
