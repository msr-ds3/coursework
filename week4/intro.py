# coding: utf-8
l = ['a', 1]
l
l.append(4.3)
l
len(l)
l[0]
l[1:]
l[1:len(l)]
l[1:2]
for li in l:
    print li

for i in range(0, len(l)):
    print i

len(l)
for i in range(0, len(l)):
    print l[i]

l = [2, -3, 1.2]

for li in l:
    print li*li

for li in l:
    print li**2

[li*li for li in l]
def f(x):
    return x*x
[f(li) for li in l]
def f(x):
    x_squared = x*x
    return x_squared
[f(li) for li in l]
[li_squared=f(li) for li in l]
l = [2, -3, 1.2]
t = (2, -3, 1.2)
l
t
t[0]
t[0]**2
t.append(3)
t[0] = 3
d = {'a': 1, 35: 'z'}
d
d['a']
d[35]
d = {'jake': 34, 'justin': 32}
d['jake']
d['mykids'] = l[1.2, 3.4]
d['mykids'] = [1.2, 3.4]
d
d = {'jake': 34, 'justin': 32}
'jake' in d
'bob' in d
34 in d
d.values()
d.keys()
'jake' in d.keys()
d.items()
for first_name in d:
    print first_name

for first_name in d:
    print first_name, d[first_name]

for k in d:
    print k, d[k]

for v in d.values():
    print v

d.values()
for k in d.keys():
    print k

for k,v in d.items():
    print k, v

's'.upper()
for k in d:
    print k[0].upper() + k[1:]

[k[0].upper() + k[1:] for k in d]
d = {'jake': 34, 'justin': 32}
for k,v in d.items():
    if v >= 34:
        print k

[k[0].upper() + k[1:] for k,v in d.items() if v >= 34]
items = d.items()
dict(items)
d = dict()
d = {}
d['money'] += 1
if 'money' not in d:
    d['money'] = 1
else:
    d['money'] += 1
d['money'] += 1
d['money'] += 1

from collections import defaultdict
d = defaultdict(int)
d['meeting'] += 1
d['cats']
d = defaultdict(lambda x: defaultdict(int))
def dict_int():
    return defaultdict(int)
d = defaultdict(dict_int)
d['spam']
d['spam']['money'] += 1
d['spam']['money'] += 1
d['ham']['money'] = 6
d['spam']['enron'] = 0
'this is a sentence'.split()
'this_is_a_weird_sentence'.split('_')
'this_is_a_weird_sentence'.split()
words = 'this is a sentence'.split()
words
words[0]
first, second, third, fourth = 'this is a sentence'.split()
first
article = 'this is the beginning of an article'
for word in article.split():
    print word
article = 'this is an article about money money appears a lot in this article money'
article.split()
set(article.split())
set(article.split()) - set(['in','the'])
'about' in set(article.split())
'else' in set(article.split())
article = 'this is an article about money. money appears a lot in this article. money.'
article.split()
