


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
![Screen Shot 2022-12-16 at 10 18 13 PM](https://user-images.githubusercontent.com/3889468/208106973-199c6432-2224-409a-8ec7-19633170df83.jpg)

```
bundle exec guard



```
