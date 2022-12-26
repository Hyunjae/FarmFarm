SELECT c.COMMENT_NO, c.COMMENT_CONTENT , c.COMMENT_DATE , c.BOARD_NO , b.BOARD_TITLE ,
	(SELECT COUNT(*) FROM "COMMENT" c2 WHERE c2.BOARD_NO = b.BOARD_NO) COMMENT_COUNT 
	FROM "COMMENT" c
	JOIN BOARD b ON (c.BOARD_NO = b.BOARD_NO)
	WHERE c.MEMBER_NO = 16
	ORDER BY c.COMMENT_DATE DESC
;

SELECT COUNT(*) FROM "COMMENT"
	WHERE MEMBER_NO = 16
	
-- 대분류, 상품 번호, 상품 이름, 등록일, 상품 가격, 재고, 상품 한 줄 설명, 찜여부
SELECT PRODUCT_NO, PRODUCT_NAME, REG_DATE, SOLDOUT_FL,
	TO_CHAR(PRODUCT_PRICE, 'FM999,999,999,999')||'원' PRODUCT_PRICE, 
	(STOCK - (SELECT SUM(PRODUCT_AMOUNT) 
	FROM "ORDER" 
	JOIN ORDER_PRODUCT op USING(ORDER_NO) 
	WHERE op.PRODUCT_NO = p.PRODUCT_NO)) STOCK, 
	PRODUCT_MESSAGE, CATEGORY_NAME,
	(SELECT COUNT(*) FROM WISH w WHERE MEMBER_NO = 2 AND w.PRODUCT_NO = p.PRODUCT_NO) WISH_CHECK
FROM PRODUCT p
JOIN CATEGORY c USING(CATEGORY_NO)
WHERE PRODUCT_NO = 2



SELECT SUM(PRODUCT_AMOUNT) 
FROM "ORDER" 
JOIN ORDER_PRODUCT op USING(ORDER_NO) 
WHERE PRODUCT_NO = 2



SELECT * FROM PRODUCT_IMG pi2
WHERE PRODUCT_NO = 1

-- 리뷰 수 조회
SELECT COUNT(*) FROM REVIEW r 
WHERE PRODUCT_NO = 8;

-- 리뷰 목록 조회
	SELECT REVIEW_NO, REVIEW_CONTENT, MEMBER_NO , PRODUCT_NO, MEMBER_NICKNAME,
		 PROFILE_IMG, TO_CHAR(CREATE_DATE, 'yyyy.MM.DD') CREATE_DATE,
		(SELECT COUNT(*) FROM REVIEW_LIKE rl WHERE rl.MEMBER_NO = #{memberNo} AND rl.REVIEW_NO = r.REVIEW_NO) LIKE_CHECK,
		(SELECT COUNT(*) FROM REVIEW_LIKE rl2 WHERE rl2.REVIEW_NO = r.REVIEW_NO) LIKE_COUNT
	FROM REVIEW r 
	JOIN "MEMBER" m USING(MEMBER_NO)
	WHERE PRODUCT_NO = #{productNo} AND REVIEW_DEL_FL = 'N'	

-- 리뷰 상세 조회(도움돼요 클릭 여부 추가)
SELECT REVIEW_NO, REVIEW_CONTENT, MEMBER_NO , r.PRODUCT_NO, MEMBER_NICKNAME, PROFILE_IMG, PRODUCT_NAME,
TO_CHAR(CREATE_DATE, 'yyyy.MM.DD') CREATE_DATE,
(SELECT COUNT(*) FROM REVIEW_LIKE rl WHERE rl.MEMBER_NO = 3 AND rl.REVIEW_NO = r.REVIEW_NO) LIKE_CHECK,
(SELECT COUNT(*) FROM REVIEW_LIKE rl2 WHERE rl2.REVIEW_NO = r.REVIEW_NO) LIKE_COUNT,
(SELECT PRODUCT_IMG_ADDRESS FROM PRODUCT_IMG pi2 WHERE pi2.PRODUCT_NO = r.PRODUCT_NO AND PRODUCT_IMG_ORDER = 0) PRODUCT_THUMBNAIL
FROM REVIEW r 
JOIN "MEMBER" m USING(MEMBER_NO)
JOIN PRODUCT p ON (r.PRODUCT_NO = p.PRODUCT_NO)
WHERE REVIEW_NO =2 AND REVIEW_DEL_FL = 'N';

-- 리뷰 이미지 조회
SELECT * FROM REVIEW_IMG ri
JOIN REVIEW r USING(REVIEW_NO)
WHERE PRODUCT_NO = 8;

-- 리뷰 이미지 전체 목록 조회 order = 0인 것만
SELECT REVIEW_IMG_NO , REVIEW_NO , REVIEW_IMG_PATH FROM REVIEW_IMG ri 
JOIN REVIEW USING(REVIEW_NO)
JOIN PRODUCT p USING(PRODUCT_NO)
WHERE PRODUCT_NO = 8 AND REVIEW_IMG_ORDER = 0
AND REVIEW_DEL_FL = 'N'
ORDER BY REVIEW_NO DESC


-- 주문 개수 조회
SELECT COUNT(*) FROM "ORDER" WHERE MEMBER_NO = 16

-- 주문 목록 조회
SELECT DISTINCT ORDER_NO , 
TO_CHAR(ORDER_DATE, '') ORDER_DATE , ORDER_STATUS , MEMBER_NO , INVOICE_NO,
TO_CHAR(ORDER_PRICE, '999,999,999,999') ORDER_PRICE
FROM "ORDER"
JOIN ORDER_PRODUCT op USING(ORDER_NO)
WHERE MEMBER_NO = 16
ORDER BY ORDER_NO DESC

-- 주문 상품 목록 조회
SELECT op.PRODUCT_NO , op.PRODUCT_AMOUNT, PRODUCT_NAME, PRODUCT_PRICE,
	(SELECT PRODUCT_IMG_ADDRESS 
	FROM PRODUCT_IMG pi3 
	WHERE pi3.PRODUCT_NO = op.PRODUCT_NO 
	AND PRODUCT_IMG_ORDER = 0) PRODUCT_IMG
FROM ORDER_PRODUCT op 
JOIN PRODUCT p ON (op.PRODUCT_NO = p.PRODUCT_NO)
WHERE ORDER_NO = 6


SELECT * FROM PRODUCT_IMG pi2 WHERE PRoduct_no = 1




ALTER TABLE FARMFARM."ORDER" MODIFY INVOICE_NO VARCHAR2(200);


SELECT MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, 
		MEMBER_NICKNAME, MEMBER_TEL ,MEMBER_DEL_FL, AUTHORITY,
		PROFILE_IMG ,MYPAGE_IMG ,MEMBER_BIRTH, TO_CHAR(SIGNUP_DATE, 'yyyy"년" MM"월" DD"일"') SIGNUP_DATE,
		(SELECT COUNT(*) FROM BOARD b WHERE b.MEMBER_NO = m.MEMBER_NO) BOARD_COUNT,
		(SELECT COUNT(*) FROM "COMMENT" c WHERE c.MEMBER_NO = m.MEMBER_NO) COMMENT_COUNT,
		(SELECT COUNT(*) FROM "ORDER" o WHERE o.MEMBER_NO = m.MEMBER_NO) ORDER_COUNT,
		(SELECT MEMBER_ADDRESS FROM ADDRESS a WHERE a.MEMBER_NO = m.MEMBER_NO AND DEFAULT_FL = 'Y') MEMBER_ADDRESS
		FROM MEMBER m
		WHERE MEMBER_DEL_FL = 'N'
		AND MEMBER_ID = 'user16'

		
(SELECT * FROM ADDRESS a WHERE MEMBER_NO = 16 AND DEFAULT_FL = 'Y')
		

-- 게시글 수 조회
SELECT COUNT(*) FROM BOARD WHERE MEMBER_NO = 16 AND BOARD_DEL_FL = 'N'

-- 작성 게시글 목록 조회
SELECT BOARD_NO , SUBSTRB(BOARD_TITLE,1,75) BOARD_TITLE , 
	TO_CHAR(BOARD_DATE, 'yyyy.MM.DD') BOARD_DATE, BOARD_VIEW, BOARD_TYPE_NO,
	(SELECT COUNT(*) FROM "COMMENT" c WHERE c.BOARD_NO = b.BOARD_NO) COMMENT_COUNT,
	(SELECT BOARD_IMG_ADDRESS FROM BOARD_IMG bi WHERE bi.BOARD_NO = b.BOARD_NO AND BOARD_IMG_ORDER = 0) BOARD_THUMBNAIL
	FROM BOARD b WHERE MEMBER_NO = 4 AND BOARD_D

	EL_FL ='N';
	
SELECT * FROM BOARD_IMG bi WHERE BOARD_NO = 53 AND BOARD_IMG_ORDER = 0



-- 작성 후기 목록 조회
SELECT REVIEW_NO, REVIEW_CONTENT, PRODUCT_NO, PRODUCT_NAME, TO_CHAR(CREATE_DATE, 'yyyy.MM.DD') CREATE_DATE,
(SELECT COUNT(*) FROM REVIEW_LIKE rl WHERE rl.REVIEW_NO = r.REVIEW_NO) LIKE_COUNT
FROM REVIEW r
JOIN PRODUCT p USING(PRODUCT_NO)
WHERE r.MEMBER_NO = 3


-- 찜 수 조회
SELECT COUNT(*) FROM WISH WHERE MEMBER_NO = 16

-- 찜 목록 조회
SELECT PRODUCT_NO, PRODUCT_NAME, TO_CHAR(PRODUCT_PRICE, '999,999,999,999') PRODUCT_PRICE, WISH_DATE 
FROM WISH w 
JOIN PRODUCT p USING(PRODUCT_NO)
WHERE MEMBER_NO = 16


-- 작성 후기 목록 조회
	SELECT REVIEW_NO, REVIEW_CONTENT, PRODUCT_NO, PRODUCT_NAME, TO_CHAR(CREATE_DATE, 'yyyy.MM.DD') CREATE_DATE,
	(SELECT COUNT(*) FROM REVIEW_LIKE rl WHERE rl.REVIEW_NO = r.REVIEW_NO) LIKE_COUNT
	FROM REVIEW r
	JOIN PRODUCT p USING(PRODUCT_NO)
	WHERE r.MEMBER_NO = 16


-- 판매자 상품 조회
SELECT POST_NO , POST_TITLE , POST_CONTENT, POST_VIEW , 
TO_CHAR(UNIT_PRICE, '999,999,999,999') UNIT_PRICE ,
TO_CHAR(POST_DATE, 'yyyy.MM.DD') POST_DATE, 
TO_CHAR(OPEN_DATE, 'yyyy"년 "MM"월 "DD"일"') OPEN_DATE,
POST_SOLDOUT_FL, MEMBER_NO , MEMBER_NICKNAME, CATEGORY_SUB_NAME CATEGORY_NAME
FROM POST p
JOIN "MEMBER" m USING(MEMBER_NO)
JOIN CATEGORY_SUB cs ON (p.CATEGORY_NO = cs.CATEGORY_SUB_NO)
WHERE POST_NO = 2

-- 판매자 상품 이미지 조회
SELECT * FROM POST_IMG WHERE POST_NO = 2


-- 사진 리뷰 목록 조회(사진 1개)
SELECT DISTINCT REVIEW_NO
FROM REVIEW r 
JOIN PRODUCT_IMG pi2 ON (r.PRODUCT_NO = pi2.PRODUCT_NO)
WHERE r.PRODUCT_NO = 12
AND (SELECT COUNT(*) FROM REVIEW_IMG ri WHERE r.REVIEW_NO = ri.REVIEW_NO) > 0


SELECT MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, 
			MEMBER_NICKNAME, MEMBER_TEL ,MEMBER_DEL_FL, AUTHORITY,
			PROFILE_IMG ,MYPAGE_IMG ,MEMBER_BIRTH, TO_CHAR(SIGNUP_DATE, 'yyyy"년" MM"월" DD"일"') SIGNUP_DATE,
			(SELECT COUNT(*) FROM BOARD b WHERE b.MEMBER_NO = m.MEMBER_NO) BOARD_COUNT,
			(SELECT COUNT(*) FROM "COMMENT" c WHERE c.MEMBER_NO = m.MEMBER_NO) COMMENT_COUNT,
			(SELECT COUNT(*) FROM "ORDER" o WHERE o.MEMBER_NO = m.MEMBER_NO) ORDER_COUNT,
			REPLACE((SELECT MEMBER_ADDRESS FROM ADDRESS a WHERE a.MEMBER_NO = m.MEMBER_NO AND DEFAULT_FL = 'Y'), ',,', ' ') MEMBER_ADDRESS
		FROM MEMBER m
		WHERE MEMBER_DEL_FL = 'N'
		AND MEMBER_ID = 'user16'



SELECT MEMBER_NO , MEMBER_ADDRESS FROM ADDRESS WHERE MEMBER_NO = 16 AND 

ALTER TABLE FARMFARM.ADDRESS MODIFY DEFAULT_FL CHAR(1) DEFAULT 'N';



WHERE MEMBER_NO = 16 AND DEFAULT_FL = 'Y'


SELECT * FROM "MEMBER" m WHERE MEMBER_NO = 16
-- 멤버 마이페이지 배경사진 변경


UPDATE "MEMBER" SET MYPAGE_IMG = NULL WHERE MEMBER_NO = 16;