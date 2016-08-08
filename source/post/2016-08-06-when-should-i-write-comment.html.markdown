---
lang: en
title: When should I write comment?
date: 2016-08-06 08:35 UTC
tags: opinion, code
cover: code.jpg
---

Code is like a joke, if you need to explain it it means you are dealing with a bad code/joke.
Comments in a way are like explanation.
There is as many opinion on commenting as coder.
And prepare to be amazed, dear Internet, because here is my comment on this highly commented topic.

READMORE

## The less the better

Comments is not the easiest to read in the code, it introduce a new dimension. 
This text is not executed by the computer, and there is no way to see automatically if the comment still make sense. 
So in a way comment is a second layer to maintain on your code.
Here is why I try to write as less comment as possible.
If my code need comment to be understood it is generally a code smell.
This usually the moment where I try to give more meaningful name to variable, split the code in smaller method. 
This way the code can be read without any comment and is still understandable.

## Sometime comment is the only option

Even if I do not like comment there is case where you *need* them.
I think comment are not here to explain *what* you are doing but more to explain *why* you are doing.
Sometime due to some limitations you need to use some workaround, it's not nice to find this kind of code, but if someone explain you the *why* in the code, you would have the chance to take better decision with this code in the future especially if the limitation disappear in the future (For instance the version of the language, the API etc..).
Usually it's not something you have not under your direct control ...

> Write the code you want to read ...

Here is my comment on comments, feel free to comment bellow. I will read all you comments even if comment them ;-)