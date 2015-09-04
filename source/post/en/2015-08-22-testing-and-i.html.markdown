---
layout: post
title: "My love hate relationship with testing"
date: 2015-08-22 13:51 UTC
tags: ruby, testing
cover: love-hate.jpg
lang: en
---
During all this year writing code, I've been living a strange hate, love relationship with testing. I got some opinion about testing in software development and what I believe is not so black and white. 
But first let's talk about the different phase with testing. 

READMORE
## My phases :
### Ignorance
At first I learn in school, and testing was not somthing we talked about. And for a while I believed software was just about writing code and it will always works

### Magic
After my first fights with programs and my first failure delivering software, I was thinking that testing would magically make disapear every bugs, and I would write better code. 
My first attempt to develop and test was a real desaster. I tried to start test based on couple of really enthousiastic article about testing. I was obsess with test coverage and I believed that if I got 100% test coverage my software will be perfect.
I was so wrong, so lost and so naive. So after I blow the project, the magic was gone. And I came to the next phase

### Skepticism
I was thinking testing, it's just a hype. It has no place in real software devlopment. And I did not want to write any test. But fortunatly I met someone who changed my mind about this. 
This guy was really brilliant, he could always find a way to do what was required. And his code was really elegant and easy to write and on the top of that he always test his code. 
He explained me that testing was part of the process of developing. Testing gaved him a really strong focus. My mind changed, I still did not try to write code, but I start to read other test and be more curious about this. 
I became more relax with testing, why not give an other chance?

### Testing curious

I change my mindset and I also change my work. For the first time I will be the only one developer taking care of a single project. Because I did not know anything about the project. I start to write some test, to learn and to see how the software was working. 
I was writting my test like "What's happen if I send this data? If I'm connected as an admin will I see this tab?". It was more an exploratory approch. Also no one else was reading my code, so I was free to write any test I wanted. For my first hard feature to develop, I notice I needed a way to make sure my application was working while I was coding. And I start to write some test in advance or right after I wrote my code. 
I was starting doing some TDD and I came to my next phase...

### Enthusiastic
I finaly started to believe that's testing could be something useful. Each time I had something to develop something, I started to think how I could test it? I also start to write some code design to be tested. Off course I was not testing 100% of my code, some easy or really trivial was left without test.
And I came to my current state with testing...

### Friendly
So now I'm in peace with testing. I know now that's testing by himself doesn't do any miracle, and testing for increasing code coverage is pointless.
I know that's testing is one tool to make your life easier, if you use this tool right. Testing also give you a strong focus, it limitate [overengineering](https://www.wikiwand.com/en/Overengineering) by forcing us to specify what we will code. I also know that there is some small bug fix and small change wich can live without beeing tested. 

#My opinion

Now testing is something natural, however it's not perfect and not automatic. Now I could sum up my ground to write test: 

 - Do I will make a change on it in the future?
 - Do I want to documente this?
 - This code is or will be critical?

If I answer yes to one or more of this question I will most likely write a test. 
