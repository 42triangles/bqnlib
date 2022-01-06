else‿_f ← •Import "miscbase.bqn"
testing ← 1
testCount ← 0
Test ⇐ {
  testing? testCount ↩ 1+testCount ⋄ 𝕨("Expected {⊣} found {⊢}"_f ! ≡)𝕩 ;
  else?    1
}
Report ⇐ {
  testing? •Out "Passed {⊢} tests"(•Import "misc.bqn")._f testCount⊣𝕩 ;
  else?    1
}
