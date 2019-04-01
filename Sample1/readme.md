# Sample1 - 하나의 .tf 파일로 리소스 생성
간한단 인프라의 경우, 하나의 .tf 파일로 인프라를 제작하는 것이 효율적입니다.

## 사용되는 버전
    ```
    Terraform v0.11.13
    Azure providwe v1.23.0
    ```

## 생성되는 리소스
- Resource Group
- Storage Account
- App Servic Plan - Consumction Plan
- Function App
- Service Bus Namespace
- Service Bus Topic

## 참조하는 변수
- None

## 실습
1. terraform init을 이용하여 초기화 한다.
    ```terraform cli
    terraform init
    ```

2. .tf 파일이 정상인지 확인한다.
    ```terraform cli
    terraform plan
    ```

3. Azure에 Resource를 배포한다.
    ```terraform cli
    terraform apply -auto-approve
    ```