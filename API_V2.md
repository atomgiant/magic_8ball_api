# Magic8ball V2

The Magic8ball API version 2.

## GET /shake

Shake the Magic8ball.

**Example request**

```
  curl localhost:8080/api/shake
```

**Example response**

```
  {"answer":"Ask again later"}
```

## GET /answers

*Basic auth required*

Get the list of answers.

**Parameters**

  * `page` - the page number; defaults to 1
  * `per_page` - results per page; defaults to 10

**Example request**

```
  curl -u foo:123 localhost:8080/api/answers
```

**Example response**

```
  {"total":20,"page":1,"answers":["It is certain","It is decidedly so","Without a doubt","Yes definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes"]}
```

## POST /answers

Add a new answer.

**Parameters**

  * `answer` - the answer

**Example request**

```
  curl -H 'Content-Type: application/json' -X POST -d '{ "answer": "I\u0027ve got a bad feeling about this" }' -u foo:123 localhost:8080/api/answers23 localhost:8080/api/answers
```

**Example response**

```
{"answers":["It is certain","It is decidedly so","Without a doubt","Yes definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Do not count on it","My reply is no","My sources say no","Outlook not so good","Very doubtful","I've got a bad feeling about this"]}
```

## PUT /answers

Update an answer.

**Parameters**

  * `answer` - the answer
  * `value` - the new answer value

**Example request**

```
  curl -H 'Content-Type: application/json' -X PUT -d '{ "answer": "Very doubtful", "value": "Extremely doubtful" }' -u foo:123 localhost:8080/api/answers 
```

**Example response**

```
  {"answers":["It is certain","It is decidedly so","Without a doubt","Yes definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Do not count on it","My reply is no","My sources say no","Outlook not so good","Extremely doubtful","I've got a bad feeling about this"]}
```

## DELETE /answers

Delete an answer.

**Parameters**

  * `answer` - the answer to delete

**Example request**

```
  curl -H 'Content-Type: application/json' -X DELETE -d '{ "answer": "My reply is no" }' -u foo:123 localhost:8080/api/answers
```

**Example response**

```
  {"answers":["It is certain","It is decidedly so","Without a doubt","Yes definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Do not count on it","My sources say no","Outlook not so good","Extremely doubtful","I've got a bad feeling about this"]}
```
