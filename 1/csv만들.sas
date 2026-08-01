libname crm '/home/student/project/';

/* Customer_info_csv to Customer_info.sasdat 로 변환*/
PROC IMPORT DATAFILE="/home/student/project/csv/Customer_info.csv"
	OUT = crm.Customer_info 	/*shop라이브러리에 Customer_info만들기 */
	DBMS=csv 			/*csv파일 불러오기*/
	REPLACE;			/*덮어쓰기 가능하도록 하기위해서 */
	GETNAMES=YES; 		/*첫 행 컬럼이름으로 */
	GUESSINGROWS=1000;  /*데이터 타입 1000개 행을 보고 타입예측*/
	DATAROW=2; 			/*첫째행은 컬럼명이라서 2번째부터 시작 */
RUN;

/* Discount_info_csv to Discount_info.sasdat 로 변환*/
PROC IMPORT DATAFILE="/home/student/project/csv/Discount_info.csv"
	OUT = crm.Discount_info 	/*shop라이브러리에 Discount_info만들기 */
	DBMS=csv 			/*csv파일 불러오기*/
	REPLACE;			/*덮어쓰기 가능하도록 하기위해서 */
	GETNAMES=YES; 		/*첫 행 컬럼이름으로 */
	GUESSINGROWS=1000;  /*데이터 타입 1000개 행을 보고 타입예측*/
	DATAROW=2; 			/*첫째행은 컬럼명이라서 2번째부터 시작 */
RUN;

/* Marketing_info_csv to Marketing_info.sasdat 로 변환*/
PROC IMPORT DATAFILE="/home/student/project/csv/Marketing_info.csv"
	OUT = crm.Marketing_info 	/*shop라이브러리에 Marketing_info만들기 */
	DBMS=csv 			/*csv파일 불러오기*/
	REPLACE;			/*덮어쓰기 가능하도록 하기위해서 */
	GETNAMES=YES; 		/*첫 행 컬럼이름으로 */
	GUESSINGROWS=1000;  /*데이터 타입 1000개 행을 보고 타입예측*/
	DATAROW=2; 			/*첫째행은 컬럼명이라서 2번째부터 시작 */
RUN;

/* Onlinesales_info_csv to Onlinesales_info.sasdat 로 변환*/
PROC IMPORT DATAFILE="/home/student/project/csv/Onlinesales_info.csv"
	OUT = crm.Onlinesales_info 	/*shop라이브러리에 Onlinesales_info만들기 */
	DBMS=csv 			/*csv파일 불러오기*/
	REPLACE;			/*덮어쓰기 가능하도록 하기위해서 */
	GETNAMES=YES; 		/*첫 행 컬럼이름으로 */
	GUESSINGROWS=1000;  /*데이터 타입 1000개 행을 보고 타입예측*/
	DATAROW=2; 			/*첫째행은 컬럼명이라서 2번째부터 시작 */
RUN;

/* Tax_info_csv to Tax_info.sasdat 로 변환*/
PROC IMPORT DATAFILE="/home/student/project/csv/Tax_info.csv"
	OUT = crm.Tax_info 	/*shop라이브러리에 Tax_info만들기 */
	DBMS=csv 			/*csv파일 불러오기*/
	REPLACE;			/*덮어쓰기 가능하도록 하기위해서 */
	GETNAMES=YES; 		/*첫 행 컬럼이름으로 */
	GUESSINGROWS=1000;  /*데이터 타입 1000개 행을 보고 타입예측*/
	DATAROW=2; 			/*첫째행은 컬럼명이라서 2번째부터 시작 */
RUN;

DH수정한걸 dev에 넣기 