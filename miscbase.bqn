Ap ⇐ {𝕎𝕩}
Ap2 ⇐ {𝕎´𝕩}

# Type based and adjacent predicates
PArr ⇐ 0=•Type
PNum ⇐ 1=•Type
PChr ⇐ 2=•Type
PFun ⇐ 3=•Type
P1Md ⇐ 4=•Type
P2Md ⇐ 5=•Type
PNS ⇐ 6=•Type
PPrimIsh ⇐ PFun ∨ P1Md ∨ P2Md
PNull ⇐ ⟨⟩⊸≡
PArr1 ⇐ ¬∘PNull ∧ PArr
_pInArr ⇐ {PArr◶⟨0,∧´·𝔽¨⊢⟩𝕩}
PStr ⇐ PChr _pInArr
PStr1 ⇐ ¬∘PNull ∧ PStr
_pRec ⇐ {∧´𝕗Ap¨𝕩}

_fmthelp ← {
  fs ← 𝕩⊔˜+`(»≠⊢)1⌊b←+`('{'⊸= - »∘=⟜'}')𝕩
  "Unbalanced braces" ! ¬⊑¯1∊b
  exec ← •ReBQN {repl⇐"strict", primitives⇐•primitives∾⋈⟨'↙',⟨⟩˙⟩}
  ∾´(PStr+ 2×PChr)◶•Fmt‿⊢‿⋈∘𝔽∘Exec¨⌾((0‿1⥊˜≢fs)⊸/) fs
}

_f ⇐ {l f _𝕣 r: {l𝕏r}_fmthelp f ; f _𝕣 r: {𝕏r}_fmthelp f}

else ⇐ 1
