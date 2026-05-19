<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="sub_visual" style="background-color: #003b70; display: flex; align-items: center; justify-content: center; min-height: 250px;">
    <div class="inner" style="text-align: center; color: #fff;">
        <h2 style="font-size: 40px; font-weight: bold; margin-bottom: 15px;">회원가입</h2>
        <p style="font-size: 18px; color: rgba(255, 255, 255, 0.8);">소셜 계정 추가 정보 입력</p>
    </div>
</div>

<div class="sub_content">
    <div class="inner" style="max-width: 600px; margin: 80px auto;">

        <div style="text-align: center; margin-bottom: 40px;">
            <h3 style="font-size: 24px; font-weight: bold; color: #333;">환영합니다, ${userLogin.mbrNm}님!</h3>
            <p style="color: #666; margin-top: 15px; line-height: 1.6;">
                안전한 서비스 이용 및 증명서 발급, 후원 내역 관리를 위해<br>
                추가 연락처 정보와 약관 동의가 필요합니다.
            </p>
        </div>

        <form id="extraInfoForm" style="background: #f8f9fa; padding: 40px; border-radius: 12px; border: 1px solid #e9ecef;">

            <div class="form-group" style="margin-bottom: 25px;">
                <label for="phone" style="display: block; font-weight: bold; margin-bottom: 10px; color: #333;">휴대전화 번호 <span style="color: #dc3545;">*</span></label>
                <input type="text" id="phone" name="phone" placeholder="'-' 없이 숫자만 입력" required
                       style="width: 100%; padding: 12px 15px; border: 1px solid #ced4da; border-radius: 6px; font-size: 16px;">
            </div>

            <div class="form-group" style="margin-bottom: 30px;">
                <label style="display: block; font-weight: bold; margin-bottom: 10px; color: #333;">마케팅 정보 수신 동의 (선택)</label>
                <div style="background: #fff; border: 1px solid #ced4da; padding: 15px; border-radius: 6px;">
                    <label style="cursor: pointer; display: flex; align-items: center; margin: 0;">
                        <input type="checkbox" name="marketingYn" value="Y" style="width: 20px; height: 20px; margin-right: 10px;">
                        <span style="color: #555;">이메일 및 SMS 홍보 정보 수신에 동의합니다.</span>
                    </label>
                </div>
            </div>

            <div style="text-align: center;">
                <button type="button" id="btnSubmitExtra"
                        style="width: 100%; padding: 16px; background: #005baa; color: #fff; font-size: 18px; font-weight: bold; border: none; border-radius: 6px; cursor: pointer; transition: background 0.3s;">
                    입력 완료 및 메인으로 이동
                </button>
            </div>
        </form>

    </div>
</div>

<script>
    $(document).ready(function() {
        $('#btnSubmitExtra').on('click', function() {
            var phone = $('#phone').val().trim();
            if(phone === '') {
                alert('휴대전화 번호를 입력해 주세요.');
                $('#phone').focus();
                return;
            }

            // 숫자만 입력되었는지 정규식 검사
            if(!/^[0-9]+$/.test(phone)) {
                alert('휴대전화 번호는 숫자만 입력해 주세요.');
                $('#phone').focus();
                return;
            }

            var formData = $('#extraInfoForm').serialize();

            $.ajax({
                url: '/oauth2/extraProc',
                type: 'POST',
                data: formData,
                success: function(res) {
                    alert('정보가 성공적으로 등록되었습니다.');
                    location.href = '/';
                },
                error: function(xhr) {
                    alert(xhr.responseText || '정보 등록 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />