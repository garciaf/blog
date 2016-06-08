---
lang: en
title: Law and order in your css and html
date: 2016-05-01 07:25 UTC
tags: ruby, css, html, en
cover: cowboys-indians.jpg
published: true
---

Not so long time, I've been rebuilding an complete interface. 
Basically I've tried to bring law and order in the far west of a rails application.
Let's tell me my adventure...
READMORE

## Why CSS is the far west?

Most of the developer (me included) hate to make styling. 
I could thing there is two reasons for it :
- Taste is always subject of discussion and lot of the satisfaction can fade away when your customer say "Yes it's working but the label are little bit too big and I do not like so much the color you choose" so it can be really frustrating 
- Second more frustrating for a developer mind, there is no law or clear good practice (at least from where I come from) to write maintainable CSS. At least in rails if you write a template renderer in a model, you know you are doing something wrong. But for CSS I never had an opinion on what is wrong and what is right (but that was before)...

Sometime we have no other choice than to get our hands dirty and write some CSS quickly. 
"I will write one class for my object and write some style just for the element under".
I sound like a good idea at first, but if fives different persons did this for the last five year, you will end up with a lot of custom case for every single case of your application. 

## Be the change you want to see

Because of this situation if you need to add some info or change just a little the structure of your HTML, you will end up breaking everything, and good luck to find out how to fix it.

Then changing style is more and more depressive task, you know it will be long and you know you will achieve really little. 

One month ago I start to redesign our old interface. A really big one, with a lot of screen, modal and custom css. 

I knew it would be hard, and it was. I though it will be painful and it was really exciting to see thing changing so fast. 

So what I have done? I made lot of mistake on my way and here is what I learned...

##  Use a framework 

First I implemented a sass framework, bootstrap in sass.
And I also to see start how this people organized their code.

And basically everything is organized in a module. 
A module is for me a visual and consistent concept. 

Once the framework was in place I needed to adapt all the template to match with the framework, I made a discovery on the way...

## Separate concern

Here is what I find out about class naming in HTML. 
If you use a class for styling, it only does styling if you use a class for javascript it only does javascript.

And the class name you use for styling refer to the style or visual concept you want to apply *NEVER* about the object you are referring too.

This way just by reading the HTML source you will be able to distinct what is related to style and what is related to javascript. 

## Avoid deep cascading

Alright CSS contain the word cascading and at first it sound like really good concept. But in my opinion do not go deep in your cascading here is what I mean. 

```scss
.some_class {
  ...
  .some_class_more {
    ...
    .cautious {
      ...
      .this_is_dangerous {
        ...
        .good_luck_to_maintain_this {
          ...  
        }
      }
    }
  }
}
```

If you have such a deep styling, changing or adapting the structure of your template will be really hard. Also link the style who need each other. For instance I have no problem with something like this: 

```scss
.card{
  .card-header{
    ...
  }
  .card-block{
    ...
  }
  .card-footer{
    ...
  }
}
```

This cascading make sens because just by reading each class name, you can figured out how they are related without looking the style attached to it. 

## So how it look?

We manage to rebuild a really large interface. Here is one small example.
So we start from this: 
![previous-dashboard](2016-05-01-law-and-order-in-your-css-and-html/dashboard.png "previous version of the dashboard")
And we turn it into: 
![dashboard-rebrushed](2016-05-01-law-and-order-in-your-css-and-html/dashboard-rebrushed.png "new version of the dashboard")

The style should be easier to maintain and styling the application will be much more fun. This process allowed me to better understand how to organize styling and how to build interface. I even had some fun making some styling (maybe a [stockholm syndrome ?](https://en.wikipedia.org/wiki/Stockholm_syndrome)). 
I hope my little experience will be useful for you, what principle you use to organize your style? Let me know ...