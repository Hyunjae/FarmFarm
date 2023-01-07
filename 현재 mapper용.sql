DROP TABLE STOCK;

CREATE TABLE "STOCK_HISTORY" (
	"STOCK_NO"	NUMBER		NOT NULL,
	"STOCK_STATUS"	VARCHAR2(10) NOT NULL CHECK("STOCK_STATUS" IN('입고', '출고')),
	"P_AMOUNT"	NUMBER		NOT NULL,
	"STOCK_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PRODUCT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "STOCK_HISTORY"."STOCK_NO" IS '입출고내역번호(SEQ_STOCK_NO)';

COMMENT ON COLUMN "STOCK_HISTORY"."STOCK_STATUS" IS '상품상태(입고, 출고)';

COMMENT ON COLUMN "STOCK_HISTORY"."P_AMOUNT" IS '입출고 개수';

COMMENT ON COLUMN "STOCK_HISTORY"."STOCK_DATE" IS '입출고일';

COMMENT ON COLUMN "STOCK_HISTORY"."PRODUCT_NO" IS '판매글 번호(SEQ_PRODUCT_NO)';

ALTER TABLE "STOCK_HISTORY" ADD CONSTRAINT "PK_STOCK_HISTORY" PRIMARY KEY (
	"STOCK_NO"
);

ALTER TABLE "STOCK_HISTORY" ADD CONSTRAINT "FK_PRODUCT_TO_STOCK_HISTORY_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE PRODUCT ADD(STOCK NUMBER DEFAULT 0 NOT NULL);

COMMENT ON COLUMN "PRODUCT"."STOCK" IS '상품재고';

ALTER TABLE FARMFARM.POST RENAME COLUMN TRADE_METHOD TO OPEN_DATE;
ALTER TABLE FARMFARM.POST MODIFY OPEN_DATE DATE DEFAULT SYSDATE;
COMMENT ON COLUMN FARMFARM.POST.OPEN_DATE IS '생산일';

ALTER TABLE STOCK_HISTORY ADD (SOLDOUT_FL CHAR(2) DEFAULT 'N' NOT NULL);

ALTER TABLE PRODUCT ADD (PRODUCT_MESSAGE VARCHAR2(500));

COMMENT ON COLUMN "STOCK_HISTORY"."SOLDOUT_FL" IS '품절여부(Y/N)';
COMMENT ON COLUMN "PRODUCT"."PRODUCT_MESSAGE" IS '상품 한줄 소개';


SELECT * FROM MEMBER;
SELECT * FROM ADDRESS;
SELECT * FROM CATEGORY;
COMMIT;

ALTER TABLE STOCK_HISTORY ADD(STOCK_STATUS NUMBER NOT NULL);
ALTER TABLE STOCK_HISTORY ADD CHECK(STOCK_STATUS IN(0, 1, 2, 3, 4));

COMMENT ON COLUMN "STOCK_HISTORY"."STOCK_STATUS" IS '내역분류(0:최초입고, 1:판매,  2:관리자입고, 3:관리자출고, 4:주문취소)';


INSERT INTO MEMBER VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user18', 'pass01!', '정숙자',
   '정정한정숙자', '01015152323', DEFAULT, DEFAULT, DEFAULT, NULL, NULL);
-- MEMBER ADDRESS 샘플 데이터(MEMBER 1명당 1개 필수)
INSERT INTO ADDRESS VALUES(SEQ_ADDRESS_NO.NEXTVAL, '서울시 중구 남대문로 120 그레이츠 청계 18층','Y', 18);

INSERT INTO MEMBER VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user19', 'pass01!', '김길자',
   '감자길자', '01033332323', DEFAULT, DEFAULT, DEFAULT, NULL, NULL);
-- MEMBER ADDRESS 샘플 데이터(MEMBER 1명당 1개 필수)
INSERT INTO ADDRESS VALUES(SEQ_ADDRESS_NO.NEXTVAL, '서울시 중구 남대문로 120 그레이츠 청계 19층','Y', 19);

INSERT INTO MEMBER VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user20', 'pass01!', '오우거',
   '오늘우리거위', '01015152323', DEFAULT, DEFAULT, DEFAULT, NULL, NULL);
-- MEMBER ADDRESS 샘플 데이터(MEMBER 1명당 1개 필수)
INSERT INTO ADDRESS VALUES(SEQ_ADDRESS_NO.NEXTVAL, '서울시 중구 남대문로 120 그레이츠 청계 20층','Y', 20);

INSERT INTO MEMBER VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user21', 'pass01!', '훌리건',
   '훌리쉿', '01023214423', DEFAULT, DEFAULT, DEFAULT, NULL, NULL);
-- MEMBER ADDRESS 샘플 데이터(MEMBER 1명당 1개 필수)
INSERT INTO ADDRESS VALUES(SEQ_ADDRESS_NO.NEXTVAL, '서울시 중구 남대문로 120 그레이츠 청계 21층','Y', 21);

INSERT INTO MEMBER VALUES(SEQ_MEMBER_NO.NEXTVAL, 'user22', 'pass01!', '진성왕',
   '진시황', '01055551234', DEFAULT, DEFAULT, DEFAULT, NULL, NULL);
-- MEMBER ADDRESS 샘플 데이터(MEMBER 1명당 1개 필수)
INSERT INTO ADDRESS VALUES(SEQ_ADDRESS_NO.NEXTVAL, '서울시 중구 남대문로 120 그레이츠 청계 22층','Y', 22);

SELECT * FROM PRODUCT;
SELECT * FROM CATEGORY_SUB;
COMMIT;

-- PRODUCT 샘플 데이터
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_NO.NEXTVAL, '봄느낌 가드닝 장갑', DEFAULT, 5000,
   DEFAULT, 6, 10, '상큼한 가드닝 장갑');

INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/가드닝장갑0.jpeg', 8, 0);
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/가드닝장갑1.jpeg', 8, 1);
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/가드닝장갑2.jpeg', 8, 2);


INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_NO.NEXTVAL, '원예 적과가위', DEFAULT, 13000,
   DEFAULT, 6, 10, '뭐든지 싹뚝싹뚝');
   
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/적과가위0.jpeg', 9, 0);
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/적과가위1.jpeg', 9, 1);
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/적과가위2.jpeg', 9, 2);
INSERT INTO PRODUCT_IMG VALUES(SEQ_PRODUCT_IMG_NO.NEXTVAL, 'resources/images/product/detail/적과가위3.jpeg', 9, 3);


SELECT * FROM POST;

-- POST 샘플 데이터
INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL, '태안 해풍맞은 햇 생강10키로 75,000원 주문받습니다.', 
'2022년  해풍맞고자란  햇생강  판매합니다.

키로  8,000원

10키로  75,000원  택배비 5,000원

이번주만이가격입니다.', 0, DEFAULT, 75000, SYSDATE, DEFAULT, 18, 809);

INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL, POST_TITLE, POST_CONTENT, DEFAULT, DEFAULT, UNIT_PRICE, DEFAULT, DEFAULT, MEMBER_NO, CATEGORY_NO, DEFAULT);

-- POST_IMG_NO, POST_IMG_ADDRESS , POST_NO , POST_IMG_ORDER 
INSERT INTO POST_IMG VALUES(SEQ_POST_IMG_NO.NEXTVAL, '/resources/images/post/postDetail/생강0', 18, 0);
INSERT INTO POST_IMG VALUES(SEQ_POST_IMG_NO.NEXTVAL, '/resources/images/post/postDetail/생강1', 9, 1);


INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL, '단단하고 맛있는 저장형 육쪽마늘', 
'안녕하세요

맛도 좋고 단단한 한지형 저장 육쪽마늘을 일부 판매합니다

70,000원에 회원님들께 판매하던거 그냥 많이 드시고 건강하시라고 

이제 몇접 안 남아서 1접 특품을 60,000원에 드리고 있어요

감사합니다

항상 행복하시고 건강하세요', 0, DEFAULT, 60000, SYSDATE, DEFAULT, 18, 809);

-- POST_IMG_NO, POST_IMG_ADDRESS , POST_NO , POST_IMG_ORDER 
INSERT INTO POST_IMG VALUES(SEQ_POST_IMG_NO.NEXTVAL, '/resources/images/post/postDetail/마늘0', 10, 0);
INSERT INTO POST_IMG VALUES(SEQ_POST_IMG_NO.NEXTVAL, '/resources/images/post/postDetail/마늘1', 9, 1);
INSERT INTO POST_IMG VALUES(SEQ_POST_IMG_NO.NEXTVAL, '/resources/images/post/postDetail/마늘2', 9, 2);


-- BOARD 게시글 샘플 데이터
-- BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_UPDATE_DATE, BOARD_VIEW,
-- BOARD_DEL_FL, MEMBER_NO, BOARD_TYPE_NO

INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, '양파가 자꾸 썩어요', '양파에게 좋은 말만 해줬는데 자꾸 썩어서 속상하네요. <br/>
무농약으로 키우고 싶은데 왜 자꾸 썩을까요? <br/>
농사 고수님들 도와주세요~~~', SYSDATE, NULL,
   0, 'N', 21, 3);
  
INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, '농사를 잘 짓고싶다면?', '키우는 작물에게 좋은 말을 해주세요. <br/>
당신의 한 마디에 힘이 나서 자랄 거에요. <br/>
나쁜 말을 하면 농작물은 힘이 없답니다~', SYSDATE, NULL,
   0, 'N', 22, 2);
  
INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, '고수익 보장!', '고수익 보장합니다.<br/>
언제까지 농사만 짓고 계실 건가요? <br/>
인생은 한 방! 연락주세요!', SYSDATE, NULL,
   0, 'N', 20, 2);
  
INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, '팜팜은 양심도 없나요?', '별로 좋지도 않은걸 왜 5만원씩 받아 먹나요?<br/>
너무 어이가 없네요. 기분 나빠서 여기서 못 사먹겠어요.<br/>
재수없어! ', SYSDATE, NULL,
   0, 'N', 20, 3);
  
INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL, '배가 고파요', '농산물 무료나눔 하실 분 구합니다. <br/>
직접 재배하신 농산물만 무료나눔 받습니다. <br/>
이번 기회에 좋은 일 좀 해보세요!', SYSDATE, NULL,
   0, 'N', 18, 1);
   


-- COMMENT 샘플 데이터 삽입
-- COMMENT_NO, COMMENT_CONTENT, COMMENT_DATE, COMMENT_PARENT, COMMENT_DEL_FL, MEMBER_NO, BOARD_NO
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '솔깃하네요 혹시 무슨 방법인가요?', DEFAULT, NULL, 'N', 13, 4);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '저희 집은 양파가 많이 남는데 교환 가능할까요?', DEFAULT, NULL, 'N', 17, 14);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '저는 그냥 비료를 주고있어요.', DEFAULT, NULL, 'N', 20, 17);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '징그러워요 너무 큰데 대체 뭘 먹이신거죠?', DEFAULT, NULL, 'N', 22, 36);
INSERT INTO "COMMENT" VALUES(SEQ_COMMENT_NO.NEXTVAL, '부러워요~', DEFAULT, NULL, 'N', 16, 36);

SELECT * FROM "COMMENT";  
SELECT * FROM PRODUCT;
SELECT * FROM REVIEW;
SELECT * FROM REVIEW_IMG;

INSERT INTO SELLER VALUES(18, '/resources/images/seller/18번회원인증.jpeg');



-- REVIEW 샘플 데이터 삽입
-- REVIEW_NO, REVIEW_CONTENT, REVIEW_DEL_FL, MEMBER_NO, PRODUCT_NO
INSERT INTO REVIEW VALUES(SEQ_REVIEW_NO.NEXTVAL, '장갑 실물이 더 예뻐요~', DEFAULT, 6, 8);
INSERT INTO REVIEW VALUES(SEQ_REVIEW_NO.NEXTVAL, '분갈이를 하려고 배양토를 샀어요. 잘 자랄 것 같아요 ^^', DEFAULT, 6, 7);
INSERT INTO REVIEW VALUES(SEQ_REVIEW_NO.NEXTVAL, '깻잎이 벌써 이만큼 자랐어요~ 신선한 상품 감사합니다^^', DEFAULT, 13, 1);

--REVIEW_IMG 샘플 데이터 삽입
-- REVIEW_IMG_NO, REVIEW_NO, REVIEW_IMG_PATH, REVIEW_IMG_ORDER
INSERT INTO REVIEW_IMG VALUES(SEQ_REVIEW_IMG_NO.NEXTVAL, 5, '/resources/images/product/review/지렁이배양토.png', 0);
INSERT INTO REVIEW_IMG VALUES(SEQ_REVIEW_IMG_NO.NEXTVAL, 21, '/resources/images/product/review/깻잎리뷰.jpeg', 0);



SELECT MEMBER_NAME, MEMBER_NICKNAME, PROFILE_IMG,
	TO_CHAR(SIGNUP_DATE, 'YYYY-MM-DD') SIGNUP_DATE,
	(SELECT COUNT(*) FROM POST P 
	WHERE P.MEMBER_NO = M.MEMBER_NO
	AND POST_DEL_FL='N') POST_COUNT
FROM MEMBER M
WHERE M.MEMBER_NO=18;

SELECT COUNT(*)
FROM POST
WHERE MEMBER_NO=1
AND POST_DEL_FL='N';

-- 판매글 목록
SELECT POST_NO, POST_TITLE, UNIT_PRICE, POST_VIEW, POST_IMG_ADDRESS,POST_SOLDOUT_FL,
	TO_CHAR(POST_DATE, 'YYYY-MM-DD') POST_DATE, POST_DEL_FL
FROM POST
LEFT JOIN POST_IMG USING(POST_NO)
WHERE MEMBER_NO=1
AND POST_IMG_ORDER=0
AND POST_DEL_FL='N'
ORDER BY POST_DATE DESC ;

-- 2,4,6,8,9,12,34,35

SELECT * FROM POST
WHERE POST_DEL_FL ='N'
AND MEMBER_NO=18;

SELECT * FROM POST_IMG
WHERE POST_NO = 10;

-- 2,4,6,8,9,10, 12, 34, 35, 

ALTER TABLE POST ADD POST_SOLDOUT_FL NUMBER DEFAULT 0 NOT NULL;

ALTER TABLE FARMFARM.STOCK_HISTORY DROP(STOCK_STATUS);

ALTER TABLE PRODUCT_IMG ADD PRODUCT_IMG_ORIGINAL VARCHAR2(100);

UPDATE POST SET POST_DEL_FL='Y' WHERE POST_NO = 40;

-- 게시글 수정
UPDATE POST SET
POST_TITLE = ,
POST_CONTENT = 
WHERE POST_NO = ;


-- 이미지 수정
UPDATE POST_IMG SET
POST_IMG_ADDRESS =
WHERE POST_NO =
AND POST_IMG_ORDER =

-- 이미지 삽입
INSERT INTO POST_IMG 
VALUES(SEQ_POST_IMG_NO.NEXTVAL, #{postImgAddress}, #{postNo}, #{postImgOrder})


SELECT POST_NO , POST_TITLE , POST_CONTENT, CATEGORY_NO,
	TO_CHAR(UNIT_PRICE, '999,999,999,999') UNIT_PRICE, 
	TO_CHAR(OPEN_DATE, 'YYYY-MM-DD') OPEN_DATE
FROM POST
WHERE POST_NO = 2;


-- 팜팜 상품 관련 코드
-- 팜팜 판매글 수 조회
SELECT COUNT(*)
FROM PRODUCT;

-- 팜팜 판매글 리스트 조회
SELECT P.PRODUCT_NO, P.PRODUCT_NAME, PRODUCT_IMG_ADDRESS,
	STOCK, SOLDOUT_FL,
	TO_CHAR(REG_DATE, 'YYYY-MM-DD') REG_DATE,
	NVL((SELECT SUM(PRODUCT_AMOUNT) FROM ORDER_PRODUCT OP
	LEFT JOIN "ORDER" O ON O.ORDER_NO = OP.ORDER_NO
	WHERE ORDER_STATUS=0
	AND OP.PRODUCT_NO = P.PRODUCT_NO), 0) ORDER_SUM
FROM PRODUCT P
JOIN PRODUCT_IMG PI ON PI.PRODUCT_NO = P.PRODUCT_NO
WHERE PRODUCT_IMG_ORDER=0
AND PRODUCT_DEL_FL='N'
ORDER BY PRODUCT_NO DESC;

-- 재고관련 trigger
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

SELECT * FROM STOCK_HISTORY;
SELECT STOCK FROM PRODUCT WHERE PRODUCT_NO = 18;

INSERT INTO STOCK_HISTORY VALUES(SEQ_STOCK_NO.NEXTVAL, 1, DEFAULT, 18, 0);
INSERT INTO STOCK_HISTORY VALUES(SEQ_STOCK_NO.NEXTVAL, 3, DEFAULT, 18, 2);
INSERT INTO STOCK_HISTORY VALUES(SEQ_STOCK_NO.NEXTVAL, 1, DEFAULT, 18, 1);
INSERT INTO STOCK_HISTORY VALUES(SEQ_STOCK_NO.NEXTVAL, 1, DEFAULT, 18, 3);
INSERT INTO STOCK_HISTORY VALUES(SEQ_STOCK_NO.NEXTVAL, 1, DEFAULT, 18, 4);


UPDATE "PRODUCT" SET 
SOLDOUT_FL = 'Y'
WHERE PRODUCT_NO = 22;

SELECT COUNT(*)
FROM PRODUCT
WHERE PRODUCT_DEL_FL = 'N';


INSERT INTO CART VALUES(10, 23, 2);

SELECT COUNT(*)
FROM CART
WHERE MEMBER_NO = 10
AND PRODUCT_NO = 28;

SELECT PRODUCT_AMOUNT
FROM CART
WHERE MEMBER_NO = 10
AND PRODUCT_NO = 23;

UPDATE CART SET 
PRODUCT_AMOUNT = 4
WHERE MEMBER_NO = 10
AND PRODUCT_NO = 23;

SELECT C.PRODUCT_NO, PRODUCT_NAME, PRODUCT_AMOUNT, STOCK, SOLDOUT_FL,
	TO_CHAR(PRODUCT_PRICE, 'FM999,999,999,999') PRODUCT_PRICE,
	TO_CHAR(PRODUCT_PRICE*PRODUCT_AMOUNT, 'FM999,999,999,999') PRODUCT_TOTAL_PRICE,
	(SELECT PRODUCT_IMG_ADDRESS FROM PRODUCT_IMG PI
	WHERE PI.PRODUCT_NO = C.PRODUCT_NO
	AND PRODUCT_IMG_ORDER=0) PRODUCT_IMG
FROM CART C
JOIN PRODUCT P ON(C.PRODUCT_NO = P.PRODUCT_NO)
WHERE C.MEMBER_NO = 10;

UPDATE CART SET 
PRODUCT_AMOUNT = PRODUCT_AMOUNT +1
WHERE MEMBER_NO =10
AND PRODUCT_NO = 23;

DELETE FROM CART
WHERE MEMBER_NO =10
AND PRODUCT_NO = 23;


SELECT ADDRESS_NO, DEFAULT_FL, MEMBER_NAME, MEMBER_TEL, REPLACE(MEMBER_ADDRESS, ',,', ' ') MEMBER_ADDRESS2
FROM ADDRESS
JOIN MEMBER USING(MEMBER_NO)
WHERE MEMBER_NO = 10
ORDER BY DEFAULT_FL DESC;

INSERT INTO ADDRESS VALUES
(SEQ_ADDRESS_NO.NEXTVAL, '02013,,서울 노원구 상계동 어딘가,,1', 'N',10);

UPDATE ADDRESS SET DEFAULT_FL='Y'
WHERE MEMBER_NO = 10
AND ADDRESS_NO = 10;


DELETE FROM ADDRESS WHERE ADDRESS_NO = 

DELETE FROM CART 
WHERE PRODUCT_NO IN (19,28)
AND MEMBER_NO=10;

SELECT ORDER_NO, ORDER_STATUS, MEMBER_NO, MEMBER_ID, 
	TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') ORDER_DATE,
	TO_CHAR(ORDER_PRICE, '999,999,999,999') ORDER_PRICE,
	(SELECT COUNT(*) FROM ORDER_PRODUCT OP
	WHERE O.ORDER_NO = OP.ORDER_NO) PRODUCT_COUNT,
	TO_CHAR((SELECT SUM(PRODUCT_PRICE*PRODUCT_AMOUNT)
	FROM ORDER_PRODUCT OP
	JOIN PRODUCT USING(PRODUCT_NO)
	WHERE O.ORDER_NO = OP.ORDER_NO), '999,999,999,999') PRODUCT_SUM
FROM "ORDER" O
JOIN MEMBER USING(MEMBER_NO)
WHERE MEMBER_ID LIKE '%user%'
ORDER BY ORDER_NO DESC;


SELECT COUNT(ORDER_NO) FROM ORDER_PRODUCT
GROUP BY ORDER_NO;


SELECT COUNT(*) FROM "ORDER"
JOIN MEMBER USING(MEMBER_NO)
WHERE ORDER_NO LIKE '%16%';


SELECT SUM(PRODUCT_PRICE*PRODUCT_AMOUNT)
FROM ORDER_PRODUCT
JOIN PRODUCT USING(PRODUCT_NO)
GROUP BY ORDER_NO;

DELETE FROM "ORDER"
WHERE ORDER_NO IN (54,55,56); 



SELECT ORDER_NO, ORDER_STATUS, INVOICE_NO, MEMBER_NAME, MEMBER_TEL,
	ORDER_ADDRESS,TO_CHAR(ORDER_DATE, 'YYYY-MM-DD HH:mm:ss') ORDER_DATE
FROM "ORDER" O
LEFT JOIN MEMBER USING(MEMBER_NO)
LEFT JOIN ORDER_SHIPPING USING(ORDER_NO)
WHERE ORDER_NO = 6;


SELECT PRODUCT_PRICE, PRODUCT_AMOUNT, PRODUCT_NAME, PRODUCT_IMG_ADDRESS, PRODUCT_STATUS
FROM ORDER_PRODUCT
JOIN PRODUCT USING (PRODUCT_NO)
JOIN PRODUCT_IMG USING (PRODUCT_NO)
WHERE ORDER_NO=67
AND PRODUCT_IMG_ORDER=0;

UPDATE "ORDER" SET ORDER_STATUS = 1
WHERE ORDER_NO = 66;


INSERT INTO ORDER_CANCEL VALUES(67, 0, 0);
INSERT INTO ORDER_CANCEL VALUES(65, 1, 1);


INSERT INTO ORDER_SHIPPING VALUES (9,123413);
UPDATE "ORDER" SET ORDER_STATUS = 1 WHERE ORDER_NO = 9;


 PRODUCT_NAME, PRODUCT_AMOUNT, PRODUCT_AMOUNT*PRODUCT_PRICE,
 

SELECT RETURN_NO, ORDER_NO, RETURN_STATUS,RETURN_REASON, PRODUCT_NO,
		PRODUCT_NAME, PRODUCT_AMOUNT, PRODUCT_PRICE, ACCOUNT_NAME, ACCOUNT_NO
FROM RETURN
RIGHT JOIN RETURN_PRODUCT USING(RETURN_NO)
LEFT JOIN PRODUCT USING(PRODUCT_NO)
WHERE RETURN_NO = 40;

SELECT COUNT(*)
FROM RETURN
WHERE RETURN_STATUS = 0;

SELECT SUM(PRODUCT_PRICE*PRODUCT_AMOUNT)
FROM RETURN_PRODUCT
JOIN PRODUCT USING(PRODUCT_NO)
GROUP BY RETURN_NO;


SELECT RETURN_NO, ORDER_NO, RETURN_STATUS, RETURN_REASON,
	(SELECT COUNT(*) FROM RETURN_PRODUCT
	WHERE RETURN_NO = R.RETURN_NO) RETURN_AMOUNT,
	MEMBER_NO, MEMBER_ID,
	(SELECT SUM(PRODUCT_PRICE*PRODUCT_AMOUNT)
	FROM RETURN_PRODUCT
	JOIN PRODUCT USING(PRODUCT_NO)
	WHERE RETURN_NO = R.RETURN_NO
	GROUP BY RETURN_NO) RETURN_SUM
FROM RETURN R
JOIN "ORDER" USING (ORDER_NO)
JOIN MEMBER USING(MEMBER_NO);

SELECT COUNT(*)
FROM RETURN;


SELECT REPLACE(MEMBER_ADDRESS, ',,', ' ') MEMBER_ADDRESS2 FROM ADDRESS WHERE ADDRESS_NO=10;

UPDATE RETURN SET RETURN_STATUS = 1 WHERE RETURN_NO = 37;

CREATE OR REPLACE TRIGGER P_STATUS
AFTER UPDATE ON "RETURN"
FOR EACH ROW 
   BEGIN
      IF :NEW.RETURN_STATUS=1
      THEN 
         UPDATE "ORDER_PRODUCT" 
            SET PRODUCT_STATUS = 2
         WHERE PRODUCT_NO IN 
                (SELECT PRODUCT_NO 
                FROM "RETURN_PRODUCT"
                WHERE RETURN_NO = :NEW.RETURN_NO)
         AND ORDER_NO = :NEW.ORDER_NO;
      END IF;
      IF :NEW.RETURN_STATUS=2
      THEN 
         UPDATE "ORDER_PRODUCT"
            SET PRODUCT_STATUS = 3
         WHERE PRODUCT_NO IN 
                (SELECT PRODUCT_NO 
                FROM "RETURN_PRODUCT"
                WHERE RETURN_NO = :NEW.RETURN_NO)
         AND ORDER_NO = :NEW.ORDER_NO;
      END IF;   
END;
/
/


COMMIT;


SELECT PRODUCT_NO FROM RETURN_PRODUCT
WHERE RETURN_NO = 3
			
SELECT * FROM ORDER_PRODUCT;


UPDATE CART C
SET PRODUCT_AMOUNT =
	(SELECT STOCK FROM PRODUCT P
	WHERE C.PRODUCT_NO = P.PRODUCT_NO)
WHERE PRODUCT_AMOUNT > 
	(SELECT STOCK FROM PRODUCT P
	WHERE C.PRODUCT_NO = P.PRODUCT_NO
	AND SOLDOUT_FL = 'N')
AND MEMBER_NO=2;

SELECT C.PRODUCT_NO, PRODUCT_AMOUNT, STOCK, SOLDOUT_FL
FROM CART C
JOIN PRODUCT P ON C.PRODUCT_NO = P.PRODUCT_NO 
WHERE PRODUCT_AMOUNT > 
	(SELECT STOCK FROM PRODUCT P
	WHERE C.PRODUCT_NO = P.PRODUCT_NO
	AND SOLDOUT_FL = 'N')
AND MEMBER_NO = 2;

SELECT * FROM POST
WHERE MEMBER_NO= 1
AND POST_DEL_FL='N';

DELETE POST WHERE POST_NO=17;


SELECT COUNT(*)
FROM POST
WHERE MEMBER_NO= 1
AND POST_DEL_FL='N'
AND POST_SOLDOUT_FL=0;
	
-- 판매중인 글 리스트 --
SELECT POST_NO, POST_TITLE, UNIT_PRICE, POST_VIEW, POST_IMG_ADDRESS,
	TO_CHAR(POST_DATE, 'YYYY-MM-DD') POST_DATE, MEMBER_NO
FROM POST
JOIN POST_IMG USING(POST_NO)
WHERE MEMBER_NO= 1
AND POST_IMG_ORDER=0
AND POST_DEL_FL='N'
AND POST_SOLDOUT_FL=0
ORDER BY POST_DATE DESC;



SELECT * FROM "MEMBER" m WHERE AUTHORITY =1;