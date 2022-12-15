


### APIs

```
post /api/v1/users/sign_in

{
    "token_value": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwic2NwIjoidXNlcnMiLCJhdWQiOm51bGwsImlhdCI6MTY3MTAyNzEwOSwiZXhwIjoxNjcxMDMwNzA5LCJqdGkiOiIxMDJiNjkyNC1hNWU4LTQ3NTItYjljNS1kNTJhOGM0M2IwODYifQ.MuJh0Ty5-vP5LZdOPFHqmgvjOSMg6AMxXlaUPSAQQns"
}
```


```
get /api/v1/pings

{
    "result": "alive"
}
```


```
create /api/v1/admins/

head
    Authorization: TOKEN_FROM_LOGIN
body
    role
    email
    password

```

```
update /api/v1/admins/:id

head
    Authorization: TOKEN_FROM_LOGIN
body
    role
    email
    password

```

```
delete /api/v1/admins/:id

head
    Authorization: TOKEN_FROM_LOGIN

```




### Tests

```
bundle exec guard
```
