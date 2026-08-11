/*=============================================================
  WEEK 2 보완. week2_rfm_derived.sas 에서 다루지 않은
  검증 항목 추가분
  전제: week2_rfm_derived.sas 를 먼저 실행해서
        proj.sales_with_disc / rfm_base / customer_features 가
        이미 생성되어 있어야 함
=============================================================*/

libname proj "/home/student/open";


/* -------------------------------------------------------------
   1. 미구매 고객(거래 이력 없는 고객) 규모 파악
   [존재 이유]
   rfm_base는 sales_with_disc(거래 테이블)를 group by 고객ID로
   만들기 때문에, Customer_info엔 있지만 한 번도 구매하지 않은
   고객은 통째로 빠짐. 3주차 군집분석엔 문제없지만(거래 있는
   고객만 세그먼트 대상), 5주차 이탈예측 관점에서는 "전혀
   구매하지 않은 고객"이 가장 극단적인 이탈 케이스일 수 있으므로
   지금 규모를 파악해서 5주차에 별도 처리할지 미리 결정해야 함
------------------------------------------------------------- */
proc sql;
    select
        (select count(distinct 고객ID) from proj.cust_raw)   as Customer_info_전체고객수,
        (select count(distinct 고객ID) from proj.rfm_base)   as RFM_포함고객수,
        calculated Customer_info_전체고객수 - calculated RFM_포함고객수 as 미구매_고객수;
    title "1. Customer_info 대비 RFM 미포함(미구매) 고객수";
quit;
title;

/* 미구매 고객 목록 자체를 별도 테이블로 보존 (5주차에서 활용 가능) */
proc sql;
    create table proj.customer_no_purchase as
    select b.고객ID, b.성별, b.고객지역, b.가입기간
    from proj.cust_raw as b
    left join proj.rfm_base as a
        on b.고객ID = a.고객ID
    where a.고객ID is missing;
quit;

proc print data=proj.customer_no_purchase(obs=10);
    title "1-1. 미구매 고객 샘플 (상위 10건)";
run;
title;


/* -------------------------------------------------------------
   2. RFM 왜도(Skewness)/첨도(Kurtosis) 확인
   [존재 이유]
   Monetary·Frequency는 일반적으로 소수 고객이 매우 큰 값을
   가지는 오른쪽 꼬리 분포(right-skewed)를 보임. 왜도가 크게
   치우쳐 있으면 3주차 PROC STDIZE 단순 표준화만으로는 부족하고
   로그변환(log1p) 등 사전 처리가 필요할 수 있으므로, 표준화
   방법을 정하기 전에 반드시 확인해야 함
------------------------------------------------------------- */
proc means data=proj.rfm_base skewness kurtosis;
    var Recency Frequency Monetary AvgOrderValue;
    title "2. RFM 변수 왜도/첨도 (절대값 1 이상이면 변환 검토 대상)";
run;
title;


/* -------------------------------------------------------------
   3. 쿠폰상태 비율 합계 검증 (Used + Clicked + NotUsed = 1)
   [존재 이유]
   CouponUseRate·CouponClickRate는 CASE WHEN 로직으로 각각
   별도 계산됨. 만약 쿠폰상태 값에 오타나 새로운 카테고리가
   섞여 있으면 두 비율의 합이 1보다 작아지는데, 이 방식으로는
   눈에 안 띄므로 별도로 검증해야 로직 오류를 놓치지 않음
------------------------------------------------------------- */
proc sql;
    create table proj.coupon_rate_check as
    select
        고객ID,
        CouponUseRate,
        CouponClickRate,
        1 - CouponUseRate - CouponClickRate as CouponNotUsedRate_역산
    from proj.rfm_base;
quit;

proc means data=proj.coupon_rate_check min max;
    var CouponNotUsedRate_역산;
    title "3. 쿠폰 미사용률(역산) 범위 확인 (0~1 벗어나면 쿠폰상태에 예상 못한 값 존재)";
run;
title;


/* -------------------------------------------------------------
   4. customer_features - 가입기간 결측 확인
   [존재 이유]
   week2_rfm_derived.sas 3-2에서는 성별·고객지역 결측만
   확인하고 가입기간은 빠져 있음. 가입기간은 3주차 군집
   프로파일링과 5주차 이탈예측 변수 후보로 모두 쓰일 수 있어
   결측이면 두 단계 모두에 영향을 주므로 별도로 확인해야 함
------------------------------------------------------------- */
proc sql;
    select
        count(*) as 고객수,
        sum(case when 가입기간 is missing then 1 else 0 end) as 가입기간_결측건수
    from proj.customer_features;
    title "4. customer_features 가입기간 결측 확인";
quit;
title;


/* -------------------------------------------------------------
   5. Monetary(총구매금액) 음수/0 여부 확인
   [존재 이유]
   거래금액 = 평균금액 * 수량으로 계산됨. week1에서 평균금액<=0인
   행은 이미 제외했지만, 수량이 음수(반품)인 행은 is_return
   플래그만 붙이고 남겨뒀으므로 이론상 거래금액이 음수가 될 수
   있음. 1주차 실측 결과 반품 0건으로 확인되었지만, 코드 상
   구조적으로 가능한 경우이므로 재확인해두는 것이 안전함
------------------------------------------------------------- */
proc sql;
    select
        sum(case when Monetary < 0 then 1 else 0 end) as Monetary_음수_고객수,
        sum(case when Monetary = 0 then 1 else 0 end) as Monetary_0_고객수
    from proj.rfm_base;
    title "5. Monetary 음수/0 고객수 (0건이어야 정상)";
quit;
title;
