# get-elements

get-elements is a very easy common-lisp library which allows simple acces to s-expressions.
I use it to extract information from s-expressions which are the result of parsing websites.


## API
```cl
(by-tag-name (tree tag-name &key (recursive t) (test #'equal))
```
* tree: s-expression
* tag-name: search value (must be the first value of a list in the s-expression)
* recursive (optional): if nil then search just in the first layer of s-expression hierarchy
* test (optional): Testfunction for comparison of tag-name with items in list

```cl
(by-path (tree path &key (test #'equal) (relative-path t))
```
* tree: s-expression
* path: list with hierarchy to search for
* test (optional): Testfunction for comparison of tag-name with items in list
* relative-path (optional): if nil then the path must start at toplevel of s-expression



## Dependencies
None.

## Development
Developed with SLIME, SBCL and EMACS on Debian GNU/Linux


## Examples

by-tag-name:

```cl
GET-ELEMENTS> (by-tag-name '(A) 'a)
NIL
GET-ELEMENTS> (by-tag-name '((A)) 'a)
((A))
GET-ELEMENTS> (by-tag-name '( (a) (b) ) 'a)
((A))
GET-ELEMENTS> (by-tag-name '( (a) (b) (a b) ) 'a)
((A) (A B))
GET-ELEMENTS> (by-tag-name '( (a) (b) (a b) (a a (b (a 'hello))) ) 'a)
((A) (A B) (A A (B (A 'HELLO))) (A 'HELLO))
```

by-path

```cl
GET-ELEMENTS> (by-path '(a) '(a))
NIL
GET-ELEMENTS> (by-path '((a)) '(a))
((A))
GET-ELEMENTS> (by-path '( (a) (b) ) '(a))
((A))
GET-ELEMENTS> (by-path '( (a (b c) ) (b) ) '(a))
((A (B C)))
GET-ELEMENTS> (by-path '( (a (b c) ) (b) ) '(a b))
((B C))
GET-ELEMENTS> (by-path '( (a (b c) ) (b (a (b 'hello))) ) '(a b))
((B C) (B 'HELLO))
GET-ELEMENTS> (by-path '( (a (b c) ) (b (a (b 'hello))) ) '(a b) :relative-path nil)
((B C))
GET-ELEMENTS> (by-path '( (a (b c) ) (b (a (b 'hello))) ) '(b a b) :relative-path nil)
((B 'HELLO))
```

## See Also:
http://shinmera.github.io/CLSS/
