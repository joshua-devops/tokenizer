# tokenizer -- A simple way of tokenizing a string

Demonstration of how to tokenize a string in Ruby using regular expressions.

### Instructions
In order to tokenize a string, then go through and perform the following steps:
1. Create a file containing definitions for each token type you aim to tokenize. It should follow the followin format.
```
(?<REGEX-KEY>REGEX-VALUE)
```
Each line should represent its own token definition. REGEX-KEY is the name of the token type, whereas REGEX-VALUE provides the actuall regular expression. Here's an example:
```
(?<MATH_TRIG>sin|cos|tan)
```
There is actually one mandatory token definition that always needs to be added. It helps with moving pass unnecessary whitespace without. It should be placed at the bottom, or skipped in case whitespace were part of a token definition. It should look like this:
```
(?<WS>[\s]+)
```
2. Create an instance of Stream and provide the path to the file created above as its sole argument.
```ruby
tok = Tokenizer.new("math.clazz")
```

3. Using the Stream instance, invoke the tokenize method with the desired string to tokenize as its argument. 
```ruby
stream = tok.tokenize("y = 10x - 5")
```
(In order to remove all whitespace from the string, pass the `remove_ws=true` argument. It's false by default.) The tokenize method saves the tokens in a private property called tokens. In order to access the tokens use the various methods (each, get_\*, has_\*, rem_\*, etc.) provided.
