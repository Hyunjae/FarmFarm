## 1. 제작 기간 & 참여 인원
- 2022년 12월 12일 ~ 2023년 1월 11일
- 6인 팀 프로젝트

<br>

## 2. 사용 기술

#### `Back-end`

  - Java 11
  - Spring 3.9.18
  - Maven
  - Oracle 21C
  - Apache Tomcat 9.0
  - Spring Security
  - Mybatis
#### `Front-end`
  - HTML/CSS
  - Javascript

<br>

## 3. ERD 설계
![farmfarm ERD](https://user-images.githubusercontent.com/110653575/216096409-23864202-486c-4dbb-a65f-9d7aebd232ad.png)

## 4. 핵심 기능

<details>
<summary><b>핵심 기능 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 장바구니

<img src="https://user-images.githubusercontent.com/110653575/216096694-c254d362-de04-437b-9a98-7c1e92f01758.png" width="50%"/>

<br>

- 회원번호와 제품번호 복합키를 통해 저장된 장바구니 테이블에서 회원별로 모든 장바구니 제품 조회
  * 품절된 상품의 경우 품절 표시 및 선택/주문 불가 처리
  * 재고 수보다 많은 수가 장바구니에 담길 경우 재고 수만큼으로 수량 맞춤
  * 장바구니 추가시 기존에 있는 제품일 경우 수량만 증가
- 회원의 주소 조회, 배송지 추가/변경/삭제 가능
- 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/cart/controller/CartController.java)
  * [DAO](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/cart/model/dao/CartDAO.java)
  * [Service](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/cart/model/service/CartServiceImpl.java)

<br>
<br>

### 4.2. 쇼핑몰 상품 등록/수정

<img src="https://user-images.githubusercontent.com/110653575/216112177-ef236e62-c481-4dce-8416-0dae6e32c226.JPG" width="38.5%"/><img src="https://user-images.githubusercontent.com/110653575/216112197-f1dddf09-85fa-4070-b91d-2e93393cfa98.JPG" width="40%"/>

### 4.3. 쇼핑몰 상품 재고관리


### 4.4. 주문내역 기간조회/검색

![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_service1.png)


### 4.5. 주문내역 배송조회

![](https://zuminternet.github.io/images/portal/post/2019-04-22-ZUM-Pilot-integer/flow_repo.png)

- **컨텐츠 저장** :pushpin: [코드 확인]()
  - URL 유효성 체크와 이미지, 제목 파싱이 끝난 컨텐츠는 DB에 저장합니다.
  - 저장된 컨텐츠는 다시 Repository - Service - Controller를 거쳐 화면단에 송출됩니다.


### 4.6. 판매자 페이지 상품조회

</div>
</details>

</br>

## 5. 핵심 트러블 슈팅
### 5.1. 장바구니 실시간 재고 수 미반영으로 인한 재고 수 초과 / 품절

- 장바구니에 없던 제품을 추가하거나 장바구니 내에서 수량을 증가할 경우에는 <br>
  재고수와 비교해서 초과되지 못하게 화면상 제어를 했습니다.
- 하지만 이미 담겨 있는 상품의 경우 장바구니에 수가 update만 되기 때문에 <br>
  재고를 초과한 주문이 가능해지고, 마이너스(-) 재고가 되는 경우가 발생 했습니다.
<br><br>

- 품절의 경우에도 이미 담겨 있는 상품이 품절될 경우에 대한 실시간 반영이 안되었습니다.

<br>

<details>

<summary><b>기존 코드</b></summary>
<div markdown="1">
  
<br>
  
- DAO
~~~java
public List<Cart> selectCartList(int memberNo) {

  return sqlSession.selectList("cartMapper.selectCartList", memberNo);
}
~~~
  
- mapper
~~~sql
<select id="selectCartList" resultMap="cart_rm">
  SELECT C.PRODUCT_NO, PRODUCT_NAME, PRODUCT_AMOUNT, STOCK, 
    TO_CHAR(PRODUCT_PRICE, 'FM999,999,999,999') PRODUCT_PRICE,
    TO_CHAR(PRODUCT_PRICE*PRODUCT_AMOUNT, 'FM999,999,999,999') PRODUCT_TOTAL_PRICE,
    (SELECT PRODUCT_IMG_ADDRESS FROM PRODUCT_IMG PI
    WHERE PI.PRODUCT_NO = C.PRODUCT_NO
    AND PRODUCT_IMG_ORDER=0) PRODUCT_IMG
  FROM CART C
  JOIN PRODUCT P ON(C.PRODUCT_NO = P.PRODUCT_NO)
  WHERE C.MEMBER_NO = #{memberNo}
  ORDER BY SOLDOUT_FL
</select>
~~~
</div>
</details>
  
  
<details>
  
<summary><b>변경된 코드</b></summary>
<div markdown="1">

<br>
  
- DAO
~~~java
public List<Cart> selectCartList(int memberNo) {
		
  // 장바구니 중 재고보다 많은 경우 조회해서 수량을 재고 수로 낮춤
  int result = sqlSession.update("cartMapper.updateOverStock", memberNo);
	
  return sqlSession.selectList("cartMapper.selectCartList", memberNo);
}
~~~
  
- mapper
~~~sql
<update id="updateOverStock">
  UPDATE CART C
  SET PRODUCT_AMOUNT =
    (SELECT STOCK FROM PRODUCT P
    WHERE C.PRODUCT_NO = P.PRODUCT_NO)
  WHERE PRODUCT_AMOUNT > 
    (SELECT STOCK FROM PRODUCT P
    WHERE C.PRODUCT_NO = P.PRODUCT_NO
    AND SOLDOUT_FL = 'N')
  AND MEMBER_NO=#{memberNo}
</update>
  
<select id="selectCartList" resultMap="cart_rm">
  SELECT C.PRODUCT_NO, PRODUCT_NAME, PRODUCT_AMOUNT, STOCK, SOLDOUT_FL,
    TO_CHAR(PRODUCT_PRICE, 'FM999,999,999,999') PRODUCT_PRICE,
    TO_CHAR(PRODUCT_PRICE*PRODUCT_AMOUNT, 'FM999,999,999,999') PRODUCT_TOTAL_PRICE,
    (SELECT PRODUCT_IMG_ADDRESS FROM PRODUCT_IMG PI
    WHERE PI.PRODUCT_NO = C.PRODUCT_NO
    AND PRODUCT_IMG_ORDER=0) PRODUCT_IMG
  FROM CART C
  JOIN PRODUCT P ON(C.PRODUCT_NO = P.PRODUCT_NO)
  WHERE C.MEMBER_NO = #{memberNo}
  ORDER BY SOLDOUT_FL
</select>
~~~

</div>
</details>
  
- 회원별로 장바구니 조회 시에 장바구니에 담긴 수량이 재고 수량보다 많은 경우,<br>
  재고 수 만큼으로 update 진행하는 코드를 추가하여 실시간으로 재고 수 반영이 되도록 하였습니다.
  
- 품절의 경우 비교적 쉽게 mapper에 SOLDOUT_FL를 추가하여 <br>
  장바구니를 조회할 때마다 확인할 수 있도록 하였습니다.
  

    
## 6. 회고 / 느낀점
>프로젝트 개발 회고 글: https://zuminternet.github.io/ZUM-Pilot-integer/

