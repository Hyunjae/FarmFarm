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
  * [Service](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/cart/model/service/CartServiceImpl.java)
  * [DAO](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/cart/model/dao/CartDAO.java)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/cart-mapper.xml)
  * [JS](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/webapp/resources/js/order/cart.js)
	
<br>
<br>

### 4.2. 쇼핑몰 상품 등록/수정

<img src="https://user-images.githubusercontent.com/110653575/216112177-ef236e62-c481-4dce-8416-0dae6e32c226.JPG" width="38.5%"/><img src="https://user-images.githubusercontent.com/110653575/216112197-f1dddf09-85fa-4070-b91d-2e93393cfa98.JPG" width="40%"/>

<br>

- 상품 등록 시
  * 신규 상품 등록 후 상품 번호를 받아와 이미지 삽입
  * 썸네일은 이미지 미리보기로 제공, 상품 설명 이미지 파일은 파일 명으로 표시
  * 게시글 필수 내용 유효성 검사 진행
- 상품 수정 시
  * 상품 기본 정보 불러오기
  * 상품 정보 이미지의 경우 input의 label을 만들어서 원본 이미지명으로 표시
  * 수정 완료 후 해당 상품 판매 페이지로 이동
	
- 상품 등록 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/controller/ProductAdminController.java#L41)
  * [Service](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/model/service/ProductAdminServiceImpl.java#L28)
  * [DAO](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/model/dao/ProductAdminDAO.java#L27)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/productAdmin-mapper.xml#L88)
	
- 상품 수정 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/controller/ProductAdminController.java#L144)
  * [Service](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/model/service/ProductAdminServiceImpl.java#L141)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/productAdmin-mapper.xml#L220)
	
<br>
<br>

### 4.3. 쇼핑몰 상품 재고관리
<img src="https://user-images.githubusercontent.com/110653575/217525269-223614a9-bec0-46db-ac1a-3c0b76ef7af4.JPG" width="50%"> 

<br>

- 판매자 재고관리 페이지에서 입/출고 비동기 구현
  * 보유재고 / 실재고 변경
  * 판매상태 변경 비동기 구현(판매중 / 품절)
- trigger를 통해 제품 최초입고/판매/관리자입고/관리자출고/주문취소에 따른 실시간 재고 반영
	
- 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/controller/ProductAdminController.java#L71)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/productAdmin-mapper.xml#L186)
  
  * Trigger
~~~sql
CREATE OR REPLACE TRIGGER STOCK_TRG
AFTER INSERT ON STOCK_HISTORY
FOR EACH ROW
	BEGIN
		-- 0:최초입고
		IF :NEW.STOCK_STATUS = 0
		THEN 
			UPDATE PRODUCT SET STOCK = STOCK + :NEW.PRODUCT_AMOUNT
			WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
		END IF;
		-- 1:판매
		IF :NEW.STOCK_STATUS = 1
		THEN 
			UPDATE PRODUCT SET STOCK = STOCK - :NEW.PRODUCT_AMOUNT
			WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
		END IF;
		-- 2:관리자 입고
		IF :NEW.STOCK_STATUS = 2
		THEN 
			UPDATE PRODUCT SET STOCK = STOCK + :NEW.PRODUCT_AMOUNT
			WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
		END IF;
		-- 3:관리자 출고
		IF :NEW.STOCK_STATUS = 3
		THEN 
			UPDATE PRODUCT SET STOCK = STOCK - :NEW.PRODUCT_AMOUNT
			WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
		END IF;
		-- 4:주문취소
		IF :NEW.STOCK_STATUS = 4
		THEN 
			UPDATE PRODUCT SET STOCK = STOCK + :NEW.PRODUCT_AMOUNT
			WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
		END IF;
	END;
/
~~~
	
<br>
<br>

	
### 4.4. 주문내역 기간조회/검색
<img src="https://user-images.githubusercontent.com/110653575/217525342-cbbb7234-0525-455f-8972-3eb4b4faa929.png" width="50%">

<br>

- 전체 주문내역 조회
  * 클릭 시 해당 주문 상세조회 모달 창 생성
  * 모달 창에서 주문상태 변경 가능
  * 주문완료 상태인 경우 송장번호 입력 활성화
- 기간 설정 및 검색 기능
  * 당월조회 / 전월조회 / 기간 선택조회 가능
  * 회원ID와 주문번호로 검색 가능(기간 설정 / 미설정 시 모두 가능)
- 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/productAdmin/controller/ProductAdminController.java#L210)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/productAdmin-mapper.xml#L309)
  * [JS](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/webapp/resources/js/productAdmin/productOrderList.js)

<br>
<br>

	
### 4.5. 주문내역 배송조회
<img src="https://user-images.githubusercontent.com/110653575/217525908-a947e9a1-d6a2-4407-a8ca-fd43246ecf12.png" width="50%">

<br>

- delivery-tracker api를 사용한 배송 추적
- 코드확인
  * [JS](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/webapp/resources/js/productAdmin/productOrderList.js#L666)

<br>
<br>

	
### 4.6. 판매자 페이지 상품조회
<img src="https://user-images.githubusercontent.com/110653575/217526110-b68d3a42-a493-472b-bfd6-ad4ca5f0f48b.jpeg" width="50%">
	
<br>

- 판매자가 본인의 판매자 페이지 접속 시
  * 판매상품 등록/수정/삭제 가능
  * 비동기로 판매 중인 상품 판매완료 처리
- 판매자의 판매상품 리스트 조회
  * 판매 중인 글만 보기 가능
  * 판매 중인 글만 볼 때 ajax로 pagination 구현
  
- 코드확인
  * [Controller](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/seller/controller/SellerController.java)
  * [Service](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/seller/model/service/SellerServiceImpl.java)
  * [DAO](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/java/edu/kh/farmfarm/seller/model/dao/SellerDAO.java)
  * [Mapper](https://github.com/Hyunjae/FarmFarm/blob/main/FarmFarm/src/main/resources/mappers/seller-mapper.xml)

<br>
<br>


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
  
