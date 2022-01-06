⟨Test⟩ ← •Import "testing.bqn" ⋄ Ap‿_f ← •Import "misc.bqn"

Ex ← ⊢ ⋄ TestEx ← {𝕨Test Ex 𝕩}

Const ⇐ {𝕩˙⊸⋈}
epsilon ⇐ Const⟨⟩
Fail ⇐ {(⋈𝕩)˙}
42‿"foo" Test "foo" Ap˜ Const 42 ⋄ ⟨"bar"⟩ Test "foo" Ap˜ Fail "bar"

_bindPlus ⇐ {n‿p _𝕣 f: {(2=≠)◶⟨(𝕩˙Ap˜·N⊑),{(P𝕨){𝔽}𝕩}´⟩F𝕩}}
_bind ⇐ {Fail‿𝔽_bindPlus 𝕩}

Tag ⇐ {𝕩⊸(≤○≠◶0‿(⊣≡≠⊸↑))◶⟨⋈"expected {⊢}"_f𝕩,𝕩⋈ (≠𝕩)↓⊢⟩}
ex ↩ Tag "foo" ⋄ "foo"‿"" TestEx "foo" ⋄ "foo"‿"bar" TestEx "foobar"
                 ⟨"expected foo"⟩ TestEx "fo"

_map ⇐ {Const∘𝔽_bind 𝕩}
ex ↩ ⊑_map Tag "foo" ⋄ 'f'‿"bar" TestEx "foobar"
                       ⟨"expected foo"⟩ TestEx "bar"

_maperr ⇐ {(Fail∘𝔽)‿Const _bindPlus 𝕩}
ex ↩ 5⊸↑_maperr Tag "foo" ⋄ "foo"‿"bar" TestEx "foobar"
                            ⟨"expec"⟩ TestEx "bar"

Or ⇐ {a𝕊b: {⋈∘𝕩⊸("{⊑⊣} / {⊢}"_f) _maperr b}‿Const _bindPlus a}
ex ↩ "foo" Or○Tag "bar" ⋄ "foo"‿"bar" TestEx "foobar" ⋄ "bar"‿"" TestEx "bar"
                          ⟨"expected foo / expected bar"⟩ TestEx "baz"
                          "foobar"‿"" Test "foobar" Ap˜ "foobar" Or○Tag "foo"
                          "foo"‿"bar" Test "foobar" Ap˜ "foo" Or○Tag "foobar"

_validtoerr ⇐ {(≠∘⊑◶⟨Const 1⊑⊢,⊑⟩ 𝔽⋈⊢)_bind 𝕩}
ex ↩ (3=≠)◶⟨"expected three chars"⟩‿⟨⟩_validtoerr "foobar" Or○Tag "foo"
  "foo"‿"baz" TestEx "foobaz"
  ⟨"expected three chars"⟩ TestEx "foobar"
  ⟨"expected foobar / expected foo"⟩ TestEx "baz"

_validerr_ ⇐ {𝔽◶⟨𝔾⟩‿⟨⟩_validtoerr𝕩}
ex ↩ (3=≠)_validerr_"expected three chars" "foobar" Or○Tag "foo"
  "foo"‿"baz" TestEx "foobaz" ⋄ ⟨"expected three chars"⟩ TestEx "foobar"

_valid ⇐ {𝔽_validerr_"validation failed" 𝕩}

Maybe ⇐ ⋈_map Or (Const ⟨⟩)˙
ex ↩ Maybe Tag "foo" ⋄ ⟨"foo"⟩‿"bar" TestEx "foobar"
                       ⟨⟩‿"bar" TestEx "bar"

End ⇐ (0=≠)◶⟨⋈"expected end of input",⋈˜⟨⟩⟩
ex ↩ end ⋄ ⟨⟩‿"" TestEx ""
           ⟨"expected end of input"⟩ TestEx "foo"

Repeat0 ⇐ {⟨(Const 𝕩)˙,𝕨˙𝕊𝕩∾⋈⟩_bindPlus 𝕨}⟜⟨⟩
ex ↩ Repeat0 Tag "foo" ⋄ ⟨"foo","foo","foo"⟩‿"bar" TestEx "foofoofoobar"
                         ⟨⟩‿"bar" TestEx "bar"

any ⇐ {(0≠≠)◶⟨⋈"unexpected end of input", ⊑⋈1⊸↓⟩}
ex ↩ any ⋄ 'f'‿"oo" TestEx "foo"
           ⟨"unexpected end of input"⟩ TestEx ""

Anyof ⇐ {⊑∘∊⟜𝕩_validerr_("expected any of '{⊢}'"_f𝕩) any}
⟨"acba", "dba"⟩ Test "acbadba" Ap˜ Repeat0 Anyof "abc"
⟨"expected any of 'abc'"⟩ Test "d" Ap˜ Anyof "abc"

Pair ⇐ {𝕩˙⊸{𝕩⊸⋈_map𝕨}_bind𝕨}
ex ↩ "foo" Pair○Tag "bar"
  ⟨"foo","bar"⟩‿"baz" TestEx "foobarbaz"
  ⟨"expected foo"⟩ TestEx "barbaz" ⋄ ⟨"expected bar"⟩ TestEx "foobaz"

_mappair ⇐ {𝕗´_map𝕨Pair𝕩}
Left ⇐ ⊣_mappair
Right ⇐ ⊢_mappair
Repeat1 ⇐ ⊢ ⋈⊸∾_mappair Repeat0
Manyof0 ⇐ Repeat0∘Anyof
Manyof1 ⇐ Repeat1∘Anyof
ThenEnd ⇐ Left⟜(end˙)
