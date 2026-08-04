# sas_crm_pj
# 이커머스 고객 세분화 프로젝트 — 주차별 계획

> SAS 통계 프로시저 & 머신러닝 프로시저 기반 이커머스 라이프사이클 마케팅 솔루션
> SAS 자격증 포트폴리오용 (V1)

---

## Week 1 — 데이터 이해 및 정제
- [ ] `PROC CONTENTS`로 데이터 구조 파악
- [ ] `PROC MEANS` / `PROC FREQ`로 결측치·이상치 탐지 (B2B 대량구매, 음수 취소건 등)
- [ ] `DATA STEP`으로 데이터 정제

**산출물:** 정제 데이터셋(SAS Dataset), 데이터 프로파일링 보고서

---

## Week 2 — 파생변수 및 RFM 설계
- [ ] `PROC SQL`로 파생변수 생성 (최근 방문일, 평균 주문 간격, 카테고리별 구매 비중 등)
- [ ] 회원/비회원 세그먼트 분리

**산출물:** RFM 지표 테이블, ML 파생 변수 명세서

---

## Week 3 — 군집화 모델링
- [ ] `PROC STDIZE`로 표준화
- [ ] `PROC FASTCLUS`로 K-Means 군집화
- [ ] CCC / Pseudo-F 통계량으로 최적 군집 수(K) 탐색

**산출물:** K-Means 군집화 결과 (Cluster ID 부여 데이터셋)

---

## Week 4 — 코호트 분석 & 군집 결합
- [ ] `PROC SQL` 코호트 집계
- [ ] `PROC SGPLOT`으로 히트맵 시각화
- [ ] 군집 × 코호트 이탈 변곡점 교차분석

**산출물:** 코호트 리텐션 히트맵 및 분석 보고서

---

## Week 5 — 이탈 예측 모델링
- [ ] 30일 내 비활성화 여부 타겟변수(Y) 정의
- [ ] `PROC PARTITION`으로 train/valid 분할
- [ ] `PROC GRADBOOST` 모델 학습

**산출물:** 이탈 예측 모델 (Score Code 포함)

---

## Week 6 — 모델 평가 및 해석
- [ ] ROC/AUC 평가 (`PROC LOGISTIC` ROC문 또는 Viya 평가 리포트)
- [ ] 변수 중요도 및 PDP(Partial Dependence Plot) 분석

**산출물:** 성능 평가서(AUC-ROC, Recall), 주요 이탈 요인 리포트

---

## Week 7 — 연관 분석
- [ ] `PROC ASSOC`로 세그먼트별 상위 연관 상품 도출 (Lift 기준 정렬)

**산출물:** 세그먼트별 연관 규칙 리스트

---

## Week 8 — 액션 플랜 및 최종 보고서
- [ ] 이탈 확률 기반 자동 프로모션 트리거 시나리오 설계
- [ ] ROI · AOV · LTV 시뮬레이션
- [ ] 최종 보고서 및 발표자료 정제

**산출물:** SAS 기반 실행 기획서(최종안), 파이프라인 통합 보고서

---

## 참고: 핵심 SAS 프로시저 매핑

| 구분 | 학습 방식 | SAS 프로시저 | 역할 |
| --- | --- | --- | --- |
| 고객 세분화 (Who) | 비지도 학습 | `PROC STDIZE` + `PROC FASTCLUS` | RFM 표준화 후 K-Means 군집화 |
| 이탈 예측 (When) | 지도 학습 | `PROC GRADBOOST` / `PROC LOGISTIC` | 이탈 확률 예측 |
| 설명력 분석 (Why) | 모델 해석 | 변수중요도 + `PROC SGPLOT` | 주요 이탈 요인 시각화 |
| 장바구니 분석 (What) | 연관 규칙 | `PROC ASSOC` | 크로스셀링 상품 도출 |
| 코호트 분석 | 집계 통계 | `PROC SQL` + `PROC TABULATE`/`PROC SGPLOT` | 잔존율 히트맵 |

---

## KPI 목표치 (가설 단계 — 5~6주차 실측 후 갱신 예정)
- 이탈 예측 모델 AUC-ROC ≥ 0.85, Recall ≥ 0.80
- M+1, M+3 잔존율 %p 향상
- 2차 이상 재구매 전환율 % 증가
- 타겟 프로모션 집행 대비 매출 증대 비율(ROI)
