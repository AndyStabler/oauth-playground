## Offline Hack

I'm currently on a long haul flight with no Wi-Fi. For fun I've decided to see how much OAuth I can remember and if I can create a working example in Ruby.

It turns out that I Google almost everything and I know nothing.

But not being able to just find the answer to something is turning out to be a lot of fun. For example, I'm taking a TDD approach and wanting my tests to run all the time. I can't remember how to configure Guard (I'd just Google it usually 😄). So I'm using the following command:

```sh
repeat 300; sleep 5 && rspec;
```

Why aren't using some kind of `while true` you ask. Well the answer is because I can't remember how.

I'm being forced to come up with creative ways to achieve things I'd usually spend no time thinking about.
This means that there's most likely some more unusual things going on here (the Oauth flow might not be correct 😬), but my knowledge gaps seem clearer to me now.

Have you tried this before? How was it for you? Do you have any other fun suggestions for a long haul flight?
