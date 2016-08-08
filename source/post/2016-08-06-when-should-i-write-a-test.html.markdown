---
lang: en
title: When should I write a test?
date: 2016-08-06 06:51 UTC
tags: opinion, testing
cover: unit-test.jpg
---

Here is a simple question with a not so easy answer.
Coming from industrial engineering curriculum, 
I like to transpose solution used in other field than IT.
So when should I write a test?

READMORE

### First let's tackle the obvious

Never and always are wrong answer for two different reason.
Never is acceptable if you are writing code for non professional purpose, for non maintainable project, or non presentable project.
In my daily life I am really rarely in one those situations...

Always write a test, is something I used to believe is the right way. 
Writing always is acceptable when you have unlimited resources and time is no longer an issue. 
So it actually could suit a school project.
One of the project I've made during my engineering school had a test coverage of 90%.
Every single method was tested not matter how simple was the code to test.
To learn how to test that's perfect.
But in a professional context things are different and you do not have unlimited resources.

So when should you write a test?

### Risk management to the rescue

To answer that I will reuse the concept of risks management.
Basically a risk have two attributes: an impact and a probability to occur.
The impact of the risk is what it will cost to you.
In the code you can identify a high impact code with different criteria, I would list couple of them: 

- Is this code used in a god class?
- Is this code dealing with core feature of my software?
- Is this code dealing with money?

A more simple definition would be : "This is the code you do not want to fail even in your worst nightmare".

Now the probability to occur, you can see it as how often the code you wrote will run and how many user will run this code.

We have now the main criteria to decide if we should write a test.
A test will monitor and make sure that the sensitive piece of code behave like expected.
Let's describe the most common scenarios I saw. 

### So when I write a test?

The most obvious is when you write a critical code who will run often.

What is a critical code? It depend of the nature of your software. 
If the profile picture upload stop to work, it's not a big deal if you are Github but if you are Facebook you better find a fix quickly. 

Then you need to cover the most critical and/or most used code.

The only thing I can tell you is the code with a small impact and small probability to run do not worth to be tested, at least not today because your more risky code is waiting to be tested.

What is your opinion on this topic? Do you aim a test coverage of 100% or do you have a different approach? Let me know in the comments bellow. 

