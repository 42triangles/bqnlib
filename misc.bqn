⟨Test⟩ ← •Import "testing.bqn"
⟨PArr,PNum,PChr,PFun,P1Md,P2Md,PNS,PPrimIsh,PNull,PArr1,_pInArr,PStr,PStr1,_pRec
 Ap,Ap2,else,_f⟩ ⇐ •Import "miscbase.bqn"

1 Test PNum‿PStr _pRec 0‿"hi"
0 Test PNum‿PStr _pRec 0‿⟨'h', 'i', 0⟩
0 Test PNum‿PStr _pRec 'h'‿"i"

"empty arrays disappear" Test "empty arrays{𝕩} disappear"_f ⟨⟩
"strings get inserted as is" Test "{𝕩} get inserted as is"_f "strings"
"same with chars" Test "same with {𝕩}hars"_f 'c'
expected ← "everything else gets passed through •Fmt: 2, ⟨ 2 2 ⟩, ⟨ 'x' 2 ⟩, ⟨ ⟨ ""hi"" ⟩ ⟩"
fmts     ← "everything else gets passed through •Fmt: {𝕨}, {⋈˜𝕨}, {'x'⋈𝕨}, {⋈⋈𝕩}" 
expected Test 2 fmts _f "hi"
"3 + 2 = 5" Test 3 "{𝕨} + {𝕩} = {+}"_f 2

# dynamic repeat
_DR_ ⇐ {count ← 𝕨𝔾𝕩 ⋄ next ← (0=count)⊑⟨𝔽_𝕣_𝔾,⊢⟩ ⋄ 𝕨Next𝕨𝔽⍟count𝕩}
3 Test {+} {1𝕎𝕩}_DR_(3≠⊢) ¯1  # Works dyadically, works with functions in 𝕨
3 Test ({𝕏1+⊢}_DR_{3≠𝕏0} {1+⊢}){𝔽}0  # Works monadically, works with functions in 𝕩
3 Test (1+⊢)_DR_(-·×3-˜⊢) 9  # Can do negative steps (if the function on the left is reversible)
3 Test (1+⊢)_DR_(2×2>⊢) 1  # Can use counts other than 1, 0 and ¯1, it works with any count

# dynamic repeat for fix points
_FP_ ⇐ {⊑𝕨𝔽¨_DR_(·𝔾´⊢)⟨𝕨𝔽𝕩,𝕩⟩}
0 Test (2÷˜⊢)_FP_≠ 10  # works monadically
0 Test 2 ÷˜_FP_≠ 10  # works dyadically

# Atlas
_atl ⇐ {𝕗_𝕣 r: {𝕏r}¨𝕗 ; l𝕗_𝕣 r: {l𝕏r}¨𝕗}
⟨2‿1‿0‿¯1,4,1‿0‿¯1‿¯2,¯2⟩ Test ⟨-,≠,⌽,+´⟩_atl ¯2‿¯1‿0‿1

# Defaults
_LD_ ⇐ {(𝕨⊣𝕗)𝔾𝕩}
_RD_ ⇐ {𝕗_LD_(𝔾˜)˜}

RangeE ⇐ 0 _LD_(⊣+ ·(×× ·↕ ××⊢) ⊢-⊣)
1‿2‿3 Test 1 RangeE 4
⟨⟩ Test 1 RangeE 1
1‿0 Test 1 RangeE ¯1
0‿¯1‿¯2 Test RangeE ¯3

RangeI ⇐ 0 _LD_(⋈∘⊢∾˜ ⊣RangeE⊢)
1‿2 Test 1 RangeI 2
⟨1⟩ Test 1 RangeI 1
1‿0 Test 1 RangeI 0
0‿1‿2‿3 Test RangeI 3
