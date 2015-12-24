---
title: This programming lesson you've learn the hard way
date: 2015-12-18 06:28 UTC
tags: opinion, ruby
lang: en
cover: fabien-fabian.jpg
---

Developing is not an easy task, and many people have a strong opinion on how to do it. 
Sometime you feel that people over react for no reason. 
And it will be easier to be a little bit more flexible, that's what you believe till you understand why.  
READMORE

## Use [versioning Software](https://www.wikiwand.com/en/Software_versioning)

Well at first you write code in a file and you do not really care about the future of it. 
I realized that in school too late off course. I was coding a small exercise in Java, at some point I got my software to works, great! But the name of some function and some attribute was not good enough, so off course I start to make some changes. 
After a while my teacher choose this moment to come over my shoulder and check if my software works, and off course it was not working, no matter how fast I was pressing `Ctr + Z` to go back my previous working version. 
After that I start to use SVN for every single lines I will write (including reports)

## Use Git

When I first start to work in France, my company at the time was using SVN. 
And I was thinking it was wise, indeed Git a decentralized versionning system seems to me overkill, too hard to understand, and too fancy.
Till the day I must develop a feature on a project and also hot fix couple of bugs. 
Off course everything was fine till the day I need to switch from one feature to an other, or too merge them. The number of conflict and the quantity of work to do something so stupid like a merge drive me insane. 
I left the company not too long after and I start using Git right after

## Write good commit message

One day I was trying to understand a piece of code and in order to have more info I started to dig into commit message of this code. 
Here is what I found on the specific line I tried to understand so badly : 

> WIP

Good luck trying to understand that. But having longer commit is not always better, the other day I was in the exact same situation, trying to understand one other point of the code and I start to look the commit log and then I found a commit message 486 lines long. 

Again Good luck trying to understand that. 
Since this two bad experience I do not care how many commit I do, as long as the files changes and the commit message are into a logical package. 

## Write real and good test 

Alright this part is really subjective, but I found many test who only test the framework or the structure of the database.
What is the point of this kind of test? Increase the test coverage? It's simply stupid. I'll give you an example :

```ruby
context 'schema' do
  context 'fields' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:organization_id).of_type(:integer) }
  end
end
context 'relations' do
  it { should belong_to(:app) }
  it { should belong_to(:organization) }
end
context 'validations' do
  it { should validate_presence_of(:app) }
  it { should validate_presence_of(:organization) }
end
```

The field `id` should be an Integer? This is really precious information and I'm pretty sure somebody need to check it. 
You only test the structure of the database or the framework, but you don't test anything useful. To sum up I'll say:

> Bad testing in software is like Kung Fu in street fight, you feel secure and fancy but when shit happen you are completely powerless.

And I know also this [topic](http://fabfight.com/)... 
 
## Change test only if you understand them

This story happen to one colleague of my, he was fixing a bug and one of my tests was blocking him to deploy his change.
So to solve his issue he changed my test to make sure they will be green.
So he could deploy his change and end up in a shit storm because other part of the software broke. 
He spend lot of time trying to fix everything and he learned the hard way he will never do it again.
A test is like a specification of your software, if you need to change the way your software behave it's ok to change related test, but if you change a test without understanding it, prepare yourself to enter into a shit storm. 

## Do not try to be smart

Sometime you see cool stuff on the Internet to write shorter and shorter code. 
The problem with the fancy staff or clever is that you can forget what it does. 
And when it will happen to you, you will not feel smart anymore. 
Worst is when you can't understand code of one of your colleague, you maybe know this feeling?
So never, never try to be smart when you write code, sure you might impress couple of dude in a convention but most likely your coworkers will hate you.

## What about you?

I certainly forget few point, but what are the lessons you've learned in programming? And how did you learned? Do you agree with my list? 

Comment bellow ...
