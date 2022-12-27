<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="review-form-container hide" id='reviewFormContainer'>
      <form class="review-form" id="reviewFrom" >
        <div class="review-head">
          <button type="button" class="back-btn">
            <i class="fa-solid fa-chevron-left"></i>
          </button>
          <span class="review-head-title">후기 작성</span>
          <span class="empty"></span>
        </div>
        <div class="review-product-preview">
          <div class="product-thumbnail" >
            <img
              src="/resources/images/product/thumbnail/productThumbnail.png"
              alt=""
              id="modalProductThumbnail"
            />
          </div>
          <div class="product-name" >
            <a href="/product/1" id="modalProductName">[이연복의 목란] 짬뽕 2인분</a>
            <input type="hidden" name="productNo" id="productNoInput"/>
          </div>
        </div>
        <div class="review-write-area">
          <div class="review-write-head">
            <span>자세한 후기를 들려주세요</span>
            <span
              >작성 시 유의사항 <i class="fa-regular fa-circle-question"></i
            ></span>
          </div>
          <div class="review-write-content">
            <textarea name="reviewContent" id="reviewTextArea" cols="30" rows="10" required></textarea>
          </div>
          <div class="review-img-upload" id="imgUploadArea">
            <div class="review-one-img" id='reviewOneImg1'>
              <img class="review-img-thumbnail hide" id="reviewImg1"></img>
              <button type="button" class="x-btn fa-solid fa-xmark hide"></button>
              <label id="inputLabel" class="input-label"><i class="fa-solid fa-plus"></i>
                <input type="file" id="imgInput1" class="input-file" name="reviewImg"/>
              </label>
            </div>
            <div class="review-one-img" id='reviewOneImg2'>
              <img class="review-img-thumbnail hide" id="reviewImg2"></img>
              <button type="button" class="x-btn fa-solid fa-xmark hide"></button>
              <label id="inputLabel" class="input-label"><i class="fa-solid fa-plus"></i>
                <input type="file" id="imgInput2" class="input-file" name="reviewImg"/>
              </label>
            </div>
            <div class="review-one-img" id='reviewOneImg3'>
              <img class="review-img-thumbnail hide" id="reviewImg3"></img>
              <button type="button" class="x-btn fa-solid fa-xmark hide"></button>
              <label id="inputLabel" class="input-label"><i class="fa-solid fa-plus"></i>
                <input type="file" id="imgInput3" class="input-file" name="reviewImg"/>
              </label>
            </div>
            <div class="review-one-img" id='reviewOneImg4'>
              <img class="review-img-thumbnail hide" id="reviewImg4"></img>
              <button type="button" class="x-btn fa-solid fa-xmark hide"></button>
              <label id="inputLabel" class="input-label"><i class="fa-solid fa-plus"></i>
                <input type="file" id="imgInput4" class="input-file" name="reviewImg"/>
              </label>
            </div>
            <div class="review-one-img" id='reviewOneImg5'>
              <img class="review-img-thumbnail hide" id="reviewImg5"></img>
              <button type="button" class="x-btn fa-solid fa-xmark hide"></button>
              <label id="inputLabel" class="input-label"><i class="fa-solid fa-plus"></i>
                <input type="file" id="imgInput5" class="input-file" name="reviewImg"/>
              </label>
            </div>
          </div>
          <div class="review-notice">
            <p>
              사진은 최대 5장까지, 30MB 이하의 이미지만 업로드가 가능합니다.
            </p>
          </div>
          <div class="review-submit">
            <button type="button" id="submitBtn">등록하기</button>
          </div>
        </div>
      </form>
    </div>