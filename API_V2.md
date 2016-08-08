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
{"total":20,"page":1,"answers":["It is certain","It is decidedly so", ...]}
```

## POST /answers

Add a new answer.

**Parameters**

  * `answer` - the answer

**Example request**

```
curl -H 'Content-Type: application/json' -X POST u foo:123 \
  -d '{ "answer": "I\u0027ve got a bad feeling about this" }' localhost:8080/api/answers
```

**Example response**

```
{"answers":["It is certain",...,"I've got a bad feeling about this"]}
```

## PUT /answers

Update an answer.

**Parameters**

  * `answer` - the answer
  * `value` - the new answer value

**Example request**

```
curl -H 'Content-Type: application/json' -X PUT -u foo:123 \
  -d '{ "answer": "Very doubtful", "value": "Extremely doubtful" }' \
  localhost:8080/api/answers
```

**Example response**

```
  {"answers":["It is certain",...,"Extremely doubtful"]}
```

## DELETE /answers

Delete an answer.

**Parameters**

  * `answer` - the answer to delete

**Example request**

```
curl -H 'Content-Type: application/json' -X DELETE -u foo:123 \
  -d '{ "answer": "My reply is no" }' localhost:8080/api/answers
```

**Example response**

```
{"answers":["It is certain",...,"Outlook not so good"]}
```
